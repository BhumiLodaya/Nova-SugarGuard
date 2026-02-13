// App Constants
class AppConstants {
  // App Info
  static const String appName = 'NovaHealth';
  static const String appVersion = '1.0.0';

  // Colors — Professional Midnight / Amber / Emerald palette
  static const int primaryGreen = 0xFF10B981;   // Emerald (replaces old green)
  static const int darkGreen = 0xFF059669;       // Deep Emerald
  static const int lightGreen = 0xFF0F172A;      // Deep Midnight (scaffold bg)
  static const int peach = 0xFFF59E0B;           // Energetic Amber
  static const int lightPeach = 0xFFFBBF24;      // Light Amber
  static const int accentGreen = 0x6610B981;     // Emerald 40%
  static const int mediumGreen = 0xE234D399;     // Emerald light

  // New professional palette constants
  static const int midnight = 0xFF0F172A;
  static const int midnightLight = 0xFF1E293B;
  static const int midnightCard = 0xFF1E293B;
  static const int slate = 0xFF334155;
  static const int slateLight = 0xFF64748B;
  static const int amber = 0xFFF59E0B;
  static const int amberLight = 0xFFFBBF24;
  static const int emerald = 0xFF10B981;
  static const int emeraldDeep = 0xFF059669;
  static const int surfaceWhite = 0xFFFFFFFF;
  static const int novaBlue = 0xFF38BDF8;       // Primary Nova Blue
  static const int novaBlueDeep = 0xFF0EA5E9;   // Deeper Nova Blue

  // Database
  static const String userBox = 'user_box';
  static const String healthBox = 'health_box';
  static const String workoutBox = 'workout_box';
  static const String nutritionBox = 'nutrition_box';
  static const String settingsBox = 'settings_box';

  // Preferences Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserId = 'user_id';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';

  // 🔐 Health data consent
  static const String keyConsentGiven = 'consent_given';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int minAge = 13;
  static const int maxAge = 120;

  // Activity Levels
  static const Map<String, double> activityMultipliers = {
    'sedentary': 1.2,
    'lightly_active': 1.375,
    'moderately_active': 1.55,
    'very_active': 1.725,
    'extra_active': 1.9,
  };

  // Health Metrics
  static const double waterIntakePerKg = 0.033; // liters per kg body weight
  static const int defaultWaterGoalMl = 2000;
  static const int defaultCalorieGoal = 2000;

  // UI
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const int pageTransitionDuration = 300;
}
