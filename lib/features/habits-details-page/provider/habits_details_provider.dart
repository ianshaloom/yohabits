import 'package:flutter/material.dart';

import '../../../hive/models/habit/habit.dart';

class HabitDetailProvider with ChangeNotifier {
  bool _isCompleted = false;
  Habit _habit = Habit.empty;

  bool get isCompleted => _isCompleted;
  Habit get habit => _habit;

  // setters
  set initializeHabit(Habit value) {
    _habit = value;
  }

  set habit(Habit value) {
    _habit = value;
    notifyListeners();
  }

  void onChanged(bool value) {
    _isCompleted = value;
    notifyListeners();
  }

  void newHabit(Habit habit) {
    _habit = habit;
    notifyListeners();
  }
}

// create a valuelistenableprovider for the habit detail provider
// class Details {
//   Habit h;
//   final habit = ValueNotifier(h);

//   Details(this.h);
// }
