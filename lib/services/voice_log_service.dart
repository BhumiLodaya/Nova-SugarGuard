import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../models/sugar_log_model.dart';

/// Maps spoken phrases to sugar presets for voice-based logging.
class VoiceLogService {
  static final VoiceLogService _instance = VoiceLogService._internal();
  factory VoiceLogService() => _instance;
  VoiceLogService._internal();

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isInitialized = false;

  /// Keyword → preset-type mapping.
  /// Intentionally broad to catch natural speech variations.
  static const Map<String, String> _keywordMap = {
    // Chai / Tea
    'chai': 'chai',
    'tea': 'chai',
    'green tea': 'chai',
    'masala chai': 'chai',
    'latte': 'chai',
    'coffee': 'chai',

    // Cold Drink / Soda
    'cold drink': 'cold_drink',
    'soda': 'cold_drink',
    'coke': 'cold_drink',
    'pepsi': 'cold_drink',
    'sprite': 'cold_drink',
    'fanta': 'cold_drink',
    'juice': 'cold_drink',
    'soft drink': 'cold_drink',
    'energy drink': 'cold_drink',
    'iced tea': 'cold_drink',
    'milkshake': 'cold_drink',
    'smoothie': 'cold_drink',
    'lemonade': 'cold_drink',

    // Sweets
    'sweet': 'sweets',
    'sweets': 'sweets',
    'mithai': 'sweets',
    'gulab jamun': 'sweets',
    'rasgulla': 'sweets',
    'chocolate': 'sweets',
    'candy': 'sweets',
    'cake': 'sweets',
    'pastry': 'sweets',
    'ice cream': 'sweets',
    'dessert': 'sweets',
    'jalebi': 'sweets',
    'ladoo': 'sweets',
    'laddu': 'sweets',
    'brownie': 'sweets',
    'donut': 'sweets',
    'doughnut': 'sweets',

    // Snack
    'snack': 'snack',
    'biscuit': 'snack',
    'cookie': 'snack',
    'cookies': 'snack',
    'chips': 'snack',
    'crackers': 'snack',
    'granola': 'snack',
    'bar': 'snack',
    'cereal': 'snack',
    'muffin': 'snack',
    'wafer': 'snack',
    'rusk': 'snack',
  };

  /// Initialize the speech recognizer. Returns `true` if available.
  Future<bool> initialize() async {
    if (kIsWeb) {
      // speech_to_text has limited web support — attempt init anyway
      try {
        _isInitialized = await _speech.initialize(
          onError: (e) => debugPrint('[VoiceLog] Error: ${e.errorMsg}'),
          onStatus: (s) => debugPrint('[VoiceLog] Status: $s'),
        );
      } catch (_) {
        _isInitialized = false;
      }
      return _isInitialized;
    }
    _isInitialized = await _speech.initialize(
      onError: (e) => debugPrint('[VoiceLog] Error: ${e.errorMsg}'),
      onStatus: (s) => debugPrint('[VoiceLog] Status: $s'),
    );
    return _isInitialized;
  }

  bool get isAvailable => _isInitialized;
  bool get isListening => _speech.isListening;

  /// Start listening. Returns recognized words via [onResult].
  Future<void> startListening({
    required void Function(String words) onResult,
    void Function()? onDone,
  }) async {
    if (!_isInitialized) {
      final success = await initialize();
      if (!success) return;
    }
    await _speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
      },
      listenFor: const Duration(seconds: 8),
      pauseFor: const Duration(seconds: 3),
      partialResults: true,
      listenOptions: stt.SpeechListenOptions(cancelOnError: true),
    );
  }

  /// Stop listening.
  Future<void> stopListening() async {
    await _speech.stop();
  }

  /// Cancel without processing.
  Future<void> cancel() async {
    await _speech.cancel();
  }

  /// Match spoken text to a [SugarPreset]. Returns `null` if no match.
  SugarPreset? matchPreset(String spokenText) {
    final lower = spokenText.toLowerCase().trim();

    // Try longest keywords first for better matching
    // (e.g., "cold drink" before "drink")
    final sortedKeys = _keywordMap.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    for (final keyword in sortedKeys) {
      if (lower.contains(keyword)) {
        final type = _keywordMap[keyword]!;
        return SugarPresets.all.firstWhere((p) => p.type == type);
      }
    }
    return null;
  }
}
