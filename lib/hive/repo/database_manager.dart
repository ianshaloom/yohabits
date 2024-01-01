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

  // properties
  final HabitHistoryRepo _habitHistoryRepo = HabitHistoryRepo();
  final HabitRepo _habitRepo = HabitRepo();

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
  // Future<HabitsRecord> todaysHabitsRecord() async {
  //   HabitsRecord habitHistory =
  //       await _habitHistoryRepo.getHabitRecord(todaysDate());
  //   return habitHistory;
  // }
}
