import 'package:flutter/material.dart';

import '../widget/input_textfield.dart';

class NewHabitBottomSheetContent extends StatelessWidget {
  final TextEditingController habitNameController = TextEditingController();

  NewHabitBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            width: screenSize.width,
          ),
          Text(
            'Add New Habit',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 20),
          InputTextFormField(
            controller: habitNameController,
            needsValidation: true,
            labelText: 'Habit Name',
            hintText: 'Enter habit name',
            errorText: 'Please enter habit name',
          ),
        ],
      ),
    );
  }
}
