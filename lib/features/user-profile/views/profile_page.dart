import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../hive/hive_boxes.dart';
import '../../../hive/models/userprofile/userprofile.dart';
import '../widgets/color_segmented_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: ValueListenableBuilder<Box<UserProfile>>(
        valueListenable: HiveBoxes.userProfilesBox.listenable(),
        builder: (context, Box<UserProfile> box, _) {
          final UserProfile userProfile = box.values.first;

          return Column(
            children: [
              const SizedBox(height: 20),
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
              ListTile(
                leading: const SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.person_outline,
                    size: 30,
                  ),
                ),
                title: const Text('Name'),
                subtitle: Text(userProfile.username),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  // const Divider(),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Select Avatar',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...avatars.map((avatar) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              // context.read<ProfileProvida>().updateAvatar(
                              //       avatar,
                              //       widget.cloudUser.userId,
                              //     );
                            },
                            child: CircleAvatar(
                              backgroundImage: AssetImage(avatar),
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              radius: 30,
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const Divider(),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Select Theme Color',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ColorSegmentedButton(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
