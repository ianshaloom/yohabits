import 'package:hive_flutter/hive_flutter.dart';

import '../../constants.dart';
import '../hive_boxes.dart';
import '../models/userprofile/userprofile.dart';

class UserProfileRepo {
  UserProfileRepo._(this._userProfileBox);
  static final UserProfileRepo _instance =
      UserProfileRepo._(HiveBoxes.userProfilesBox);
  factory UserProfileRepo() => _instance;

  final Box<UserProfile> _userProfileBox;

  // create and add default default user profile
  Future<void> addDefaultUserProfile() async {
    await _userProfileBox.add(defaultUserProfile);
  }

  // add show home
  Future<void> addUserProfile(UserProfile userProfile) async {
    await _userProfileBox.add(userProfile);
  }

  // get onboard object
  Future<UserProfile> getUserProfileObject() async {
    final userProfile = _userProfileBox.values.toList();
    return userProfile.first;
  }

  Future<bool> getUserProfileBool() async {
    final userProfile = _userProfileBox.values.toList();
    if (userProfile.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
