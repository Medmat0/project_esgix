import 'package:flutter/material.dart';


class ProfileWidget extends StatefulWidget {
  final String id;
  final String username;
  final String? email;
  final String avatar;
  final String? description;

  const ProfileWidget({
    super.key,
    required this.id,
    required this.username,
    this.email,
    required this.avatar,
    this.description,
  });

  @override
  State<StatefulWidget> createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: widget.avatar.isNotEmpty
              ? NetworkImage(widget.avatar)
              : const AssetImage('assets/egg.jpeg') as ImageProvider,
        ),
        const SizedBox(height: 16),
        Text(
          widget.username,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.email ?? '',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.description ?? '',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
