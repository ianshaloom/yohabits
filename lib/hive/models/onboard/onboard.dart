import 'package:hive_flutter/hive_flutter.dart';

part 'onboard.g.dart';

@HiveType(typeId: 4)
class Onboard extends HiveObject {
  @HiveField(0)
  bool showOnboard;

  Onboard({
    required this.showOnboard,
  });
}
