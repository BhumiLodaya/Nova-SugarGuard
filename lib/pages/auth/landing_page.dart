import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import '../../widgets/custom_button.dart';
import '../../providers/auth_provider.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: AppTheme.midnight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // --- App icon / emoji ---
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.novaBlue.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('🍬', style: TextStyle(fontSize: 40)),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Beat the\nSugar Spike',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Track your sugar. Break the cycle.\nPowered by NovaHealth.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.novaBlue.withOpacity(0.7),
                          height: 1.4,
                        ),
                  ),

                  const SizedBox(height: 48),

                  // ==================== PRIMARY CTA: GUEST MODE ====================
                  CustomButton(
                    text: 'START NOW — NO SIGNUP',
                    width: 260,
                    isLoading: authState.isLoading,
                    backgroundColor: AppTheme.novaBlue,
                    textColor: AppTheme.midnight,
                    onPressed: () async {
                      await ref.read(authStateProvider.notifier).loginAsGuest();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.onboarding,
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 12),
                  Text(
                    'No account needed. Your data stays on this device.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.slateLight,
                        ),
                  ),

                  const SizedBox(height: 40),

                  // ==================== EXISTING AUTH (dimmed) ====================
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppTheme.slate)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Already have an account?',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.slateLight,
                              ),
                        ),
                      ),
                      Expanded(child: Divider(color: AppTheme.slate)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: 'LOGIN',
                        width: 130,
                        backgroundColor: AppTheme.novaBlueDeep,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                      ),
                      const SizedBox(width: 16),
                      CustomButton(
                        text: 'SIGNUP',
                        width: 130,
                        backgroundColor: AppTheme.novaBlueDeep,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.signup);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
