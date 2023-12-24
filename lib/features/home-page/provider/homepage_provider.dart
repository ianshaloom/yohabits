import 'package:flutter/material.dart';

import '../../../hive/models/habit/habit.dart';
import '../../../hive/models/userprofile/userprofile.dart';
import '../../../hive/repo/habit_repo.dart';
import '../../../hive/repo/userprofile_repo.dart';

class HomepageProvider with ChangeNotifier {
  final UserProfileRepo _userProfileRepo = UserProfileRepo();
  final HabitRepo _habitRepo = HabitRepo();

  UserProfile _userProfile = UserProfile();
  List<Habit> _habits = [];

  UserProfile get userProfile => _userProfile;
  List<Habit> get habits => _habits;

  void setUserProfile() async {
    final bool userProfileBool = await _userProfileRepo.getUserProfileBool();

    if (userProfileBool) {
      _userProfile = UserProfile.empty;
      notifyListeners();
    } else {
      _userProfileRepo.getUserProfileObject().then((value) {
        _userProfile = value;
        notifyListeners();
      });
    }
  }

  void changeAvatar(UserProfile thisUserProfile, String avatar) async  {
    thisUserProfile.avatar = avatar;
    thisUserProfile.save();
    _userProfile = thisUserProfile;    
    notifyListeners();
  }

  void fetchHabits() async {
    _habits = await _habitRepo.getHabits();
    notifyListeners();
  }


  HomepageProvider() {
    setUserProfile();
  }
}
