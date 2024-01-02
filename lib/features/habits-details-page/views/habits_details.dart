import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.pen),
            onPressed: () async {
              _showModalBs(context);
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.delete),
            onPressed: () async {
              // await HabitsCRUD().deleteHabit(habit);
              // Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                context.read<HabitDetailProvider>().habit.habitName,
                style: textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                ' Status: ',
                maxLines: 4,
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 16,
                  height: 1.2,
                ),
              ),
              Text(
                context.read<HabitDetailProvider>().habit.isCompleted
                    ? "Completed"
                    : 'Not Completed',
                style: TextStyle(
                  color: context.read<HabitDetailProvider>().habit.isCompleted
                      ? const Color(0xff009108)
                      : const Color(0xffC10000),
                  fontSize: 16,
                  height: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              context.read<HabitDetailProvider>().habit.habitDescription,
              style: textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Streak: ',
                style: textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                context.read<HabitDetailProvider>().habit.streak.toString(),
                style: textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Days Completed: ',
                style: textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                context
                    .read<HabitDetailProvider>()
                    .habit
                    .daysCompleted
                    .length
                    .toString(),
                style: textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
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
}
