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

  // getters
  int get streaks => computeStreaks();

  int computeStreaks() {
    int streaks = 0;

    if (daysCompleted.isEmpty) return streaks;

    // if habit was not completed yesterday, return 0
    // if (daysCompleted.first.difference(DateTime.now()).inDays != 1) {
    //   return streaks;
    // }

    // Sort dates in descending order
    daysCompleted.sort((a, b) => b.compareTo(a));

    for (int i = 0; i < (daysCompleted.length - 1); i++) {
      print('Days completed: $daysCompleted');
      // Check if the difference between consecutive dates is one day
      if (daysCompleted[i].difference(daysCompleted[i + 1]).inDays == 1) {
        streaks++;
        print('Streaks:--------------- $streaks');
      } else {
        break;
      }
    }

    return streaks;
  }

  // habit empty obj getter
  static Habit get empty {
    return Habit(
      habitId: '',
      habitName: '',
      habitDescription: '',
      isCompleted: false,
      dateCreated: DateTime.now(),
      daysCompleted: [],
      streak: 0,
    );
  }

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
