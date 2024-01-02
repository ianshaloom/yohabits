import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../hive/hive_boxes.dart';
import '../../../hive/models/habit/habit.dart';
import '../../../hive/models/history/habit_history.dart';
import '../../../hive/repo/database_manager.dart';
import '../repo/date_time.dart';
import 'habit_tile.dart';

class HabitsListview extends StatelessWidget {
  const HabitsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _habitsDatabase.loadCurrentDb(),
      builder: (context, snapshot) {
        final todaysHabitsRecords = snapshot.data;

        if (snapshot.connectionState == ConnectionState.done) {
          return ValueListenableBuilder(
            valueListenable: HiveBoxes.habitsBox.listenable(),
            builder: (context, box, _) {
              final dailyHabits = box.values.cast<Habit>().toList();
              dailyHabits
                  .sort((a, b) => b.dateCreated.compareTo(a.dateCreated));

              if (dailyHabits.isEmpty) {
                return const Center(
                  child: Text(
                    'No habits added yet!',
                  ),
                );
              }

              return ListView.builder(
                itemCount: dailyHabits.length,
                itemBuilder: (context, index) {
                  final dailyHabit = dailyHabits[index];

                  return HabitTile(
                    index: index,
                    habit: dailyHabit,
                    habitsRecord: todaysHabitsRecords!,
                  );
                },
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future _loadCurrentDb() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}

final DatabaseManager _habitsDatabase = DatabaseManager();
