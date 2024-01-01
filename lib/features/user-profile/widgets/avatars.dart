import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../provider/user_profile_provider.dart';

class UserAvatars extends StatefulWidget {
  const UserAvatars({super.key});

  @override
  State<UserAvatars> createState() => _UserAvatarsState();
}

class _UserAvatarsState extends State<UserAvatars> {
  late String selectedAvatar;
  // Color? selectedColor;
  // bool isSelected = false;

  @override
  void initState() {
    selectedAvatar = context.read<UserProfileProvider>().userprofile.avatar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _avatarTile(avatars[0], color),
          _avatarTile(avatars[1], color),
          _avatarTile(avatars[2], color),
          _avatarTile(avatars[3], color),
        ],
      ),
    );
  }

  Widget _avatarTile(String avatar, ColorScheme colorScheme) {
    return GestureDetector(
      onTap: () => _selectedAvatar(avatar),
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(avatar),
            fit: BoxFit.cover,
          ),
          color:
              avatar == selectedAvatar ? colorScheme.onPrimaryContainer : null,
        ),
        height: 65.0,
        width: 65.0,
      ),
    );
  }

  void _selectedAvatar(String avatar) {
    context.read<UserProfileProvider>().selectedAvatar = avatar;    
    setState(() {
      selectedAvatar = avatar;
    });
  }
}
