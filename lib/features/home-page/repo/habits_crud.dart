import '../../../hive/models/habit/habit.dart';
import '../../../hive/models/history/habit_history.dart';

class HabitsCrud {
  // factory constructor
  HabitsCrud._internal();
  static final HabitsCrud _instance = HabitsCrud._internal();
  factory HabitsCrud() => _instance;

  // mark habit done
  Future<bool> markHabitDone(
      HabitsRecord record, int index, bool isCompleted) async {
    Habit habit = record.habits[index];

    // mark habit done or not
    habit.isCompleted = isCompleted;

    // add today's date
    if (isCompleted) {
      habit.daysCompleted.add(DateTime.now());
    } else {
      habit.daysCompleted.removeLast();
    }

    // update streak
    habit.streak = habit.daysCompleted.length;

    // update record
    record.habits[index] = habit;

    await record.save();
    return isCompleted;
  }

  // delete habit
  Future deleteHabit(HabitsRecord record, int index) async {
    record.habits.removeAt(index);
    await record.save();
  }
}
