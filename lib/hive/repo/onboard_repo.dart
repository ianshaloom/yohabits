import 'package:hive_flutter/hive_flutter.dart';

import '../../constants.dart';
import '../hive_boxes.dart';
import '../models/onboard/onboard.dart';

class OnboardRepo {
  OnboardRepo._(this._onboardBox);
  static final OnboardRepo _instance =
      OnboardRepo._(HiveBoxes.onboardsBox);
  factory OnboardRepo() => _instance;

  final Box<Onboard> _onboardBox;

  // create and add default default onboard
  Future<Onboard> addDefaultOnboard() async {
    await _onboardBox.add(defaultOnboard);
    return defaultOnboard;
  }

  // add show home
  Future<void> addOnboard(Onboard onBoard) async {
    await _onboardBox.add(onBoard);
  }

  // get onboard object
  Future<Onboard> getOnboardObject() async {
    final onBoard = _onboardBox.values.toList();
    return onBoard.first;
  }

  Future<bool> getOnboardBool() async {
    final onBoard = _onboardBox.values.toList();
    if (onBoard.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
