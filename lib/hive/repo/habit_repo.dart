import 'package:hive_flutter/hive_flutter.dart';

import '../hive_boxes.dart';
import '../models/habit/habit.dart';

class HabitRepo {
  HabitRepo._(this._habitBox);
  static final HabitRepo _instance = HabitRepo._(HiveBoxes.habitsBox);
  factory HabitRepo() => _instance;

  final Box<Habit> _habitBox;

  Future<void> addDefaultHabits(List<Habit> habits) async {
    await _habitBox.addAll(habits);
  }

  Future<void> addHabit(Habit habit) async {
    await _habitBox.add(habit);
  }

  Future<List<Habit>> getHabits() async {
    final habits = _habitBox.values.toList();
    return habits;
  }
  
  Future<Habit> getHabitById(String habitId) async {
    final List<Habit> habits = _habitBox.values.toList();
    final Habit habit = habits.firstWhere((habit) => habit.habitId == habitId);
    return habit;
  }


  Future<void> deleteAllHabits() async {
    await _habitBox.clear();
  }
}
