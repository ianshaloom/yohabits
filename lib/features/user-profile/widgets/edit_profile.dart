// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_profile_provider.dart';
import 'avatars.dart';
import 'input_textfield.dart';

class EditProfileDialog extends StatelessWidget {
  late final TextEditingController controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EditProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final username = context.select<UserProfileProvider, String>(
        (UserProfileProvider provider) => provider.userprofile.username);
    controller = TextEditingController(text: username);

    return AlertDialog(
      icon: const Icon(CupertinoIcons.pencil),
      title: const Text('Edit Profile'),
      content: Form(
        key: formKey,
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              InputTextFormField(
                controller: controller,
                needsValidation: true,
                labelText: 'Username',
                hintText: 'Enter your username',
                errorText: 'Please enter your username',
                prefixIcon: const Icon(CupertinoIcons.person),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Select Avatar',
                  style: textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 20),
              // const SizedBox(
              //   width: double.infinity,
              //   child: UserAvatars(),
              // ),
              const SizedBox(
                height: 70,
                width: 300,
                child: UserAvatars(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final user = context.read<UserProfileProvider>().userprofile;
            final username = controller.text.trim();
            final form = formKey.currentState!;

            if (form.validate()) {
              user.username = username;
              user.avatar = context.read<UserProfileProvider>().selectedAvatar;
              await user.save();
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
