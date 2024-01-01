import 'package:flutter/material.dart';

import '../../../hive/models/userprofile/userprofile.dart';
import '../../../hive/repo/userprofile_repo.dart';

class UserProfileProvider with ChangeNotifier {
  final UserProfileRepo _userProfileRepo = UserProfileRepo();

  UserProfile _userprofile = UserProfile();
  String _selectedAvatar = '';

  // getter
  UserProfile get userprofile => _userprofile;
  String get selectedAvatar => _selectedAvatar;

  // setter
  set userprofile(UserProfile profile) {
    _userprofile = profile;
    debugPrint('user profile:--------------- $_userprofile');
  }

  set selectedAvatar(String avatar) {
    _selectedAvatar = avatar;
    debugPrint('selected avatar:--------------- $_selectedAvatar');
  }

  void setUserprofile(String avatar) async {
    await _userProfileRepo.getUserProfileObject().then((value) {
      value.avatar = avatar;
      value.save();

      _userprofile = value;
      notifyListeners();
    });
  }
}
