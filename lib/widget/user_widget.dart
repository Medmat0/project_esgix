import 'package:esgix_project/screen/screen_profile_everyone.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class UserWidget extends StatelessWidget {
  final User user;

  const UserWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          ScreenProfileEveryone.navigateTo(
            context,
            user.id,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: user.avatar.isNotEmpty
                    ? NetworkImage(user.avatar)
                    : const AssetImage('assets/egg.jpeg') as ImageProvider,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.description ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
