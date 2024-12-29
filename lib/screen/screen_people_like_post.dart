import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/user_query_bloc/user_query_bloc.dart';
import '../widget/people_like_widget.dart';

class ScreenPeopleLikePost extends StatefulWidget {
  final String postId;

  const ScreenPeopleLikePost({required this.postId, super.key});

  static Future<void> navigateTo(BuildContext context, String postId) {
    return Navigator.pushNamed(context, '/people_like_post', arguments: postId);
  }

  @override
  ScreenPeopleLikePostState createState() => ScreenPeopleLikePostState();
}

class ScreenPeopleLikePostState extends State<ScreenPeopleLikePost> {

  @override
  void initState() {
    super.initState();
    context.read<UserQueryBloc>().add(UserByLikePostEvent(idPost: widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("People like post"),
      ),
      body: BlocBuilder<UserQueryBloc, UserQueryState>(
          builder: (context, state) {
            if (state.status == UserQueryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == UserQueryStatus.error) {
              return const Center(child: Text("Error"));
            }
            if (state.status == UserQueryStatus.success) {
              return PeopleLikeWidget(peopleLikeList: state.users);
            }
            return const SizedBox();
          },
        ),
    );
  }
}

