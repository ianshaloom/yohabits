import 'package:flutter/material.dart';

import '../../../hive/models/habit/habit.dart';
import '../../../hive/models/history/habit_history.dart';
import '../../../hive/models/userprofile/userprofile.dart';
import '../../../hive/repo/habit_history_repo.dart';
import '../../../hive/repo/habit_repo.dart';
import '../../../hive/repo/userprofile_repo.dart';
import '../repo/date_time.dart';

class HomepageProvider with ChangeNotifier {
  final UserProfileRepo _userProfileRepo = UserProfileRepo();
  final HabitRepo _habitRepo = HabitRepo();
  final HabitHistoryRepo _habitHistoryRepo = HabitHistoryRepo();

  UserProfile _userProfile = UserProfile();
  List<Habit> _habits = [];

  UserProfile get userProfile => _userProfile;
  List<Habit> get habits => _habits;

  void fetchUserProfile() async {
    _userProfile = await _userProfileRepo.getUserProfileObject();
    notifyListeners();
  }

  void fetchHabits() async {
    // _todaysHabitsRecord = await _habitsDatabase.loadCurrentDb();

    _habits = await _habitRepo.getHabits();
    notifyListeners();
  }

  void addHabit(Habit habit) async {
    final HabitsRecord? habitHistory =
        await _habitHistoryRepo.getHabitRecord(todaysDate());
        
    habitHistory!.habits.add(habit);
    await habitHistory.save();

    await _habitRepo.addHabit(habit);
    _habits = await _habitRepo.getHabits();
    notifyListeners();
  }
}
