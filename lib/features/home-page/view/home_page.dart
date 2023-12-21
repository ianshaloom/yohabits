import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../hive/models/habit/habit.dart';
import '../../../hive/models/userprofile/userprofile.dart';
import '../../user-profile/views/profile_page.dart';
import '../provider/homepage_provider.dart';
import '../widget/habit_tile.dart';
import '../widget/streaks.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserProfile userProfile;
  late List<Habit> habits;

  @override
  void initState() {
    userProfile = context.read<HomepageProvider>().userProfile;
    habits = defaultHabits;
    habits.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
            StreaksCard(),
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
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return HabitTile(
                    index: index,
                    habit: habit,
                    onChanged: (value) {},
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: const Icon(
          CupertinoIcons.pen,
          size: 35,
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context, ColorScheme color) => Container(
        margin: const EdgeInsets.only(left: 0, top: 0),
        alignment: Alignment.centerLeft,
        child: Row(
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
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            IconButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
              icon: Icon(
                Icons.menu,
                color: color.onSurface,
              ),
            ),
          ],
        ),
      );
//
}
