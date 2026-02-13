import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/streak_provider.dart';
import '../../providers/sugar_log_provider.dart';

// ─────────────────────────────────────────────────────────
//  Mock leaderboard data model
// ─────────────────────────────────────────────────────────

class LeaderboardEntry {
  final String name;
  final String avatarEmoji;
  final int xp;
  final int streak;
  final int rank;
  final bool isCurrentUser;

  const LeaderboardEntry({
    required this.name,
    required this.avatarEmoji,
    required this.xp,
    required this.streak,
    required this.rank,
    this.isCurrentUser = false,
  });
}

// ─────────────────────────────────────────────────────────
//  Leaderboard Provider
// ─────────────────────────────────────────────────────────

final leaderboardProvider =
    FutureProvider.family<List<LeaderboardEntry>, _LeaderboardInput>(
        (ref, input) async {
  // Combine real user data with mock "global warriors"
  final mockWarriors = [
    LeaderboardEntry(
      name: 'SugarSlayer92',
      avatarEmoji: '🦸‍♀️',
      xp: 2450 + Random().nextInt(200),
      streak: 42,
      rank: 0,
    ),
    LeaderboardEntry(
      name: 'HealthyHero',
      avatarEmoji: '💪',
      xp: 1980 + Random().nextInt(150),
      streak: 28,
      rank: 0,
    ),
    LeaderboardEntry(
      name: 'WellnessWiz',
      avatarEmoji: '🧙‍♂️',
      xp: 1750 + Random().nextInt(100),
      streak: 21,
      rank: 0,
    ),
    LeaderboardEntry(
      name: 'FitFusion',
      avatarEmoji: '🏃‍♂️',
      xp: 1320 + Random().nextInt(100),
      streak: 15,
      rank: 0,
    ),
    LeaderboardEntry(
      name: 'NutriNinja',
      avatarEmoji: '🥷',
      xp: 980 + Random().nextInt(100),
      streak: 12,
      rank: 0,
    ),
    LeaderboardEntry(
      name: 'ZenMaster',
      avatarEmoji: '🧘',
      xp: 730 + Random().nextInt(100),
      streak: 9,
      rank: 0,
    ),
    LeaderboardEntry(
      name: 'VitalVibe',
      avatarEmoji: '✨',
      xp: 540 + Random().nextInt(80),
      streak: 6,
      rank: 0,
    ),
    LeaderboardEntry(
      name: 'PeakPerformer',
      avatarEmoji: '🏔️',
      xp: 420 + Random().nextInt(60),
      streak: 5,
      rank: 0,
    ),
  ];

  // Insert the real user
  final currentUser = LeaderboardEntry(
    name: input.userName,
    avatarEmoji: '🌟',
    xp: input.xp,
    streak: input.streak,
    rank: 0,
    isCurrentUser: true,
  );

  final all = [...mockWarriors, currentUser];
  all.sort((a, b) => b.xp.compareTo(a.xp));

  // Assign ranks
  return List.generate(all.length, (i) {
    final e = all[i];
    return LeaderboardEntry(
      name: e.name,
      avatarEmoji: e.avatarEmoji,
      xp: e.xp,
      streak: e.streak,
      rank: i + 1,
      isCurrentUser: e.isCurrentUser,
    );
  });
});

class _LeaderboardInput {
  final String userName;
  final int xp;
  final int streak;

  const _LeaderboardInput({
    required this.userName,
    required this.xp,
    required this.streak,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _LeaderboardInput &&
          userName == other.userName &&
          xp == other.xp &&
          streak == other.streak;

  @override
  int get hashCode => Object.hash(userName, xp, streak);
}

// ─────────────────────────────────────────────────────────
//  Leaderboard Page
// ─────────────────────────────────────────────────────────

class LeaderboardPage extends ConsumerStatefulWidget {
  const LeaderboardPage({super.key});

  @override
  ConsumerState<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends ConsumerState<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _headerController;
  final GlobalKey _shareCardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final streakState = ref.watch(streakProvider);
    final sugarState = ref.watch(sugarLogProvider);

    final userName = user?.fullName ?? user?.username ?? 'You';
    final totalXp = sugarState.totalXpToday;
    final streak = streakState.currentStreak;

    final input = _LeaderboardInput(
      userName: userName,
      xp: totalXp,
      streak: streak,
    );
    final leaderboardAsync = ref.watch(leaderboardProvider(input));

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: CustomScrollView(
        slivers: [
          // ============ HERO HEADER ============
          SliverToBoxAdapter(
            child: _HeroHeader(
              animation: _headerController,
              userName: userName,
              xp: totalXp,
              streak: streak,
              shareCardKey: _shareCardKey,
            ),
          ),

          // ============ LEADERBOARD LIST ============
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const Text(
                    '🏆  Top Sugar-Smart Warriors',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'LIVE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: Colors.amber,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 12)),

          leaderboardAsync.when(
            data: (entries) => SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final entry = entries[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _LeaderboardTile(entry: entry),
                    );
                  },
                  childCount: entries.length,
                ),
              ),
            ),
            loading: () => const SliverFillRemaining(
              child: Center(
                  child: CircularProgressIndicator(color: Colors.amber)),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(
                child: Text('Error: $e',
                    style: const TextStyle(color: Colors.white70)),
              ),
            ),
          ),

          // Bottom padding
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
//  Hero Header with Share Card
// ─────────────────────────────────────────────────────────

class _HeroHeader extends StatelessWidget {
  final Animation<double> animation;
  final String userName;
  final int xp;
  final int streak;
  final GlobalKey shareCardKey;

  const _HeroHeader({
    required this.animation,
    required this.userName,
    required this.xp,
    required this.streak,
    required this.shareCardKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1a1a3e),
            Color(0xFF2d1b69),
            Color(0xFF0F0F23),
          ],
        ),
      ),
      child: Column(
        children: [
          // App bar row
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.white70, size: 18),
                ),
              ),
              const Spacer(),
              const Text(
                'Leaderboard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 24),

          // ===== SHAREABLE STREAK CARD =====
          RepaintBoundary(
            key: shareCardKey,
            child: _StreakShareCard(
              userName: userName,
              xp: xp,
              streak: streak,
            ),
          ),
          const SizedBox(height: 16),

          // Share button
          _ShareStreakButton(
            shareCardKey: shareCardKey,
            userName: userName,
            xp: xp,
            streak: streak,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
//  Beautiful Shareable Streak Card
// ─────────────────────────────────────────────────────────

class _StreakShareCard extends StatelessWidget {
  final String userName;
  final int xp;
  final int streak;

  const _StreakShareCard({
    required this.userName,
    required this.xp,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFD700),
            Color(0xFFFFA500),
            Color(0xFFFF6347),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('🏆', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(width: 8),
              const Text(
                'NovaHealth',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // User name
          Text(
            userName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Sugar-Smart Warrior',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.85),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 20),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ShareStatCircle(
                value: '$streak',
                label: 'Day Streak',
                icon: '🔥',
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.white.withOpacity(0.3),
              ),
              _ShareStatCircle(
                value: '$xp',
                label: 'Total XP',
                icon: '⚡',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Tagline
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '🌟 Beat the Sugar Spike — Join me!',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareStatCircle extends StatelessWidget {
  final String value;
  final String label;
  final String icon;

  const _ShareStatCircle({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────
//  Share Streak Button
// ─────────────────────────────────────────────────────────

class _ShareStreakButton extends StatelessWidget {
  final GlobalKey shareCardKey;
  final String userName;
  final int xp;
  final int streak;

  const _ShareStreakButton({
    required this.shareCardKey,
    required this.userName,
    required this.xp,
    required this.streak,
  });

  Future<void> _shareStreak(BuildContext context) async {
    if (!kIsWeb) HapticFeedback.mediumImpact();

    // Try to capture the card as an image
    try {
      final boundary = shareCardKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary != null) {
        final image = await boundary.toImage(pixelRatio: 3.0);
        final byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          // Use share_plus if available; fallback to snackbar
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '🎉 Streak card captured! $userName — $streak day streak, $xp XP',
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: const Color(0xFF8B5CF6),
              ),
            );
          }
        }
      }
    } catch (e) {
      // Fallback — just show text share
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '🔥 I\'m on a $streak-day streak with $xp XP on NovaHealth! #BeatTheSugarSpike',
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFFFFD700),
            action: SnackBarAction(label: 'Copy', onPressed: () {
              Clipboard.setData(ClipboardData(
                text:
                    '🔥 I\'m on a $streak-day streak with $xp XP on NovaHealth! #BeatTheSugarSpike',
              ));
            }),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _shareStreak(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B5CF6).withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.share_rounded, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Share My Streak',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
//  Leaderboard Tile
// ─────────────────────────────────────────────────────────

class _LeaderboardTile extends StatelessWidget {
  final LeaderboardEntry entry;

  const _LeaderboardTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final isTop3 = entry.rank <= 3;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: entry.isCurrentUser
            ? const Color(0xFF8B5CF6).withOpacity(0.2)
            : Colors.white.withOpacity(0.06),
        border: entry.isCurrentUser
            ? Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.6), width: 1.5)
            : Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: entry.isCurrentUser
            ? [
                BoxShadow(
                  color: const Color(0xFF8B5CF6).withOpacity(0.15),
                  blurRadius: 12,
                ),
              ]
            : [],
      ),
      child: Row(
        children: [
          // Rank badge
          SizedBox(
            width: 36,
            child: isTop3
                ? Text(
                    _rankEmoji(entry.rank),
                    style: const TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    '#${entry.rank}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
          const SizedBox(width: 12),

          // Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: entry.isCurrentUser
                  ? const Color(0xFF8B5CF6).withOpacity(0.3)
                  : Colors.white.withOpacity(0.08),
              border: isTop3
                  ? Border.all(
                      color: _rankColor(entry.rank),
                      width: 2,
                    )
                  : null,
            ),
            child: Center(
              child: Text(entry.avatarEmoji,
                  style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 12),

          // Name + streak
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        entry.isCurrentUser ? '${entry.name} (You)' : entry.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              entry.isCurrentUser ? FontWeight.w900 : FontWeight.w600,
                          color: entry.isCurrentUser
                              ? const Color(0xFFD4A0FF)
                              : Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '🔥 ${entry.streak} day streak',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),

          // XP
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isTop3
                  ? _rankColor(entry.rank).withOpacity(0.15)
                  : Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '⚡',
                  style: TextStyle(fontSize: isTop3 ? 14 : 12),
                ),
                const SizedBox(width: 4),
                Text(
                  '${entry.xp}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: isTop3 ? _rankColor(entry.rank) : Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _rankEmoji(int rank) {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return '#$rank';
    }
  }

  Color _rankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return Colors.white54;
    }
  }
}
