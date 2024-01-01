import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Helpers/data_helpers.dart';
import '../../../hive/models/habit/habit.dart';
import '../provider/homepage_provider.dart';

class NewHabitBottomSheetContent extends StatefulWidget {
  const NewHabitBottomSheetContent({super.key});

  @override
  State<NewHabitBottomSheetContent> createState() =>
      _NewHabitBottomSheetContentState();
}

class _NewHabitBottomSheetContentState
    extends State<NewHabitBottomSheetContent> {
  final TextEditingController habitNameController = TextEditingController();
  final TextEditingController habitDescriptionController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
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
              'Add New Habit',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 20),

            // date created text
            Text(
              '${DateFormat.yMMMd().format(DateTime.now())} ★ ${DateFormat.H().format(DateTime.now())} : ${DateFormat.M().format(DateTime.now())}',
              style: const TextStyle(
                color: Color(0xff939191),
                fontSize: 10,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
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
                      _addNewHabit(
                        habitNameController.text.trim(),
                        habitDescriptionController.text.trim(),
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

  void _addNewHabit(String habitName, String habitDescription) {
    final Habit newHabit = Habit(
      habitId: DataHelpers.generateCode(10),
      habitName: habitName,
      habitDescription: habitDescription,
      isCompleted: false,
      dateCreated: DateTime.now(),
      daysCompleted: [],
      streak: 0,
    );

    context.read<HomepageProvider>().addHabit(newHabit);
    Navigator.pop(context);
  }
}
