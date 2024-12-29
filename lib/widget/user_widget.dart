import 'package:flutter/material.dart';

import '../model/user.dart';

class UserWidget extends StatelessWidget {
  final User user;

  const UserWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(user.avatar),
        ),
        Text(user.username),
      ],
    );
  }
}