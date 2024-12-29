import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  const AppBarWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(name),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}