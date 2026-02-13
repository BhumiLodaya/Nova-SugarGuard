import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../providers/streak_provider.dart';
import '../../providers/sugar_log_provider.dart';

// ═══════════════════════════════════════════════════════════════
//  STREAK WIDGET  (🔥 flame + day count)
// ═══════════════════════════════════════════════════════════════

class StreakWidget extends ConsumerWidget {
  const StreakWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        gradient: streak.currentStreak > 0
            ? const LinearGradient(
                colors: [Color(0xFFFF6B35), Color(0xFFFFA62B)],
              )
            : null,
        color: streak.currentStreak == 0
            ? AppTheme.slate.withOpacity(0.4)
            : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: streak.currentStreak > 0
            ? [
                BoxShadow(
                  color: const Color(0xFFFF6B35).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department,
            size: 20,
            color: streak.currentStreak > 0
                ? Colors.white
                : AppTheme.slateLight,
          ),
          const SizedBox(width: 4),
          Text(
            '${streak.currentStreak}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: streak.currentStreak > 0
                  ? Colors.white
                  : AppTheme.slateLight,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            streak.currentStreak == 1 ? 'day' : 'days',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: streak.currentStreak > 0
                  ? Colors.white.withOpacity(0.85)
                  : AppTheme.slateLight.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  DAILY PROGRESS BAR  — gradient glow + pulse near goal
// ═══════════════════════════════════════════════════════════════

class DailyProgressBar extends ConsumerStatefulWidget {
  static const double _dailyTargetGrams = 50;

  const DailyProgressBar({super.key});

  @override
  ConsumerState<DailyProgressBar> createState() => _DailyProgressBarState();
}

class _DailyProgressBarState extends ConsumerState<DailyProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sugarState = ref.watch(sugarLogProvider);
    final totalGrams = sugarState.totalSugarToday;
    final logCount = sugarState.todayLogs.length;
    final progress =
        (totalGrams / DailyProgressBar._dailyTargetGrams).clamp(0.0, 1.0);

    // Pulse when near goal (>70%)
    if (progress > 0.7) {
      if (!_pulseController.isAnimating) _pulseController.repeat(reverse: true);
    } else {
      if (_pulseController.isAnimating) _pulseController.stop();
    }

    final Color barColor;
    final String statusLabel;
    final List<Color> gradientColors;
    if (totalGrams <= 25) {
      barColor = AppTheme.emerald;
      statusLabel = 'Great';
      gradientColors = [const Color(0xFF10B981), const Color(0xFF34D399)];
    } else if (totalGrams <= 50) {
      barColor = AppTheme.amber;
      statusLabel = 'Moderate';
      gradientColors = [const Color(0xFFF59E0B), const Color(0xFFFBBF24)];
    } else {
      barColor = const Color(0xFFEF4444);
      statusLabel = 'High';
      gradientColors = [const Color(0xFFEF4444), const Color(0xFFF87171)];
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.midnightLight,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: AppTheme.glassBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: label + count
          Row(
            children: [
              Text(
                'Today\'s Sugar',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              const Spacer(),
              Text(
                '$logCount log${logCount == 1 ? '' : 's'}  •  ',
                style: TextStyle(fontSize: 11, color: AppTheme.slateLight),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: barColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: barColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Gradient progress bar with glow
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final glowIntensity =
                  progress > 0.7 ? 0.3 + _pulseController.value * 0.4 : 0.0;
              return Container(
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: progress > 0.7
                      ? [
                          BoxShadow(
                            color: barColor.withOpacity(glowIntensity),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Stack(
                    children: [
                      // Track
                      Container(
                        color: AppTheme.slate.withOpacity(0.5),
                      ),
                      // Filled gradient
                      FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColors,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),

          // Bottom labels
          Row(
            children: [
              Text(
                '${totalGrams.toStringAsFixed(0)} g',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: barColor,
                ),
              ),
              const Spacer(),
              Text(
                '/ ${DailyProgressBar._dailyTargetGrams.toInt()} g target',
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.slateLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  LOSS AVERSION BANNER
// ═══════════════════════════════════════════════════════════════

class StreakAtRiskBanner extends ConsumerWidget {
  const StreakAtRiskBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakProvider);

    if (!streak.streakAtRisk) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.amber.withOpacity(0.2),
            AppTheme.amber.withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.amber.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Text('⚠️', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: AppTheme.amberLight,
                  fontSize: 13,
                  height: 1.3,
                ),
                children: [
                  const TextSpan(
                    text: 'Log your first item to protect your ',
                  ),
                  TextSpan(
                    text: '${streak.currentStreak}-day streak!',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
          Icon(
            Icons.local_fire_department,
            color: AppTheme.amber,
            size: 22,
          ),
        ],
      ),
    );
  }
}
