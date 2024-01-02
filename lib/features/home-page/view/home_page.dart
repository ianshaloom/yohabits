import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../hive/hive_boxes.dart';
import '../../../hive/models/habit/habit.dart';
import '../../../hive/models/userprofile/userprofile.dart';
import '../../user-profile/views/profile_page.dart';
import '../provider/homepage_provider.dart';
import '../widget/habits_listview.dart';
import '../widget/streaks.dart';
import 'new_habit_bs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Habit> habits = [];

  @override
  void initState() {
    context.read<HomepageProvider>().fetchHabits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    habits = context.watch<HomepageProvider>().habits;
    habits.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: _appBar(context, color),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const StreaksCard(),
            Row(
              children: [
                Text(
                  'Your Habits',
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: textTheme.titleSmall!.copyWith(
                      color: color.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: HabitsListview(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showModalBs(context);
          // print('Habit records: ${HiveBoxes.habitHistoriesBox.isEmpty}');
        },
        child: const Icon(
          CupertinoIcons.add,
          size: 35,
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context, ColorScheme color) => Container(
        margin: const EdgeInsets.only(left: 0, top: 0),
        alignment: Alignment.centerLeft,
        child: ValueListenableBuilder(
            valueListenable: HiveBoxes.userProfilesBox.listenable(),
            builder: (context, Box<UserProfile> box, child) {
              final userProfile = box.values.first;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 27,
                        child: CircleAvatar(
                          backgroundColor: color.surface,
                          backgroundImage: AssetImage(userProfile.avatar),
                          radius: 25.5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Hi, ${userProfile.username}',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  // native font family
                                  fontFamily: 'Sans-Serif',
                                ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.menu,
                      color: color.onSurface,
                    ),
                  ),
                ],
              );
            }),
      );
//

  void _showModalBs(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const NewHabitBottomSheetContent(),
      ),
    );
  }
}
