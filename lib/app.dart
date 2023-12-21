import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'features/home-page/provider/homepage_provider.dart';
import 'features/home-page/view/home_page.dart';
import 'features/onboard/views/onboard_page.dart';
import 'hive/hive_boxes.dart';
import 'hive/models/onboard/onboard.dart';
import 'theme/color_schemes.dart';

class YohabitsApp extends StatelessWidget {
  const YohabitsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomepageProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Yohabits',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            fontFamily: 'Montserrat'),
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            fontFamily: 'Montserrat'),
        debugShowCheckedModeBanner: false,
        home: ValueListenableBuilder<Box<Onboard>>(
          valueListenable: HiveBoxes.onboardsBox.listenable(),
          builder: (context, Box<Onboard> box, _) {
            if (box.isEmpty) {
              box.add(defaultOnboard);
            }

            final onboard = box.values.first;
            return onboard.showOnboard ? const OnBoardPage() : HomePage();
          },
        ),
      ),
    );
  }
}
