import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../models/sugar_log_model.dart';
import '../../providers/sugar_log_provider.dart';
import '../../services/voice_log_service.dart';
import '../../widgets/glass_widgets.dart';

/// One-tap sugar logging widget — Quick-Add strip + expandable Sugar Drawer.
/// Goal: user completes a log in under 10 seconds.
class QuickLogWidget extends ConsumerStatefulWidget {
  const QuickLogWidget({super.key});

  @override
  ConsumerState<QuickLogWidget> createState() => _QuickLogWidgetState();
}

class _QuickLogWidgetState extends ConsumerState<QuickLogWidget>
    with SingleTickerProviderStateMixin {
  bool _drawerExpanded = false;
  late final AnimationController _expandController;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    if (!kIsWeb) HapticFeedback.lightImpact();
    setState(() => _drawerExpanded = !_drawerExpanded);
    if (_drawerExpanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sugarState = ref.watch(sugarLogProvider);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.10),
                Colors.white.withOpacity(0.04),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Header row ───
              Row(
                children: [
                  const Text('🍬', style: TextStyle(fontSize: 22)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Quick Sugar Log',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Voice-log mic button
                  const _VoiceMicButton(),
                  const SizedBox(width: 8),
                  // Today's running total pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _sugarColor(sugarState.totalSugarToday),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${sugarState.totalSugarToday.toStringAsFixed(0)} g today',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // ─── Quick-add 2x2 Bento grid (core 4) ───
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.6,
                ),
                itemCount: SugarPresets.quickPresets.length,
                itemBuilder: (context, index) {
                  return _PresetCard(
                      preset: SugarPresets.quickPresets[index]);
                },
              ),
              const SizedBox(height: 12),

              // ─── "See All" Toggle ───
              GestureDetector(
                onTap: _toggleDrawer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _drawerExpanded ? 'Show Less' : 'Browse Full Library',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.novaBlue,
                      ),
                    ),
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      turns: _drawerExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppTheme.novaBlue,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),

              // ─── Expanded Sugar Drawer ───
              SizeTransition(
                sizeFactor: _expandAnimation,
                axisAlignment: -1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Sugar Library',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.78,
                        ),
                        itemCount: SugarPresets.extendedPresets.length,
                        itemBuilder: (context, index) {
                          return _PresetCard(
                            preset: SugarPresets.extendedPresets[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _sugarColor(double grams) {
    if (grams <= 25) return AppTheme.emerald;
    if (grams <= 50) return AppTheme.amber;
    return const Color(0xFFEF4444);
  }
}

// ──────────────────────────────────────────────────
//  Voice Mic Button with recognition
// ──────────────────────────────────────────────────

class _VoiceMicButton extends ConsumerStatefulWidget {
  const _VoiceMicButton();

  @override
  ConsumerState<_VoiceMicButton> createState() => _VoiceMicButtonState();
}

class _VoiceMicButtonState extends ConsumerState<_VoiceMicButton>
    with SingleTickerProviderStateMixin {
  final VoiceLogService _voiceService = VoiceLogService();
  bool _isListening = false;
  String _recognizedText = '';
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _voiceService.stopListening();
      _pulseController.stop();
      setState(() => _isListening = false);
      _processResult();
      return;
    }

    // Start listening
    final available = await _voiceService.initialize();
    if (!available && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Speech recognition is not available on this device'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isListening = true;
      _recognizedText = '';
    });
    _pulseController.repeat(reverse: true);

    // Show listening bottom sheet
    if (mounted) {
      _showListeningSheet();
    }

    await _voiceService.startListening(
      onResult: (words) {
        setState(() => _recognizedText = words);
      },
    );

    // Auto-stop after timeout
    await Future.delayed(const Duration(seconds: 8));
    if (_isListening && mounted) {
      await _voiceService.stopListening();
      _pulseController.stop();
      setState(() => _isListening = false);
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop(); // dismiss sheet
      }
      _processResult();
    }
  }

  void _showListeningSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.midnightLight,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.slate,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Pulsing mic icon
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_pulseController.value * 0.2),
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF8B5CF6),
                                const Color(0xFFEC4899),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF8B5CF6)
                                    .withOpacity(0.3 + _pulseController.value * 0.3),
                                blurRadius: 16 + _pulseController.value * 12,
                                spreadRadius: _pulseController.value * 4,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.mic, color: Colors.white, size: 34),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _isListening ? 'Listening...' : 'Processing...',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8B5CF6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _recognizedText.isEmpty
                        ? 'Say something like "I had a chai" or "Drinking a cold drink"'
                        : '"$_recognizedText"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: _recognizedText.isEmpty
                          ? FontStyle.italic
                          : FontStyle.normal,
                      color: AppTheme.slateLight,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      _voiceService.cancel();
                      _pulseController.stop();
                      setState(() => _isListening = false);
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      // If sheet dismissed by swipe, stop listening
      if (_isListening) {
        _voiceService.stopListening();
        _pulseController.stop();
        setState(() => _isListening = false);
      }
    });
  }

  void _processResult() {
    if (_recognizedText.isEmpty) return;

    final preset = _voiceService.matchPreset(_recognizedText);
    if (preset != null) {
      ref.read(sugarLogProvider.notifier).quickLog(preset);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${preset.emoji} Logged "${preset.label}" via voice!'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(preset.color),
          ),
        );
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Couldn\'t match "$_recognizedText" — try "chai", "cold drink", "sweets", or "snack"',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleListening,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: _isListening
              ? const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                )
              : const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
          boxShadow: _isListening
              ? [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withOpacity(0.5),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Icon(
          _isListening ? Icons.hearing : Icons.mic,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────
//  Individual preset tap-card
// ──────────────────────────────────────────────────

class _PresetCard extends ConsumerStatefulWidget {
  final SugarPreset preset;
  const _PresetCard({required this.preset});

  @override
  ConsumerState<_PresetCard> createState() => _PresetCardState();
}

class _PresetCardState extends ConsumerState<_PresetCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _tapController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    // Haptic feedback for speed feel (skip on web — unsupported)
    if (!kIsWeb) HapticFeedback.mediumImpact();

    // Press animation
    await _tapController.forward();
    await _tapController.reverse();

    // Fire log
    final success =
        await ref.read(sugarLogProvider.notifier).quickLog(widget.preset);

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not log — try again')),
      );
    }
    // On success, the SuccessAnimationOverlay picks up state.lastLog != null
  }

  @override
  Widget build(BuildContext context) {
    final isLogging = ref.watch(sugarLogProvider).isLogging;
    final iconType = _presetIconType(widget.preset.type);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: GestureDetector(
          onTap: isLogging ? null : _onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(widget.preset.color).withOpacity(0.18),
                  Color(widget.preset.color).withOpacity(0.06),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Color(widget.preset.color).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HealthIcon(type: iconType, size: 24),
                const SizedBox(height: 6),
                Text(
                  widget.preset.label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${widget.preset.estimatedSugarGrams.toInt()} g',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                if (widget.preset.isSmartChoice) ...[
                  const SizedBox(height: 3),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: AppTheme.emerald.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'SMART',
                      style: TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.emerald,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  HealthIconType _presetIconType(String type) {
    switch (type) {
      case 'chai':
        return HealthIconType.chai;
      case 'cold_drink':
        return HealthIconType.coldDrink;
      case 'sweets':
        return HealthIconType.sweets;
      case 'snack':
        return HealthIconType.snack;
      case 'coffee':
        return HealthIconType.coffee;
      case 'soda':
        return HealthIconType.soda;
      case 'donut':
        return HealthIconType.donut;
      case 'ice_cream':
        return HealthIconType.iceCream;
      case 'fruit':
        return HealthIconType.fruit;
      case 'packaged_snack':
        return HealthIconType.packagedSnack;
      case 'dessert':
        return HealthIconType.dessert;
      case 'juice':
        return HealthIconType.juice;
      default:
        return HealthIconType.sugar;
    }
  }
}
