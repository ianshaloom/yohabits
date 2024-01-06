import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../hive/models/habit/habit.dart';
import '../../../hive/models/history/habit_history.dart';
import '../provider/habits_details_provider.dart';
import '../widgets/edit_habit_widget.dart';

class HabitDetailsPage extends StatelessWidget {
  final HabitsRecord habitsRecord;
  final Habit habit;
  final int index;

  const HabitDetailsPage({
    super.key,
    required this.index,
    required this.habit,
    required this.habitsRecord,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    context.read<HabitDetailProvider>().initializeHabit = habit;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Created on: ${DateFormat.yMMMd().format(context.watch<HabitDetailProvider>().habit.dateCreated)} ★'
          ' ${DateFormat.Hm().format(context.watch<HabitDetailProvider>().habit.dateCreated)}',
          // style: const TextStyle(
          //   color: Color(0xff939191),
          //   fontSize: 10,
          //   letterSpacing: 1.5,
          // ),
          style: textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 10,
            letterSpacing: 1.5,
            color: const Color(0xff939191),
          ),
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView(
                children: [
                  SizedBox(
                    height: 150,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context
                                  .read<HabitDetailProvider>()
                                  .habit
                                  .habitName,
                              style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Divider(),
                            Text(
                              context
                                  .read<HabitDetailProvider>()
                                  .habit
                                  .habitDescription,
                              style: textTheme.titleMedium!.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 110,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.calendar,
                                  color: Colors.blueAccent.withOpacity(0.8),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Time of Day',
                                  style: textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Text(
                              'Tommorrow, 20:00',
                              style: textTheme.titleMedium!.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 110,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.location,
                                  color: Colors.green.withOpacity(1),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Place',
                                  style: textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Text(
                              'Home, Work, Gym, School, etc.',
                              style: textTheme.titleMedium!.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Streaks(
                    currentStreak: context
                        .read<HabitDetailProvider>()
                        .habit
                        .currentStreaks,
                    longestStreak: context
                        .read<HabitDetailProvider>()
                        .habit
                        .longestStreaks,
                    lastCompleted: context
                            .read<HabitDetailProvider>()
                            .habit
                            .daysCompleted
                            .isEmpty
                        ? null
                        : context
                            .read<HabitDetailProvider>()
                            .habit
                            .daysCompleted
                            .last,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowButton(
                  title: 'Completed',
                  icon: CupertinoIcons.check_mark,
                  onPressed: () {},
                ),
                RowButton(
                  title: 'Edit',
                  icon: CupertinoIcons.pencil,
                  onPressed: () => _showModalBs(context),
                ),
                RowButton(
                  title: 'Delete',
                  icon: CupertinoIcons.delete,
                  onPressed: () => _showAleartDialog(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showModalBs(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const EditHabitWidget(),
      ),
    );
  }

  void _showAleartDialog(BuildContext context) async {
    final bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: const Text('Are you sure you want to delete this habit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm) {
      // await HabitsCRUD().deleteHabit(habit);
      // Navigator.pop(context);
    }
  }
}

class RowButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onPressed;
  const RowButton(
      {super.key, required this.title, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          elevation: 0,
          enableFeedback: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class Streaks extends StatelessWidget {
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastCompleted;
  const Streaks({
    super.key,
    required this.currentStreak,
    required this.longestStreak,
    this.lastCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    NumberFormat numberFormat = NumberFormat("00");
    double radius = 45;
    double fontSize1 = 14;
    String fontFam = 'Gilroy';

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Habit Streaks',
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  lastCompleted == null
                      ? 'Last Completed: Never'
                      : 'Last Completed: ${DateFormat.yMMMd().format(lastCompleted!)}',
                  style: const TextStyle(
                    color: Color(0xff939191),
                    fontSize: 9,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            const Divider(),
            Container(
              // height: 210,
              width: screenSize.width,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: radius,
                                backgroundColor: Colors.transparent,
                                child: SvgPicture.asset(
                                  currentStreakImage,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      numberFormat.format(currentStreak),
                                      textAlign: TextAlign.justify,
                                      style: textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Current Streak',
                              style: textTheme.labelMedium!.copyWith(
                                letterSpacing: 1.5,
                                fontSize: fontSize1,
                                fontFamily: fontFam,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: radius,
                                backgroundColor: Colors.transparent,
                                child: SvgPicture.asset(
                                  longestStreakImage,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      numberFormat.format(longestStreak),
                                      textAlign: TextAlign.justify,
                                      style: textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Longest Streak',
                              style: textTheme.labelMedium!.copyWith(
                                letterSpacing: 1.5,
                                fontSize: fontSize1,
                                fontFamily: fontFam,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
