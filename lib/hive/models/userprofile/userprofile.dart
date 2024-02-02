import 'package:hive_flutter/hive_flutter.dart';

import '../../../constants.dart';
import '../../../constants/asset_paths_constants.dart';

part 'userprofile.g.dart';

@HiveType(typeId: 3)
class UserProfile extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String avatar;

  static UserProfile get empty => UserProfile();

  UserProfile({
    this.username = defaultUsername,
    this.avatar = defaultAvatar,
  });
}
