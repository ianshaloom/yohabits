import 'package:hive_flutter/hive_flutter.dart';

import '../../../Helpers/data_helpers.dart';
import '../habit/habit.dart';

part 'habit_history.g.dart';

@HiveType(typeId: 1)
class HabitsRecord extends HiveObject {
  @HiveField(0)
  String id = DataHelpers.generateCode(10);

  @HiveField(1)
  List<Habit> habits;

  @HiveField(2)
  final DateTime date;

  // HabitsHistory empty obj getter
  static HabitsRecord get empty {
    return HabitsRecord(
      habits: [],
      date: DateTime.now(),
    );
  }

  HabitsRecord({
    required this.habits,
    required this.date,
  });
}
