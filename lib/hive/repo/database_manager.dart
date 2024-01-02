import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../hive_boxes.dart';
import '../models/habit/habit.dart';
import '../models/history/habit_history.dart';
import 'habit_history_repo.dart';
import 'habit_repo.dart';
import '../../features/home-page/repo/date_time.dart';

class DatabaseManager {
  // factory constructor
  DatabaseManager._internal();
  static final DatabaseManager _instance = DatabaseManager._internal();
  factory DatabaseManager() {
    return _instance;
  }

  final GetMeFromHive _getMeFromHive = GetMeFromHive();

  // load data if already exixsts
  Future<HabitsRecord> loadCurrentDb() async {
    // if its a new day, get habit list from database
    HabitsRecord? habitHistory =
        await _habitHistoryRepo.getHabitRecord(todaysDate());

    if (habitHistory == null) {
      // fetch habits from database
      List<Habit> habits = await _habitRepo.getHabits();

      if (habits.isEmpty) {
        HabitsRecord empty = HabitsRecord.empty;
        await _habitHistoryRepo.addHabitHistory(empty);
        return empty;
      }

      // set all habits to false
      for (int i = 0; i < habits.length; i++) {
        habits[i].isCompleted = false;
      }

      // create new habit history
      habitHistory = HabitsRecord(
        date: DateTime.now(),
        habits: habits,
      );

      // add habit history to database
      await _habitHistoryRepo.addHabitHistory(habitHistory);

      // return habit history
      return habitHistory;
    } else {
      // if its not a new day, load todays list
      habitHistory = await _habitHistoryRepo.getHabitRecord(todaysDate());
      return habitHistory!;
    }
  }

  // fetch today's habit record
  Future<HabitsRecord?> todaysHabitsRecord() async {
    HabitsRecord? habitHistory =
        await _habitHistoryRepo.getHabitRecord(todaysDate());
    return habitHistory;
  }

  // compute streaks
  int computeStreaks(List<DateTime> daysCompleted) {
    int streaks = 0;

    // Sort dates in descending order
    daysCompleted.sort((a, b) => b.compareTo(a));
    print('Days completed: ${daysCompleted.length}');

    try {
      for (int i = 0; i < (daysCompleted.length - 1); i++) {
        // Check if the difference between consecutive dates is one day
        if (daysCompleted[i].difference(daysCompleted[i + 1]).inDays == 1) {
          streaks++;
        } else {
          break;
        }
      }
    } on Exception catch (e) {
      debugPrint('Error: ${e.toString()}');
    }

    return streaks;
  }

  // mark habit done
  void printt(List<DateTime> daysCompleted) {
    daysCompleted.sort((a, b) => b.compareTo(a));

    int i = 0;

    for (var element in daysCompleted) {
      print('${element.day} is at index $i');
      i++;
    }
  }

  Future<bool> markHabitDone(
      HabitsRecord record, Habit habit, bool isCompleted) async {
    final date = DateFormat.yMMMd().format(DateTime.now());

    // mark habit done or not
    habit.isCompleted = isCompleted;

    // add today's date
    if (isCompleted) {
      habit.daysCompleted.add(DateTime.now());
      printt(habit.daysCompleted);
    } else {
      habit.daysCompleted.removeWhere(
        (element) {
          if (DateFormat.yMMMd().format(element) == date) {
            return true;
          } else {
            return false;
          }
        },
      );
      printt(habit.daysCompleted);
    }

    // update streaks made by consecutive days completed
    int streaks = computeStreaks(habit.daysCompleted);
    habit.streak = streaks;

    // update habit
    await habit.save();

    // update record
    record.habits = _getMeFromHive.habits;
    await record.save();

    return isCompleted;
  }

  // delete habit
  Future deleteHabit(HabitsRecord record, int index) async {
    record.habits.removeAt(index);
    await record.save();
  }
}

// global properties
final HabitHistoryRepo _habitHistoryRepo = HabitHistoryRepo();
final HabitRepo _habitRepo = HabitRepo();

class GetMeFromHive {
  List<Habit> get habits => HiveBoxes.habitsBox.values.toList();
  Map<String, HabitsRecord> get habitsRecord {
    Map<String, HabitsRecord> map = {};

    map = HiveBoxes.habitHistoriesBox.toMap().cast<String, HabitsRecord>();

    return map;
  }

  // get habit by id
  Habit getHabitByIdFromRecord(HabitsRecord record, String habitId) {
    Habit habit = Habit.empty;

    record.habits.firstWhere((element) {
      if (element.habitId == habitId) {
        habit = element;
        return true;
      } else {
        return false;
      }
    });

    return habit;
  }

  // get habit by id
  Future<Habit> getHabitByIdFrmRecord(String habitId, String recordKey) async {
    habitsRecord.forEach((key, value) {
      print('key: $key, value: $value');
    });

    HabitsRecord? record = await _habitHistoryRepo.getHabitRecord(recordKey);

    if (record == null) {
      return Habit.empty;
    }

    Habit habit = Habit.empty;
    record.habits.firstWhere((element) {
      if (element.habitId == habitId) {
        habit = element;
        return true;
      } else {
        return false;
      }
    });

    return habit;
  }

  // factory constructor
  GetMeFromHive._internal();
  static final GetMeFromHive _instance = GetMeFromHive._internal();
  factory GetMeFromHive() => _instance;
}
