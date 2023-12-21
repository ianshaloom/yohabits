import 'package:hive_flutter/hive_flutter.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  final String habitId;

  @HiveField(1)
  String habitName;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  final DateTime dateCreated;

  @HiveField(4)
  List<DateTime> daysCompleted = [];

  @HiveField(5)
  int streak = 0;

  Habit({
    required this.habitId,
    required this.habitName,
    required this.isCompleted,
    required this.dateCreated,
    this.daysCompleted = const [],
    this.streak = 0,
  });
}
