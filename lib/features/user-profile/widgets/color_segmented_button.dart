import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class ColorSegmentedButton extends StatefulWidget {
  const ColorSegmentedButton({super.key});

  @override
  State<ColorSegmentedButton> createState() => _ColorSegmentedButtonState();
}

class _ColorSegmentedButtonState extends State<ColorSegmentedButton> {
  late UserColor colorsView;

  UserColor _getColor(String color) {
    switch (color) {
      case 'brown':
        return UserColor.brown;
      case 'orange':
        return UserColor.orange;
      case 'purple':
        return UserColor.purple;
      case 'blue':
        return UserColor.blue;
      case 'red':
        return UserColor.red;
      default:
        return UserColor.yellow;
    }
  }

  String _getColorString(UserColor color) {
    switch (color) {
      case UserColor.brown:
        return 'brown';
      case UserColor.orange:
        return 'orange';
      case UserColor.purple:
        return 'purple';
      case UserColor.blue:
        return 'blue';
      case UserColor.red:
        return 'red';
      default:
        return 'yellow';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    colorsView = UserColor.brown;

    return SegmentedButton<UserColor>(
      showSelectedIcon: false,
      segments: const <ButtonSegment<UserColor>>[
        ButtonSegment<UserColor>(
          value: UserColor.brown,
          label: Text('Brown', style: TextStyle(fontSize: 11)),
          // icon: Icon(Icons.color_lens),
        ),
        ButtonSegment<UserColor>(
          value: UserColor.orange,
          label: Text('Orange', style: TextStyle(fontSize: 11)),
          // icon: Icon(Icons.color_lens),
        ),
        ButtonSegment<UserColor>(
          value: UserColor.purple,
          label: Text('Purple', style: TextStyle(fontSize: 11)),
          // icon: Icon(Icons.color_lens),
        ),
        ButtonSegment<UserColor>(
          value: UserColor.blue,
          label: Text('Blue', style: TextStyle(fontSize: 11)),
          // icon: Icon(Icons.color_lens),
        ),
        ButtonSegment<UserColor>(
          value: UserColor.red,
          label: Text('Red', style: TextStyle(fontSize: 11)),
          // icon: Icon(Icons.color_lens),
        ),
      ],
      selected: <UserColor>{colorsView},
      onSelectionChanged: (Set<UserColor> newSelection) async {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          colorsView = newSelection.first;
        });
      },
    );
  }
}

enum UserColor { brown, orange, purple, blue, red, yellow }
