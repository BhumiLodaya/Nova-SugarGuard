import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/theme.dart';

/// A celebration dialog for streak milestones (Day 1, 3, 7, 30).
///
/// Called imperatively via `StreakMilestonePopup.show(context, milestone)`.
class StreakMilestonePopup {
  StreakMilestonePopup._();

  static Future<void> show(BuildContext context, int milestone) {
    if (!kIsWeb) HapticFeedback.heavyImpact();
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Milestone',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (ctx, a1, a2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: a1, curve: Curves.elasticOut),
          child: FadeTransition(opacity: a1, child: child),
        );
      },
      pageBuilder: (ctx, _, __) => _MilestoneContent(milestone: milestone),
    );
  }
}

class _MilestoneContent extends StatelessWidget {
  final int milestone;
  const _MilestoneContent({required this.milestone});

  @override
  Widget build(BuildContext context) {
    final config = _milestoneConfig(milestone);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: config.glowColor.withOpacity(0.35),
                blurRadius: 40,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Big emoji
              Text(config.emoji, style: const TextStyle(fontSize: 56)),
              const SizedBox(height: 12),

              // Milestone badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: config.gradientColors),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: config.glowColor.withOpacity(0.4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Text(
                  'Day ${milestone} 🔥',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                config.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkGreen,
                    ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                config.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // XP bonus badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBBF24).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFFBBF24).withOpacity(0.4),
                  ),
                ),
                child: Text(
                  '🎁 +${config.bonusXp} Bonus XP',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFB45309),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // CTA
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Keep Going! 💪',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _MilestoneConfig _milestoneConfig(int day) {
    switch (day) {
      case 1:
        return _MilestoneConfig(
          emoji: '🌱',
          title: 'First Step Taken!',
          subtitle:
              'You logged your first day of sugar tracking. Every journey starts with a single step.',
          bonusXp: 5,
          gradientColors: [const Color(0xFF10B981), const Color(0xFF34D399)],
          glowColor: const Color(0xFF10B981),
        );
      case 3:
        return _MilestoneConfig(
          emoji: '⚡',
          title: 'Momentum Builder!',
          subtitle:
              '3 days in a row! Research shows it takes 3 days to start building awareness of hidden sugars.',
          bonusXp: 15,
          gradientColors: [const Color(0xFFF59E0B), const Color(0xFFFBBF24)],
          glowColor: const Color(0xFFF59E0B),
        );
      case 7:
        return _MilestoneConfig(
          emoji: '🏆',
          title: 'One Week Champion!',
          subtitle:
              '7 days strong! Your body is already adapting to lower sugar spikes. Keep the streak alive!',
          bonusXp: 30,
          gradientColors: [const Color(0xFFFF6B35), const Color(0xFFFFA62B)],
          glowColor: const Color(0xFFFF6B35),
        );
      case 30:
        return _MilestoneConfig(
          emoji: '👑',
          title: 'Sugar Spike Master!',
          subtitle:
              '30 days of consistent tracking! You\'ve built a real habit. Your future self thanks you.',
          bonusXp: 100,
          gradientColors: [const Color(0xFF8B5CF6), const Color(0xFFA78BFA)],
          glowColor: const Color(0xFF8B5CF6),
        );
      default:
        return _MilestoneConfig(
          emoji: '🎉',
          title: 'Milestone Reached!',
          subtitle: 'Day $day — keep the streak going!',
          bonusXp: 10,
          gradientColors: [AppTheme.primaryGreen, const Color(0xFF34D399)],
          glowColor: AppTheme.primaryGreen,
        );
    }
  }
}

class _MilestoneConfig {
  final String emoji;
  final String title;
  final String subtitle;
  final int bonusXp;
  final List<Color> gradientColors;
  final Color glowColor;

  const _MilestoneConfig({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.bonusXp,
    required this.gradientColors,
    required this.glowColor,
  });
}
