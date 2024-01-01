import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../hive/models/habit/habit.dart';
import '../provider/habits_details_provider.dart';

class EditHabitWidget extends StatefulWidget {
  const EditHabitWidget({super.key});

  @override
  State<EditHabitWidget> createState() => _EditHabitWidgetState();
}

class _EditHabitWidgetState extends State<EditHabitWidget> {
  late TextEditingController habitNameController;

  late TextEditingController habitDescriptionController;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    final habit = context.watch<HabitDetailProvider>().habit;

    habitNameController = TextEditingController(text: habit.habitName);
    habitDescriptionController =
        TextEditingController(text: habit.habitDescription);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              width: screenSize.width,
            ),
            Text(
              'Edit Habit',
              style: textTheme.titleLarge,
            ),

            const SizedBox(height: 20),
            TextFormField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              controller: habitNameController,
              decoration: InputDecoration(
                labelText: 'Habit Name',
                // labelStyle: textTheme.labelMedium,
                hintText: 'Enter habit name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter habit name';
                }
                return null;
              },
            ),

            // habit description textformfield
            const SizedBox(height: 20),
            TextFormField(
              controller: habitDescriptionController,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Description',
                // labelStyle: textTheme.labelMedium,
                hintText: 'Enter habit description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _editHabit(
                        habitNameController.text.trim(),
                        habitDescriptionController.text.trim(),
                        context,
                      );
                    }
                  },
                  child: const Text('Save'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editHabit(
      String habitName, String habitDescription, BuildContext context) {
    final habit = context.watch<HabitDetailProvider>().habit;

    final Habit newHabit = Habit(
      habitId: habit.habitId,
      habitName: habitName,
      habitDescription: habitDescription,
      isCompleted: habit.isCompleted,
      dateCreated: habit.dateCreated,
      daysCompleted: habit.daysCompleted,
      streak: habit.streak,
    );

    context.read<HabitDetailProvider>().habit = newHabit;
    Navigator.pop(context);
  }
}
