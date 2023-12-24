import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewHabitBottomSheetContent extends StatefulWidget {
  NewHabitBottomSheetContent({super.key});

  @override
  State<NewHabitBottomSheetContent> createState() =>
      _NewHabitBottomSheetContentState();
}

class _NewHabitBottomSheetContentState
    extends State<NewHabitBottomSheetContent> {
  final TextEditingController habitNameController = TextEditingController();
  final TextEditingController habitDescriptionController =
      TextEditingController();

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

          // date created text
          Text(
            '${DateFormat.yMMMd().format(DateTime.now())} ★ ${DateFormat.H().format(DateTime.now())} : ${DateFormat.M().format(DateTime.now())}',
            style: TextStyle(
              color: const Color(0xff939191),
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
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
          SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => StockTakePage(),
              //   ),
              // );
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size.fromHeight(60),
              // textStyle: Theme.of(context)
              //     .textTheme
              //     .labelLarge!
              //     .copyWith(
              //       fontSize: 17,
              //     ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Save New Habit',
                ),
                SizedBox(width: 40),
                Icon(Icons.save_rounded)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
