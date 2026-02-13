import 'package:hive/hive.dart';

part 'sugar_log_model.g.dart';

/// Represents a single sugar-intake logging event.
/// Designed for fast "one-tap" logging — goal is < 10 seconds per entry.
@HiveType(typeId: 20) // high typeId to avoid collisions with existing models
class SugarLogModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  DateTime loggedAt;

  /// One of the preset categories: chai, cold_drink, sweets, snack
  @HiveField(3)
  String sugarType;

  /// Human-readable label (e.g. "Chai", "Cold Drink")
  @HiveField(4)
  String label;

  /// Estimated sugar in grams for this preset
  @HiveField(5)
  double estimatedSugarGrams;

  /// Estimated calories for this preset
  @HiveField(6)
  double estimatedCalories;

  /// Optional note added by the user
  @HiveField(7)
  String? note;

  /// XP awarded for this log
  @HiveField(8)
  int xpEarned;

  SugarLogModel({
    required this.id,
    required this.userId,
    required this.loggedAt,
    required this.sugarType,
    required this.label,
    required this.estimatedSugarGrams,
    required this.estimatedCalories,
    this.note,
    this.xpEarned = 10,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'loggedAt': loggedAt.toIso8601String(),
        'sugarType': sugarType,
        'label': label,
        'estimatedSugarGrams': estimatedSugarGrams,
        'estimatedCalories': estimatedCalories,
        'note': note,
        'xpEarned': xpEarned,
      };

  factory SugarLogModel.fromJson(Map<String, dynamic> json) => SugarLogModel(
        id: json['id'],
        userId: json['userId'],
        loggedAt: DateTime.parse(json['loggedAt']),
        sugarType: json['sugarType'],
        label: json['label'],
        estimatedSugarGrams: (json['estimatedSugarGrams'] as num).toDouble(),
        estimatedCalories: (json['estimatedCalories'] as num).toDouble(),
        note: json['note'],
        xpEarned: json['xpEarned'] ?? 10,
      );
}

/// Presets for one-tap sugar logging.
/// Expanded library with 8 categories for the Sugar Drawer.
class SugarPresets {
  /// Core 4 presets shown in the collapsed quick-add strip.
  static const List<SugarPreset> quickPresets = [
    SugarPreset(
      type: 'chai',
      label: 'Chai',
      emoji: '☕',
      estimatedSugarGrams: 10,
      estimatedCalories: 60,
      color: 0xFFD4A373,
    ),
    SugarPreset(
      type: 'cold_drink',
      label: 'Cold Drink',
      emoji: '🥤',
      estimatedSugarGrams: 35,
      estimatedCalories: 140,
      color: 0xFFE63946,
    ),
    SugarPreset(
      type: 'sweets',
      label: 'Sweets',
      emoji: '🍬',
      estimatedSugarGrams: 25,
      estimatedCalories: 180,
      color: 0xFFF4A261,
    ),
    SugarPreset(
      type: 'snack',
      label: 'Snack',
      emoji: '🍪',
      estimatedSugarGrams: 15,
      estimatedCalories: 120,
      color: 0xFF8D99AE,
    ),
  ];

  /// Extended presets shown when the Sugar Drawer is expanded.
  static const List<SugarPreset> extendedPresets = [
    SugarPreset(
      type: 'coffee',
      label: 'Coffee',
      emoji: '☕',
      estimatedSugarGrams: 12,
      estimatedCalories: 80,
      color: 0xFF6F4E37,
    ),
    SugarPreset(
      type: 'soda',
      label: 'Soda',
      emoji: '🥤',
      estimatedSugarGrams: 39,
      estimatedCalories: 150,
      color: 0xFFDC2626,
    ),
    SugarPreset(
      type: 'donut',
      label: 'Donut',
      emoji: '🍩',
      estimatedSugarGrams: 22,
      estimatedCalories: 250,
      color: 0xFFEC4899,
    ),
    SugarPreset(
      type: 'ice_cream',
      label: 'Ice Cream',
      emoji: '🍦',
      estimatedSugarGrams: 28,
      estimatedCalories: 210,
      color: 0xFF8B5CF6,
    ),
    SugarPreset(
      type: 'fruit',
      label: 'Fruit',
      emoji: '🍎',
      estimatedSugarGrams: 12,
      estimatedCalories: 65,
      color: 0xFF10B981,
      isSmartChoice: true,
    ),
    SugarPreset(
      type: 'packaged_snack',
      label: 'Packaged',
      emoji: '🥨',
      estimatedSugarGrams: 18,
      estimatedCalories: 160,
      color: 0xFFFF8C00,
    ),
    SugarPreset(
      type: 'dessert',
      label: 'Dessert',
      emoji: '🍰',
      estimatedSugarGrams: 32,
      estimatedCalories: 280,
      color: 0xFFE11D48,
    ),
    SugarPreset(
      type: 'juice',
      label: 'Juice',
      emoji: '🧃',
      estimatedSugarGrams: 24,
      estimatedCalories: 110,
      color: 0xFFFB923C,
    ),
  ];

  /// All presets (quick + extended) for backward compatibility.
  static const List<SugarPreset> all = quickPresets;
}

class SugarPreset {
  final String type;
  final String label;
  final String emoji;
  final double estimatedSugarGrams;
  final double estimatedCalories;
  final int color;
  final bool isSmartChoice;

  const SugarPreset({
    required this.type,
    required this.label,
    required this.emoji,
    required this.estimatedSugarGrams,
    required this.estimatedCalories,
    required this.color,
    this.isSmartChoice = false,
  });
}
