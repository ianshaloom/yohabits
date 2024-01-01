import 'package:hive_flutter/hive_flutter.dart';

import '../constants.dart';
import 'models/habit/habit.dart';
import 'models/history/habit_history.dart';
import 'models/onboard/onboard.dart';
import 'models/userprofile/userprofile.dart';

class HiveInitialization {
  static Future<void> initFlutter(String subDir) async {
    Hive.init(subDir);
    await Hive.openBox<Habit>(habitBox);
    await Hive.openBox<Onboard>(onboardBox);
    await Hive.openBox<UserProfile>(userProfileBox);
    await Hive.openBox<HabitsRecord>(habitHistoryBox);
  }

  static Future<void> registerAdapters() async {
    Hive.registerAdapter(HabitAdapter());
    Hive.registerAdapter(OnboardAdapter());
    Hive.registerAdapter(UserProfileAdapter());
    Hive.registerAdapter(HabitsRecordAdapter());
  }
}
