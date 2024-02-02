import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../constants/asset_paths_constants.dart';
import '../../../hive/models/habit/habit.dart';
import '../../../hive/models/history/habit_history.dart';
import '../../../hive/repo/database_manager.dart';
import '../../habits-details-page/views/habits_details.dart';

class HabitTile extends StatelessWidget {
  final HabitsRecord habitsRecord;
  final Habit habit;
  final int index;

  const HabitTile({
    super.key,
    required this.index,
    required this.habit,
    required this.habitsRecord,
  });

  // bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Checkbox(
              value: habit.isCompleted,
              onChanged: (value) => onChanged(value!),
              checkColor: Colors.white,
              shape: const CircleBorder(),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 0,
            child: SvgPicture.asset(
              funUnderline,
              height: 28,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: InkWell(
              overlayColor: MaterialStateProperty.all(
                Colors.transparent,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HabitDetailsPage(
                      index: index,
                      habit: habit,
                      habitsRecord: habitsRecord,
                    ),
                  ),
                );
              },
              child: Container(
                //margin: const EdgeInsets.only(left: 40),
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            habit.habitName,
                            style: TextStyle(
                              fontWeight: habit.isCompleted
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              // color: const Color.fromRGBO(44, 49, 64, 1),
                              decoration: habit.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Date Added: ${DateFormat.yMMMd().format(habit.dateCreated)}',
                            style: const TextStyle(
                              color: Color(0xff939191),
                              fontSize: 10,
                              letterSpacing: 1.5,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, right: 8, left: 8),
                      child: Text(
                        ' Current Streak: ${habit.currentStreaks}',
                        maxLines: 4,
                        style: const TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12,
                          height: 1.2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onChanged(bool value) async {
    // habit.isCompleted = value;
    // await habit.save();
    await _dbManager.markHabitDone(
      habitsRecord,
      habit,
      value,
    );
  }

  void deleteHabit() async {
    await _dbManager.deleteHabit(habitsRecord, index);
  }
}

final DatabaseManager _dbManager = DatabaseManager();
