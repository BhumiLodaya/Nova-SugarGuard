import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import 'database_service.dart';

/// Manages anonymous guest sessions using a device-based UUID.
/// Firebase Auth stays completely dormant in guest mode.
class GuestService {
  static final GuestService _instance = GuestService._internal();
  factory GuestService() => _instance;
  GuestService._internal();

  static const String _guestBoxName = 'guest_box';
  static const String _keyGuestId = 'guest_device_id';
  static const String _keyIsGuest = 'is_guest';
  static const String _keyOnboardingComplete = 'onboarding_complete';
  static const String _keySugarLogCount = 'sugar_log_count';
  static const String _keyXp = 'guest_xp';

  final DatabaseService _db = DatabaseService();

  /// Open (or re-open) the guest Hive box.
  Future<Box> _openBox() async {
    if (Hive.isBoxOpen(_guestBoxName)) {
      return Hive.box(_guestBoxName);
    }
    return await Hive.openBox(_guestBoxName);
  }

  // --------------- Guest ID ---------------

  /// Returns the device-local guest ID, creating one if none exists.
  Future<String> getOrCreateGuestId() async {
    final box = await _openBox();
    String? id = box.get(_keyGuestId);
    if (id == null) {
      id = const Uuid().v4();
      await box.put(_keyGuestId, id);
    }
    return id;
  }

  // --------------- Guest Flag ---------------

  Future<void> setGuestMode(bool value) async {
    final box = await _openBox();
    await box.put(_keyIsGuest, value);
  }

  Future<bool> isGuestMode() async {
    final box = await _openBox();
    return box.get(_keyIsGuest, defaultValue: false) as bool;
  }

  // --------------- Onboarding ---------------

  Future<void> setOnboardingComplete(bool value) async {
    final box = await _openBox();
    await box.put(_keyOnboardingComplete, value);
  }

  Future<bool> isOnboardingComplete() async {
    final box = await _openBox();
    return box.get(_keyOnboardingComplete, defaultValue: false) as bool;
  }

  // --------------- Sugar Logging Counter (for "Value-First" gate) ---------------

  Future<int> getSugarLogCount() async {
    final box = await _openBox();
    return box.get(_keySugarLogCount, defaultValue: 0) as int;
  }

  Future<void> incrementSugarLogCount() async {
    final box = await _openBox();
    final current = box.get(_keySugarLogCount, defaultValue: 0) as int;
    await box.put(_keySugarLogCount, current + 1);
  }

  // --------------- XP ---------------

  Future<int> getXp() async {
    final box = await _openBox();
    return box.get(_keyXp, defaultValue: 0) as int;
  }

  Future<void> addXp(int amount) async {
    final box = await _openBox();
    final current = box.get(_keyXp, defaultValue: 0) as int;
    await box.put(_keyXp, current + amount);
  }

  // --------------- Guest User Profile ---------------

  /// Creates a local-only UserModel for a guest. No Firebase calls.
  Future<UserModel> createGuestUser({
    int? age,
    double? heightCm,
    double? weightKg,
    String? gender,
  }) async {
    final guestId = await getOrCreateGuestId();
    final now = DateTime.now();

    // Derive date-of-birth from age
    DateTime? dob;
    if (age != null) {
      dob = DateTime(now.year - age, now.month, now.day);
    }

    final user = UserModel(
      id: guestId,
      email: 'guest@local',
      username: 'Guest',
      fullName: null,
      gender: gender,
      dateOfBirth: dob,
      weight: weightKg,
      height: heightCm,
      createdAt: now,
      updatedAt: now,
      notificationPreferences: {
        'hydration': true,
        'workout': true,
        'meal': true,
        'period': false,
      },
    );

    // Persist locally
    await _db.saveUser(user);
    await _db.saveSetting(AppConstants.keyUserId, guestId);
    await _db.saveSetting(AppConstants.keyIsLoggedIn, true);
    await setGuestMode(true);

    return user;
  }

  /// Update the guest user after onboarding data is collected.
  Future<UserModel> updateGuestProfile({
    required int age,
    required double heightCm,
    required double weightKg,
    required String gender,
  }) async {
    final guestId = await getOrCreateGuestId();
    final existing = _db.getUser(guestId);
    final now = DateTime.now();
    final dob = DateTime(now.year - age, now.month, now.day);

    final updated = (existing ?? UserModel(
      id: guestId,
      email: 'guest@local',
      username: 'Guest',
      createdAt: now,
      updatedAt: now,
    )).copyWith(
      gender: gender,
      dateOfBirth: dob,
      weight: weightKg,
      height: heightCm,
      updatedAt: now,
    );

    await _db.saveUser(updated);
    await setOnboardingComplete(true);

    return updated;
  }

  /// Whether the guest has earned the right to be prompted for sign-up.
  Future<bool> hasReachedSignupGate() async {
    final xp = await getXp();
    // Gate: 100 XP (streaks checked separately via StreakProvider)
    return xp >= 100;
  }

  /// Clear all guest data (called when upgrading to a real account).
  Future<void> clearGuestData() async {
    final box = await _openBox();
    await box.clear();
  }
}
