import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../models/sugar_log_model.dart';
import '../../providers/sugar_log_provider.dart';
import '../../providers/streak_provider.dart';

/// Full-screen overlay that fires after a successful sugar log.
///
/// Shows:
///  1. "+10 XP" badge with a scale/fade animation.
///  2. The logged preset emoji + label.
///  3. Short-term impact insight from the backend (or local fallback).
///  4. Corrective action recommendation.
///
/// Plays a haptic "success" pulse and auto-dismisses after 4 seconds.
class SuccessAnimationOverlay extends ConsumerStatefulWidget {
  const SuccessAnimationOverlay({super.key});

  @override
  ConsumerState<SuccessAnimationOverlay> createState() =>
      _SuccessAnimationOverlayState();
}

class _SuccessAnimationOverlayState
    extends ConsumerState<SuccessAnimationOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Play success haptic (no-op on web) + start animation
    if (!kIsWeb) HapticFeedback.heavyImpact();
    _controller.forward();

    // Auto-dismiss after 4 seconds
    Future.delayed(const Duration(seconds: 4), _dismiss);
  }

  void _dismiss() {
    if (mounted) {
      ref.read(sugarLogProvider.notifier).clearLastLog();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sugarLogProvider);
    final streakState = ref.watch(streakProvider);
    final log = state.lastLog;
    final insight = state.lastInsight;

    if (log == null) return const SizedBox.shrink();

    return Material(
      color: Colors.black54,
      child: SafeArea(
        child: GestureDetector(
          onTap: _dismiss,
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 28),
                  padding: const EdgeInsets.symmetric(
                      vertical: 32, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryGreen.withOpacity(0.25),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // XP Badge
                      ScaleTransition(
                        scale: _scaleAnim,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFBBF24).withOpacity(0.4),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: Text(
                            '+${log.xpEarned} XP',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Streak indicator
                      if (streakState.currentStreak > 0)
                        ScaleTransition(
                          scale: _scaleAnim,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF6B35),
                                  Color(0xFFFFA62B),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.local_fire_department,
                                    size: 18, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(
                                  '${streakState.currentStreak}-day streak${streakState.milestoneJustReached != null ? ' 🎉' : ''}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),

                      // Emoji + label
                      Text(
                        _emojiForType(log.sugarType),
                        style: const TextStyle(fontSize: 44),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${log.label} logged!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${log.estimatedSugarGrams.toInt()} g sugar  •  ${log.estimatedCalories.toInt()} cal',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(height: 20),

                      // Insight card
                      if (insight != null) ...[
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppTheme.lightGreen,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.bolt,
                                      size: 18, color: Colors.orange),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Impact',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.darkGreen,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                insight.shortTermImpact,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.darkGreen.withOpacity(0.8),
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.directions_walk,
                                      size: 18, color: AppTheme.primaryGreen),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Do this now',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.darkGreen,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                insight.correctiveAction,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.darkGreen.withOpacity(0.8),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // ML Explainability button
                        GestureDetector(
                          onTap: () => _showExplainabilitySheet(context, insight, log),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.psychology,
                                  size: 16,
                                  color: AppTheme.primaryGreen.withOpacity(0.7)),
                              const SizedBox(width: 4),
                              Text(
                                'Why this suggestion?',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryGreen.withOpacity(0.7),
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      AppTheme.primaryGreen.withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),

                      // Dismiss hint
                      Text(
                        'Tap anywhere to dismiss',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[400],
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── ML Explainability Bottom Sheet ──────────────────────────
  void _showExplainabilitySheet(
    BuildContext context,
    SugarInsightResult insight,
    SugarLogModel log,
  ) {
    if (!kIsWeb) HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ExplainabilitySheet(insight: insight, log: log),
    );
  }

  String _emojiForType(String type) {
    switch (type) {
      case 'chai':
        return '☕';
      case 'cold_drink':
        return '🥤';
      case 'sweets':
        return '🍬';
      case 'snack':
        return '🍪';
      default:
        return '🍭';
    }
  }
}

// ─────────────────────────────────────────────────────────────
//  ML Explainability Bottom Sheet
// ─────────────────────────────────────────────────────────────
class _ExplainabilitySheet extends StatelessWidget {
  final SugarInsightResult insight;
  final SugarLogModel log;

  const _ExplainabilitySheet({
    required this.insight,
    required this.log,
  });

  @override
  Widget build(BuildContext context) {
    final bmi = insight.bmi ?? 22.0;
    final steps = insight.steps ?? 0;
    final bmiCategory = _bmiCategory(bmi);
    final activityLevel = _activityLevel(steps);

    return Container(
      margin: const EdgeInsets.only(top: 80),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.lightGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.psychology,
                      color: AppTheme.primaryGreen, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Why this suggestion?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkGreen,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Explanation intro
            Text(
              'Our model combined 3 signals from your profile to personalise the recommendation:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),

            // Signal 1: Sugar Type
            _SignalTile(
              icon: Icons.local_cafe,
              iconColor: const Color(0xFFE63946),
              label: 'Sugar Type',
              value: log.label,
              detail:
                  '${log.estimatedSugarGrams.toInt()} g of sugar from ${log.label.toLowerCase()} — ${_absorptionSpeed(log.sugarType)}.',
            ),
            const SizedBox(height: 12),

            // Signal 2: BMI
            _SignalTile(
              icon: Icons.monitor_weight_outlined,
              iconColor: const Color(0xFFF59E0B),
              label: 'Your BMI',
              value: '${bmi.toStringAsFixed(1)} ($bmiCategory)',
              detail: _bmiExplanation(bmi, bmiCategory),
            ),
            const SizedBox(height: 12),

            // Signal 3: Activity
            _SignalTile(
              icon: Icons.directions_walk,
              iconColor: AppTheme.primaryGreen,
              label: 'Activity Today',
              value: '$steps steps ($activityLevel)',
              detail: _activityExplanation(steps, activityLevel),
            ),
            const SizedBox(height: 20),

            // Result chain
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.lightGreen,
                    AppTheme.lightGreen.withOpacity(0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.primaryGreen.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome,
                          size: 18, color: AppTheme.primaryGreen),
                      const SizedBox(width: 8),
                      Text(
                        'Result',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppTheme.darkGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '"${insight.correctiveAction}"',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: AppTheme.darkGreen.withOpacity(0.85),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Disclaimer
            Text(
              'This is personalised guidance based on health research — not medical advice.',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _bmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  String _activityLevel(int steps) {
    if (steps >= 8000) return 'Active';
    if (steps >= 4000) return 'Moderate';
    return 'Low';
  }

  String _absorptionSpeed(String type) {
    switch (type) {
      case 'cold_drink':
        return 'liquid sugar absorbs the fastest, spiking glucose in ~15 min';
      case 'chai':
        return 'moderate absorption, glucose bumps in ~20 min';
      case 'sweets':
        return 'solid sugars digest more slowly but still spike within 30 min';
      case 'snack':
        return 'hidden sugars in snacks combine with sodium for a delayed spike';
      default:
        return 'absorption depends on the sugar form';
    }
  }

  String _bmiExplanation(double bmi, String category) {
    if (bmi < 18.5) {
      return 'With a lower BMI, your body has less glycogen reserve — sugar gets used faster but can still cause sharp spikes.';
    } else if (bmi < 25) {
      return 'Your BMI is in the normal range. The model uses this to estimate standard insulin sensitivity for its recommendation.';
    } else if (bmi < 30) {
      return 'A higher BMI indicates potential insulin resistance, meaning sugar stays in the blood longer — the model recommends more physical activity to compensate.';
    } else {
      return 'At this BMI range, insulin resistance is more likely. The model prioritises movement-based corrections to help your body process sugar effectively.';
    }
  }

  String _activityExplanation(int steps, String level) {
    if (steps >= 8000) {
      return 'Great activity today! Your muscles are primed to absorb glucose — the model adjusts the recommendation to be lighter.';
    } else if (steps >= 4000) {
      return 'Moderate activity so far. The model suggests additional movement because your body could still use more help clearing this sugar.';
    } else {
      return 'Low step count today. The model weights physical activity higher because your muscles haven\'t had enough work to efficiently absorb blood sugar.';
    }
  }
}

// ─────────────────────────────────────────────────────────
//  Signal tile used inside the explainability sheet
// ─────────────────────────────────────────────────────────
class _SignalTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String detail;

  const _SignalTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
