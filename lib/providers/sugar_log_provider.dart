import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/sugar_log_model.dart';
import '../services/guest_service.dart';
import '../services/sugar_insight_service.dart';
import 'auth_provider.dart';
import 'streak_provider.dart';

// ─────────────────────────────────────────────
//  Hive box name for sugar logs
// ─────────────────────────────────────────────
const _sugarBoxName = 'sugar_log_box';

Future<Box<SugarLogModel>> _openSugarBox() async {
  if (Hive.isBoxOpen(_sugarBoxName)) {
    return Hive.box<SugarLogModel>(_sugarBoxName);
  }
  return await Hive.openBox<SugarLogModel>(_sugarBoxName);
}

// ─────────────────────────────────────────────
//  Sugar-Spike Insight (returned after a log)
// ─────────────────────────────────────────────
class SugarInsightResult {
  final String shortTermImpact;
  final String correctiveAction;
  /// Input params used to generate this insight (for explainability).
  final double? bmi;
  final int? steps;
  final String? sugarType;

  const SugarInsightResult({
    required this.shortTermImpact,
    required this.correctiveAction,
    this.bmi,
    this.steps,
    this.sugarType,
  });
}

// ─────────────────────────────────────────────
//  State
// ─────────────────────────────────────────────
class SugarLogState {
  final List<SugarLogModel> todayLogs;
  final bool isLogging;
  final SugarLogModel? lastLog;
  final SugarInsightResult? lastInsight;
  final int totalXpToday;
  final double totalSugarToday;

  const SugarLogState({
    this.todayLogs = const [],
    this.isLogging = false,
    this.lastLog,
    this.lastInsight,
    this.totalXpToday = 0,
    this.totalSugarToday = 0,
  });

  SugarLogState copyWith({
    List<SugarLogModel>? todayLogs,
    bool? isLogging,
    SugarLogModel? lastLog,
    SugarInsightResult? lastInsight,
    int? totalXpToday,
    double? totalSugarToday,
  }) {
    return SugarLogState(
      todayLogs: todayLogs ?? this.todayLogs,
      isLogging: isLogging ?? this.isLogging,
      lastLog: lastLog ?? this.lastLog,
      lastInsight: lastInsight ?? this.lastInsight,
      totalXpToday: totalXpToday ?? this.totalXpToday,
      totalSugarToday: totalSugarToday ?? this.totalSugarToday,
    );
  }
}

// ─────────────────────────────────────────────
//  Provider
// ─────────────────────────────────────────────
final sugarLogProvider =
    StateNotifierProvider<SugarLogNotifier, SugarLogState>((ref) {
  return SugarLogNotifier(ref);
});

class SugarLogNotifier extends StateNotifier<SugarLogState> {
  SugarLogNotifier(this._ref) : super(const SugarLogState()) {
    _loadToday();
  }

  final Ref _ref;
  final GuestService _guest = GuestService();
  final SugarInsightService _insightService = SugarInsightService();

  // ---------- Load today's logs ----------
  Future<void> _loadToday() async {
    final box = await _openSugarBox();
    final userId = _currentUserId;
    if (userId == null) return;

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final todayLogs = box.values
        .where((log) =>
            log.userId == userId && log.loggedAt.isAfter(todayStart))
        .toList()
      ..sort((a, b) => b.loggedAt.compareTo(a.loggedAt));

    final totalSugar =
        todayLogs.fold<double>(0, (s, l) => s + l.estimatedSugarGrams);
    final totalXp = todayLogs.fold<int>(0, (s, l) => s + l.xpEarned);

    state = state.copyWith(
      todayLogs: todayLogs,
      totalSugarToday: totalSugar,
      totalXpToday: totalXp,
    );
  }

  String? get _currentUserId {
    final user = _ref.read(currentUserProvider);
    return user?.id;
  }

  // ---------- ONE-TAP LOG (must finish < 10s) ----------
  /// Logs a sugar preset. Returns `true` on success.
  Future<bool> quickLog(SugarPreset preset) async {
    final userId = _currentUserId;
    if (userId == null) return false;

    state = state.copyWith(isLogging: true);

    try {
      final box = await _openSugarBox();
      final now = DateTime.now();
      // Variable rewards: random XP between 10-25 for dopamine variance
      final xp = Random().nextInt(16) + 10; // 10..25 inclusive

      final log = SugarLogModel(
        id: const Uuid().v4(),
        userId: userId,
        loggedAt: now,
        sugarType: preset.type,
        label: preset.label,
        estimatedSugarGrams: preset.estimatedSugarGrams,
        estimatedCalories: preset.estimatedCalories,
        xpEarned: xp,
      );

      // Persist
      await box.put(log.id, log);

      // Increment guest counters (XP + sugar-log gate)
      await _guest.incrementSugarLogCount();
      await _guest.addXp(xp);

      // Fetch cause-effect insight from backend (fire-and-forget-safe)
      SugarInsightResult? insight;
      final user = _ref.read(currentUserProvider);
      final inputBmi = user?.bmi ?? 22.0;
      const inputSteps = 0; // TODO: wire in real step count from HealthMetric
      try {
        insight = await _insightService.getSugarInsight(
          sugarType: preset.type,
          bmi: inputBmi,
          steps: inputSteps,
        );
        // Attach input params for explainability
        insight = SugarInsightResult(
          shortTermImpact: insight.shortTermImpact,
          correctiveAction: insight.correctiveAction,
          bmi: inputBmi,
          steps: inputSteps,
          sugarType: preset.type,
        );
      } catch (_) {
        // Offline fallback — use local rule
        final fallback = _insightService.localFallbackInsight(preset.type);
        insight = SugarInsightResult(
          shortTermImpact: fallback.shortTermImpact,
          correctiveAction: fallback.correctiveAction,
          bmi: inputBmi,
          steps: inputSteps,
          sugarType: preset.type,
        );
      }

      // Reload today
      await _loadToday();

      // Update streak
      await _ref.read(streakProvider.notifier).onNewLog();

      state = state.copyWith(
        isLogging: false,
        lastLog: log,
        lastInsight: insight,
      );

      return true;
    } catch (e) {
      state = state.copyWith(isLogging: false);
      return false;
    }
  }

  /// Clear the "last log" state so the overlay can dismiss.
  void clearLastLog() {
    state = SugarLogState(
      todayLogs: state.todayLogs,
      isLogging: false,
      lastLog: null,
      lastInsight: null,
      totalXpToday: state.totalXpToday,
      totalSugarToday: state.totalSugarToday,
    );
  }

  void refresh() => _loadToday();
}

// ─────────────────────────────────────────────
//  Convenience providers
// ─────────────────────────────────────────────

/// Total sugar grams consumed today.
final todaySugarGramsProvider = Provider<double>((ref) {
  return ref.watch(sugarLogProvider).totalSugarToday;
});

/// Today's sugar-log count.
final todaySugarLogCountProvider = Provider<int>((ref) {
  return ref.watch(sugarLogProvider).todayLogs.length;
});
