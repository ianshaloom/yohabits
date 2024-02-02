import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../hive/models/habit/habit.dart';
import '../../../theme/text_scheme.dart';
import '../provider/habits_details_provider.dart';

class EditHabitWidget extends StatefulWidget {
  final Function onEdit;
  const EditHabitWidget({super.key, required this.onEdit});

  @override
  State<EditHabitWidget> createState() => _EditHabitWidgetState();
}

class _EditHabitWidgetState extends State<EditHabitWidget> {
  late TextEditingController habitNameController;

  late TextEditingController habitDescriptionController;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final habit = context.watch<HabitDetailProvider>().habit;

    habitNameController = TextEditingController(text: habit.habitName);
    habitDescriptionController =
        TextEditingController(text: habit.habitDescription);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(CupertinoIcons.xmark),
              ),
              const Spacer()
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
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
        ],
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
    );

    widget.onEdit(newHabit);
    Navigator.pop(context);
  }
}
