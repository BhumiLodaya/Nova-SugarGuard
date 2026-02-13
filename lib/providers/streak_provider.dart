import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/sugar_log_model.dart';
import 'auth_provider.dart';

// ─────────────────────────────────────────────────────────
//  Streak State
// ─────────────────────────────────────────────────────────

class StreakState {
  /// Number of consecutive days with at least one sugar log.
  final int currentStreak;

  /// Whether the user has logged at least once today.
  final bool loggedToday;

  /// Milestone reached (1, 3, 7, 30) — non-null when a new one is hit.
  final int? milestoneJustReached;

  const StreakState({
    this.currentStreak = 0,
    this.loggedToday = false,
    this.milestoneJustReached,
  });

  StreakState copyWith({
    int? currentStreak,
    bool? loggedToday,
    int? milestoneJustReached,
  }) =>
      StreakState(
        currentStreak: currentStreak ?? this.currentStreak,
        loggedToday: loggedToday ?? this.loggedToday,
        milestoneJustReached: milestoneJustReached,
      );

  /// Whether the streak is at risk (user hasn't logged today but has an
  /// existing streak worth protecting).
  bool get streakAtRisk => !loggedToday && currentStreak > 0;
}

// ─────────────────────────────────────────────────────────
//  Milestones
// ─────────────────────────────────────────────────────────

const _milestones = [1, 3, 7, 30];

// ─────────────────────────────────────────────────────────
//  Provider
// ─────────────────────────────────────────────────────────

final streakProvider =
    StateNotifierProvider<StreakNotifier, StreakState>((ref) {
  return StreakNotifier(ref);
});

class StreakNotifier extends StateNotifier<StreakState> {
  StreakNotifier(this._ref) : super(const StreakState()) {
    recalculate();
  }

  final Ref _ref;

  static const _sugarBoxName = 'sugar_log_box';

  Future<Box<SugarLogModel>> _openBox() async {
    if (Hive.isBoxOpen(_sugarBoxName)) {
      return Hive.box<SugarLogModel>(_sugarBoxName);
    }
    return await Hive.openBox<SugarLogModel>(_sugarBoxName);
  }

  /// Recalculate the streak from the persisted sugar logs.
  Future<void> recalculate() async {
    final userId = _ref.read(currentUserProvider)?.id;
    if (userId == null) {
      state = const StreakState();
      return;
    }

    final box = await _openBox();
    final allLogs = box.values
        .where((l) => l.userId == userId)
        .toList()
      ..sort((a, b) => b.loggedAt.compareTo(a.loggedAt));

    if (allLogs.isEmpty) {
      state = const StreakState();
      return;
    }

    // Build a set of calendar days (yyyy-mm-dd) that have logs.
    final loggedDays = <String>{};
    for (final log in allLogs) {
      loggedDays.add(_dayKey(log.loggedAt));
    }

    final now = DateTime.now();
    final todayKey = _dayKey(now);
    final bool loggedToday = loggedDays.contains(todayKey);

    // Walk backwards from today (or yesterday if not yet logged today)
    // counting consecutive days.
    int streak = 0;
    DateTime cursor = loggedToday
        ? DateTime(now.year, now.month, now.day)
        : DateTime(now.year, now.month, now.day)
            .subtract(const Duration(days: 1));

    while (loggedDays.contains(_dayKey(cursor))) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }

    // If user logged today and streak just grew, check milestones.
    int? milestone;
    if (loggedToday) {
      for (final m in _milestones) {
        if (streak == m) {
          milestone = m;
          break;
        }
      }
    }

    state = StreakState(
      currentStreak: streak,
      loggedToday: loggedToday,
      milestoneJustReached: milestone,
    );
  }

  /// Call after a new sugar log to update streak immediately.
  Future<void> onNewLog() => recalculate();

  static String _dayKey(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
}

// ─────────────────────────────────────────────────────────
//  Convenience providers
// ─────────────────────────────────────────────────────────

/// Current streak count.
final currentStreakCountProvider = Provider<int>((ref) {
  return ref.watch(streakProvider).currentStreak;
});

/// Whether the streak is at risk today.
final streakAtRiskProvider = Provider<bool>((ref) {
  return ref.watch(streakProvider).streakAtRisk;
});
