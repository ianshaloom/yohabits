import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../hive/models/habit/habit.dart';
import '../../../hive/models/history/habit_history.dart';
import '../../habits-details-page/views/habits_details.dart';
import '../repo/habits_crud.dart';

class HabitTile extends StatefulWidget {
  final HabitsRecord habitsRecord;
  final Habit habit;
  final int index;

  const HabitTile({
    super.key,
    required this.index,
    required this.habit,
    required this.habitsRecord,
  });

  @override
  State<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  bool _isCompleted = false;

  @override
  void initState() {
    _isCompleted = widget.habit.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Checkbox(
              value: _isCompleted,
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
                      index: widget.index,
                      habit: widget.habit,
                      habitsRecord: widget.habitsRecord,
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
                            widget.habit.habitName,
                            style: TextStyle(
                              fontWeight: widget.habit.isCompleted
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              // color: const Color.fromRGBO(44, 49, 64, 1),
                              decoration: widget.habit.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Date Added: ${DateFormat.yMMMd().format(widget.habit.dateCreated)}',
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
                        ' Current Streak: ${widget.habit.streak}',
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
    bool isCompleted = await _habitCrud.markHabitDone(
        widget.habitsRecord, widget.index, value);

    setState(() {
      _isCompleted = isCompleted;
    });
  }

  void deleteHabit() async {
    await _habitCrud.deleteHabit(widget.habitsRecord, widget.index);
  }
}

final HabitsCrud _habitCrud = HabitsCrud();
