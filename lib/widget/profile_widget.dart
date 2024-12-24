import 'package:bloc/bloc.dart';
import 'package:esgix_project/shared/user_query_bloc/user_query_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../singleton/session_manager.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});


  @override
  State<StatefulWidget> createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {

  @override
  void initState() {
    super.initState();
    String? userId = SessionManager.instance.userId;
    if (userId == null) {
      return;
    }
    context.read<UserQueryBloc>().add(UserByIdEvent(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserQueryBloc, UserQueryState>(
      builder: (context, state) {
        if(SessionManager.instance.userId == null){
          return const Center(child: Text('No user found'));
        }
        if (state.status == UserQueryStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == UserQueryStatus.error) {
          return const Center(child: Text('Failed to fetch user'));
        }
        if (state.users.isEmpty) {
          return const Center(child: Text('No user2 found'));
        }



        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(state.users[0].avatar),
            ),
            const SizedBox(height: 16),
            Text(
              state.users[0].username,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.users[0].email!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }
}