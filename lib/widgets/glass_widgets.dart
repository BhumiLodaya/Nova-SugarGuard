import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/theme.dart';

/// A reusable Glassmorphism card container.
/// Uses BackdropFilter with a frosted-glass look optimised for dark bg.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blurAmount;
  final Color? tintColor;
  final double opacity;
  final Border? border;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 20,
    this.blurAmount = 14,
    this.tintColor,
    this.opacity = 0.08,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final color = tintColor ?? Colors.white;

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurAmount,
            sigmaY: blurAmount,
          ),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withOpacity(opacity),
              borderRadius: BorderRadius.circular(borderRadius),
              border: border ??
                  Border.all(
                    color: Colors.white.withOpacity(0.12),
                    width: 1.0,
                  ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// An animated button with spring-physics tap feedback.
/// On hover (web) it scales up subtly, on tap it bounces.
class SpringButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double hoverScale;
  final double tapScale;

  const SpringButton({
    super.key,
    required this.child,
    this.onTap,
    this.hoverScale = 1.04,
    this.tapScale = 0.94,
  });

  @override
  State<SpringButton> createState() => _SpringButtonState();
}

class _SpringButtonState extends State<SpringButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.tapScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedScale(
          scale: _isHovering ? widget.hoverScale : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child!,
              );
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

// Removed custom AnimatedBuilder — use Flutter's built-in AnimatedBuilder.

/// 3D-style health icons as rich emoji + gradient badge combos.
/// Replaces boring Material icons with vivid, colorful alternatives.
class HealthIcon extends StatelessWidget {
  final HealthIconType type;
  final double size;

  const HealthIcon({super.key, required this.type, this.size = 28});

  @override
  Widget build(BuildContext context) {
    final config = _iconConfig(type);
    return Container(
      width: size + 12,
      height: size + 12,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: config.gradientColors,
        ),
        borderRadius: BorderRadius.circular(size * 0.3),
        boxShadow: [
          BoxShadow(
            color: config.gradientColors.first.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          config.emoji,
          style: TextStyle(fontSize: size * 0.65),
        ),
      ),
    );
  }

  _IconConfig _iconConfig(HealthIconType type) {
    switch (type) {
      case HealthIconType.water:
        return _IconConfig(
          emoji: '💧',
          gradientColors: [const Color(0xFF4FC3F7), const Color(0xFF0288D1)],
        );
      case HealthIconType.calories:
        return _IconConfig(
          emoji: '🔥',
          gradientColors: [const Color(0xFFFFB74D), const Color(0xFFFF7043)],
        );
      case HealthIconType.weight:
        return _IconConfig(
          emoji: '⚖️',
          gradientColors: [const Color(0xFF81C784), const Color(0xFF388E3C)],
        );
      case HealthIconType.bmi:
        return _IconConfig(
          emoji: '❤️',
          gradientColors: [const Color(0xFFE57373), const Color(0xFFD32F2F)],
        );
      case HealthIconType.workout:
        return _IconConfig(
          emoji: '💪',
          gradientColors: [const Color(0xFF7E57C2), const Color(0xFF4527A0)],
        );
      case HealthIconType.meal:
        return _IconConfig(
          emoji: '🍽️',
          gradientColors: [const Color(0xFFFFB74D), const Color(0xFFF57C00)],
        );
      case HealthIconType.mood:
        return _IconConfig(
          emoji: '🧠',
          gradientColors: [const Color(0xFFCE93D8), const Color(0xFF7B1FA2)],
        );
      case HealthIconType.health:
        return _IconConfig(
          emoji: '🩺',
          gradientColors: [const Color(0xFF4DB6AC), const Color(0xFF00796B)],
        );
      case HealthIconType.sugar:
        return _IconConfig(
          emoji: '🍬',
          gradientColors: [const Color(0xFFF48FB1), const Color(0xFFE91E63)],
        );
      case HealthIconType.leaderboard:
        return _IconConfig(
          emoji: '🏆',
          gradientColors: [const Color(0xFFFFD54F), const Color(0xFFF57F17)],
        );
      case HealthIconType.chai:
        return _IconConfig(
          emoji: '☕',
          gradientColors: [const Color(0xFFD4A373), const Color(0xFF8D6E63)],
        );
      case HealthIconType.coldDrink:
        return _IconConfig(
          emoji: '🥤',
          gradientColors: [const Color(0xFFEF5350), const Color(0xFFC62828)],
        );
      case HealthIconType.sweets:
        return _IconConfig(
          emoji: '🍬',
          gradientColors: [const Color(0xFFF4A261), const Color(0xFFE76F51)],
        );
      case HealthIconType.snack:
        return _IconConfig(
          emoji: '🍪',
          gradientColors: [const Color(0xFF90A4AE), const Color(0xFF546E7A)],
        );
      case HealthIconType.coffee:
        return _IconConfig(
          emoji: '☕',
          gradientColors: [const Color(0xFF8D6E63), const Color(0xFF4E342E)],
        );
      case HealthIconType.soda:
        return _IconConfig(
          emoji: '🥤',
          gradientColors: [const Color(0xFFEF4444), const Color(0xFFB91C1C)],
        );
      case HealthIconType.donut:
        return _IconConfig(
          emoji: '🍩',
          gradientColors: [const Color(0xFFF472B6), const Color(0xFFDB2777)],
        );
      case HealthIconType.iceCream:
        return _IconConfig(
          emoji: '🍦',
          gradientColors: [const Color(0xFFA78BFA), const Color(0xFF7C3AED)],
        );
      case HealthIconType.fruit:
        return _IconConfig(
          emoji: '🍎',
          gradientColors: [const Color(0xFF34D399), const Color(0xFF059669)],
        );
      case HealthIconType.packagedSnack:
        return _IconConfig(
          emoji: '🥨',
          gradientColors: [const Color(0xFFFB923C), const Color(0xFFEA580C)],
        );
      case HealthIconType.dessert:
        return _IconConfig(
          emoji: '🍰',
          gradientColors: [const Color(0xFFFDA4AF), const Color(0xFFE11D48)],
        );
      case HealthIconType.juice:
        return _IconConfig(
          emoji: '🧃',
          gradientColors: [const Color(0xFFFBBF24), const Color(0xFFD97706)],
        );
    }
  }
}

enum HealthIconType {
  water,
  calories,
  weight,
  bmi,
  workout,
  meal,
  mood,
  health,
  sugar,
  leaderboard,
  chai,
  coldDrink,
  sweets,
  snack,
  coffee,
  soda,
  donut,
  iceCream,
  fruit,
  packagedSnack,
  dessert,
  juice,
}

class _IconConfig {
  final String emoji;
  final List<Color> gradientColors;

  const _IconConfig({required this.emoji, required this.gradientColors});
}
