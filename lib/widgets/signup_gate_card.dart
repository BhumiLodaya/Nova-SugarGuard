import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/streak_provider.dart';
import '../../providers/sugar_log_provider.dart';
import '../../services/guest_service.dart';

/// A premium "Gold Member" invitation card shown to guests who have:
///  - A 3+ day streak, OR
///  - 100+ accumulated XP.
///
/// Styled as an exclusive invite rather than a system alert.
class SignupGateCard extends ConsumerStatefulWidget {
  const SignupGateCard({super.key});

  @override
  ConsumerState<SignupGateCard> createState() => _SignupGateCardState();
}

class _SignupGateCardState extends ConsumerState<SignupGateCard>
    with SingleTickerProviderStateMixin {
  bool _dismissed = false;
  bool _shouldShow = false;
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _checkGate();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Future<void> _checkGate() async {
    final guest = GuestService();
    final xpGate = await guest.hasReachedSignupGate();
    if (mounted) {
      setState(() => _shouldShow = xpGate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGuest = ref.watch(isGuestProvider);
    final streak = ref.watch(streakProvider).currentStreak;
    final totalXp = ref.watch(sugarLogProvider).totalXpToday;

    // Only show for guests, and only if gate conditions are met
    if (!isGuest || _dismissed) return const SizedBox.shrink();
    if (streak < 3 && !_shouldShow) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedBuilder(
            animation: _shimmerController,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFFFD700).withOpacity(0.9),
                      const Color(0xFFFFA500).withOpacity(0.85),
                      const Color(0xFFFF8C00).withOpacity(0.9),
                    ],
                    stops: [
                      0.0,
                      0.4 + _shimmerController.value * 0.2,
                      1.0,
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD700).withOpacity(0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: const Color(0xFFFFA500).withOpacity(0.2),
                      blurRadius: 40,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: child,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: gold badge + dismiss
                Row(
                  children: [
                    // Gold crown badge
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      child: const Text('👑', style: TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Gold Member',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'INVITE',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Exclusive for streak warriors',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!kIsWeb) HapticFeedback.lightImpact();
                        setState(() => _dismissed = true);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Narrative text
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: const Text(
                    "You've mastered a 3-day streak! 🎉\nReady to join the Global Leaderboard and secure your data? Level up now.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Benefits — compact gold style
                _GoldBenefitRow(
                    icon: '🏆', text: 'Join the Global Leaderboard'),
                const SizedBox(height: 6),
                _GoldBenefitRow(
                    icon: '☁️', text: 'Cloud sync across all devices'),
                const SizedBox(height: 6),
                _GoldBenefitRow(
                    icon: '📊', text: 'Personalised weekly health reports'),
                const SizedBox(height: 6),
                _GoldBenefitRow(
                    icon: '🔒', text: 'Your streak — protected forever'),
                const SizedBox(height: 18),

                // CTA button — glass white with gold text
                GestureDetector(
                  onTap: () {
                    if (!kIsWeb) HapticFeedback.mediumImpact();
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '⚡',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Level Up — Free Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFFF8C00),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Reassurance
                Center(
                  child: Text(
                    '✦  Your data stays — nothing is lost  ✦',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoldBenefitRow extends StatelessWidget {
  final String icon;
  final String text;

  const _GoldBenefitRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
