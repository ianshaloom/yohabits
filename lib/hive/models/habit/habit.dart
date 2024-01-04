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

  // getters
  int get currentStreaks => computeStreaks(false);
  int get longestStreaks => computeStreaks(true);

  int computeStreaks(bool isLongestStreaks) {
    List<DateTime> completedDates = daysCompleted;

    if (completedDates.isEmpty) {
      return 0;
    }

    // Sort dates as from the oldest to the newest
    completedDates.sort((a, b) => a.compareTo(b));

    // Compute the streak
    int currentStreak = 1;
    int longestStreak = 1;

    for (int i = 1; i < completedDates.length; i++) {
      // Check if the current date is one day after the previous date
      if (completedDates[i].difference(completedDates[i - 1]).inDays == 1) {
        currentStreak++;
      } else {
        // Reset streak if the current date doesn't follow the previous date
        currentStreak = 1;
      }

      // Update the longest streak
      longestStreak =
          currentStreak > longestStreak ? currentStreak : longestStreak;
    }

    if (isLongestStreaks) {
      return longestStreak;
    } else {
      return currentStreak;
    }
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
    );
  }

  Habit({
    required this.habitId,
    required this.habitName,
    this.habitDescription = '',
    required this.isCompleted,
    required this.dateCreated,
    this.daysCompleted = const [],
  });
}
