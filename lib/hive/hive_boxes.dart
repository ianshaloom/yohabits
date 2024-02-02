import 'package:hive_flutter/hive_flutter.dart';

import '../constants/hive_constants.dart';
import 'models/habit/habit.dart';
import 'models/history/habit_history.dart';
import 'models/onboard/onboard.dart';
import 'models/userprofile/userprofile.dart';

class HiveBoxes {
  static Box<Habit> get habitsBox => Hive.box<Habit>(habitBox);
  static Box<Onboard> get onboardsBox => Hive.box<Onboard>(onboardBox);
  static Box<UserProfile> get userProfilesBox =>
      Hive.box<UserProfile>(userProfileBox);
  static Box<HabitsRecord> get habitHistoriesBox =>
      Hive.box<HabitsRecord>(habitHistoryBox);
}
