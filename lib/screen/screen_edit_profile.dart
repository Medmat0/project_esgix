import 'package:esgix_project/screen/screen_profile_everyone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user.dart';
import '../shared/user_management_bloc/user_management_bloc.dart';
import '../widget/app_bar_widget.dart';
import '../widget/base_screen.dart';

class ScreenEditProfile extends StatefulWidget {
  final User user;
  const ScreenEditProfile({super.key, required this.user,});

  static Future<void> navigateTo(BuildContext context, User user) {
    return Navigator.pushNamed(context, '/edit-profile', arguments: user);
  }

  @override
  ScreenEditProfileState createState() => ScreenEditProfileState();
}

class ScreenEditProfileState extends State<ScreenEditProfile> {
  late TextEditingController _nameController;
  late TextEditingController _avatarController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.username);
    _avatarController = TextEditingController(text: widget.user.avatar);
    _descriptionController =
        TextEditingController(text: widget.user.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _avatarController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(name: 'Edit Profile'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Edit your profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text('Name'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Avatar'),
            TextField(
              controller: _avatarController,
              decoration: const InputDecoration(
                hintText: 'Avatar',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Description'),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _onUpdateProfile(context);
              },
              child: const Text('Update'),
            ),
            const SizedBox(height: 20),
            BlocListener<UserManagementBloc, UserManagementState>(
              listener: (context, state) {
                if (state.status == UserManagementStatus.successUpdateUser) {
                  ScreenProfileEveryone.navigateTo(context, widget.user.id);
                } else if (state.status == UserManagementStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error updating profile')),
                  );
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BaseScreen(
        initialIndex: 2,
      ),
    );
  }

  void _onUpdateProfile(BuildContext context) {
    final name = _nameController.text;
    final avatar = _avatarController.text;
    final description = _descriptionController.text;

    if (name.isEmpty || avatar.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and Avatar cannot be empty.')),
      );
      return;
    }

    context.read<UserManagementBloc>().add(UserUpdateEvent(
      userId: widget.user.id!,
      username: name == widget.user.username ? null : name,
      description: description == widget.user.description ? null : description,
    ));
  }
}
