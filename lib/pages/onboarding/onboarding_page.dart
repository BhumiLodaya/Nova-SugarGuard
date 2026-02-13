import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import '../../services/guest_service.dart';
import '../../providers/auth_provider.dart';

/// Game-like onboarding: one question per screen.
/// Collects Age → Height → Weight → Gender, silently computes BMI,
/// stores everything locally in Hive, then sends the user to Home.
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Collected values
  double _age = 25;
  double _heightCm = 165;
  double _weightKg = 65;
  String? _gender;

  static const _totalPages = 4;

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finish() async {
    final guest = GuestService();
    final user = await guest.updateGuestProfile(
      age: _age.round(),
      heightCm: _heightCm,
      weightKg: _weightKg,
      gender: _gender ?? 'Prefer not to say',
    );

    // Update Riverpod state so the rest of the app sees the user
    ref.read(currentUserProvider.notifier).setUser(user);

    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightGreen,
      body: SafeArea(
        child: Column(
          children: [
            // --- Progress dots ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalPages, (i) {
                  final isActive = i <= _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 28 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppTheme.primaryGreen
                          : AppTheme.primaryGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                }),
              ),
            ),

            // --- Pages ---
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _AgeStep(
                    value: _age,
                    onChanged: (v) => setState(() => _age = v),
                    onNext: _nextPage,
                  ),
                  _HeightStep(
                    value: _heightCm,
                    onChanged: (v) => setState(() => _heightCm = v),
                    onNext: _nextPage,
                  ),
                  _WeightStep(
                    value: _weightKg,
                    onChanged: (v) => setState(() => _weightKg = v),
                    onNext: _nextPage,
                  ),
                  _GenderStep(
                    selected: _gender,
                    onSelected: (g) => setState(() => _gender = g),
                    onFinish: _finish,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  STEP 1 — AGE (slider)
// ═══════════════════════════════════════════════════════════════

class _AgeStep extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final VoidCallback onNext;

  const _AgeStep({
    required this.value,
    required this.onChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      emoji: '🎂',
      title: 'How old are you?',
      subtitle: 'This helps us personalise your sugar insights.',
      bottomWidget: Column(
        children: [
          Text(
            '${value.round()}',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 64,
                  color: AppTheme.darkGreen,
                ),
          ),
          const SizedBox(height: 4),
          Text('years',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.darkGreen.withOpacity(0.5),
                  )),
          const SizedBox(height: 24),
          Slider(
            value: value,
            min: 10,
            max: 80,
            divisions: 70,
            activeColor: AppTheme.primaryGreen,
            inactiveColor: AppTheme.primaryGreen.withOpacity(0.15),
            onChanged: onChanged,
          ),
        ],
      ),
      onNext: onNext,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  STEP 2 — HEIGHT (slider, cm)
// ═══════════════════════════════════════════════════════════════

class _HeightStep extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final VoidCallback onNext;

  const _HeightStep({
    required this.value,
    required this.onChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      emoji: '📏',
      title: 'Your height?',
      subtitle: 'We use this to understand your body profile.',
      bottomWidget: Column(
        children: [
          Text(
            '${value.round()} cm',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 56,
                  color: AppTheme.darkGreen,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '≈ ${(value / 30.48).toStringAsFixed(1)} ft',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.darkGreen.withOpacity(0.5),
                ),
          ),
          const SizedBox(height: 24),
          Slider(
            value: value,
            min: 100,
            max: 220,
            divisions: 120,
            activeColor: AppTheme.primaryGreen,
            inactiveColor: AppTheme.primaryGreen.withOpacity(0.15),
            onChanged: onChanged,
          ),
        ],
      ),
      onNext: onNext,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  STEP 3 — WEIGHT (slider, kg)
// ═══════════════════════════════════════════════════════════════

class _WeightStep extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final VoidCallback onNext;

  const _WeightStep({
    required this.value,
    required this.onChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      emoji: '⚖️',
      title: 'Your weight?',
      subtitle: 'Helps us calculate health metrics silently.',
      bottomWidget: Column(
        children: [
          Text(
            '${value.round()} kg',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 56,
                  color: AppTheme.darkGreen,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '≈ ${(value * 2.205).toStringAsFixed(0)} lbs',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.darkGreen.withOpacity(0.5),
                ),
          ),
          const SizedBox(height: 24),
          Slider(
            value: value,
            min: 30,
            max: 200,
            divisions: 170,
            activeColor: AppTheme.primaryGreen,
            inactiveColor: AppTheme.primaryGreen.withOpacity(0.15),
            onChanged: onChanged,
          ),
        ],
      ),
      onNext: onNext,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  STEP 4 — GENDER (tap-cards)
// ═══════════════════════════════════════════════════════════════

class _GenderStep extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelected;
  final VoidCallback onFinish;

  const _GenderStep({
    required this.selected,
    required this.onSelected,
    required this.onFinish,
  });

  static const _options = [
    {'label': 'Male', 'emoji': '👨'},
    {'label': 'Female', 'emoji': '👩'},
    {'label': 'Non-binary', 'emoji': '🧑'},
    {'label': 'Prefer not to say', 'emoji': '🤐'},
  ];

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      emoji: '🪪',
      title: 'How do you identify?',
      subtitle: 'Used for personalised health benchmarks.',
      ctaLabel: 'LET\'S GO 🚀',
      isLast: true,
      onNext: selected != null ? onFinish : null,
      bottomWidget: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: _options.map((opt) {
          final isSelected = selected == opt['label'];
          return GestureDetector(
            onTap: () => onSelected(opt['label']!),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 150,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryGreen
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.darkGreen
                      : AppTheme.primaryGreen.withOpacity(0.3),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryGreen.withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : [],
              ),
              child: Column(
                children: [
                  Text(opt['emoji']!, style: const TextStyle(fontSize: 32)),
                  const SizedBox(height: 6),
                  Text(
                    opt['label']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.darkGreen,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SHARED SCAFFOLD for each step
// ═══════════════════════════════════════════════════════════════

class _StepScaffold extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Widget bottomWidget;
  final VoidCallback? onNext;
  final String ctaLabel;
  final bool isLast;

  const _StepScaffold({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.bottomWidget,
    this.onNext,
    this.ctaLabel = 'NEXT →',
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.darkGreen.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 36),
          bottomWidget,
          const SizedBox(height: 40),
          GestureDetector(
            onTap: onNext,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 220,
              height: 52,
              decoration: BoxDecoration(
                color: onNext != null
                    ? AppTheme.darkGreen
                    : AppTheme.darkGreen.withOpacity(0.3),
                borderRadius: BorderRadius.circular(60),
              ),
              alignment: Alignment.center,
              child: Text(
                ctaLabel,
                style: TextStyle(
                  color: AppTheme.lightGreen,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
