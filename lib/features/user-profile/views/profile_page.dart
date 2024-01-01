import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

import '../../../Helpers/data_helpers.dart';
import '../../../constants.dart';
import '../../../hive/hive_boxes.dart';
import '../../../hive/models/userprofile/userprofile.dart';
import '../provider/user_profile_provider.dart';
import '../widgets/edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String greeting = DataHelpers.getGreetings();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.pencil),
            onPressed: () => _editDialog(context),
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<UserProfile>>(
        valueListenable: HiveBoxes.userProfilesBox.listenable(),
        builder: (context, Box<UserProfile> box, _) {
          final UserProfile userProfile = box.values.first;
          context.read<UserProfileProvider>().userprofile = userProfile;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView(
              children: [
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 51.5,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(userProfile.avatar),
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      radius: 50,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // greeting text
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '$greeting, ${userProfile.username}',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Text(
                        'Quick Tips Just For You',
                        style: textTheme.labelLarge,
                      ),
                    ),
                    Card(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tips,
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _editDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => EditProfileDialog());
  }
}
