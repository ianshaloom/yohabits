import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'app.dart';
import 'hive/hive_initialization.dart';

void main() async {
  // flutter initialization
  WidgetsFlutterBinding.ensureInitialized();

  // device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // get application documents directory
  final appDir = await path_provider.getApplicationDocumentsDirectory();

  // registerAdapter
  await HiveInitialization.registerAdapters();
  // hive initialization
  await HiveInitialization.initFlutter(appDir.path);

  runApp(const YohabitsApp());
}
