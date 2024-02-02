import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/hive_constants.dart';
import '../../features/home-page/repo/date_time.dart';
import '../models/history/habit_history.dart';

class HabitHistoryRepo {
  HabitHistoryRepo._(this._habitHistoryBox);
  static final HabitHistoryRepo _instance =
      HabitHistoryRepo._(Hive.box<HabitsRecord>(habitHistoryBox));
  factory HabitHistoryRepo() => _instance;

  final Box<HabitsRecord> _habitHistoryBox;

  Future<void> addHabitHistory(HabitsRecord habitHistory) async {
    String key = todaysDate();
    await _habitHistoryBox.put(key, habitHistory);
  }

  Future<HabitsRecord?> getHabitRecord(String key) async {
    final habitHistory = _habitHistoryBox.get(key);
    return habitHistory;
  }

  Future<List<HabitsRecord>> getHabitRecords() async {
    final habitHistories = _habitHistoryBox.values.toList();
    return habitHistories;
  }

  Future<void> deleteAllHabitHistories() async {
    await _habitHistoryBox.clear();
  }
}

String todayssDate = () {
  final now = DateTime.now();
  return '${now.day}-${now.month}-${now.year}';
}();
