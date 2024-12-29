import 'package:esgix_project/shared/post_management_bloc/post_management_bloc.dart';
import 'package:esgix_project/widget/modify_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/app_bar_widget.dart';
import '../widget/base_screen.dart';

class ScreenModifyPost extends StatefulWidget {
  final String id;

  static Future<void> navigateTo(BuildContext context, String id) {
    return Navigator.pushNamed(context, '/edit-post', arguments: id);
  }

  const ScreenModifyPost({
    super.key,
    required this.id,
  });

  @override
  ScreenModifyPostState createState() => ScreenModifyPostState();
}

class ScreenModifyPostState extends State<ScreenModifyPost> {

  @override
  void initState() {
    super.initState();
    context.read<PostManagementBloc>().add(PostManagementFindOneEvent(idPost: widget.id,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(name: 'Twitter Feed'),
      body: BlocListener<PostManagementBloc, PostManagementState>(
        listener: (context, state) {
          if (state.status == PostManagementStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Error loading post")),
            );
          }
        },
        child: BlocBuilder<PostManagementBloc, PostManagementState>(
          builder: (context, state) {
            if (state.post == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return ModifyPostWidget(post: state.post!);
          },
        ),
      ),
      bottomNavigationBar: const BaseScreen(),
    );
  }
}
