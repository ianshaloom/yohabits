import 'package:hive_flutter/hive_flutter.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  final String habitId;

  @HiveField(1)
  String habitName;

  @HiveField(2)
  String habitDescription = '';

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  final DateTime dateCreated;

  @HiveField(5)
  List<DateTime> daysCompleted = [];

  @HiveField(6)
  int streak = 0;

  Habit({
    required this.habitId,
    required this.habitName,
    this.habitDescription = '',
    required this.isCompleted,
    required this.dateCreated,
    this.daysCompleted = const [],
    this.streak = 0,
  });
}
