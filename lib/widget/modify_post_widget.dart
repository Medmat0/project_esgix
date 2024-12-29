import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/post.dart';
import '../screen/screen_feed.dart';
import '../shared/post_management_bloc/post_management_bloc.dart';

class ModifyPostWidget extends StatefulWidget {
  final Post post;

  const ModifyPostWidget({super.key, required this.post});

  @override
  ModifyPostWidgetState createState() => ModifyPostWidgetState();
}

class ModifyPostWidgetState extends State<ModifyPostWidget> {
  late final TextEditingController _contentController;
  late final TextEditingController _imageUrlController;

  @override
  void dispose() {
    _contentController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.post.content);
    _imageUrlController = TextEditingController(text: widget.post.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostManagementBloc, PostManagementState>(
      listener: (context, state) {
        if (state.status == PostManagementStatus.updatePostSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Post successfully updated")),
          );
          ScreenFeed.navigateTo(context);
        } else if (state.status == PostManagementStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error updating post")),
          );
        }
      },
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            "Modify Post",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(
              hintText: 'Content',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _imageUrlController,
            decoration: const InputDecoration(
              hintText: 'Image URL',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_contentController.text.isEmpty) return;
              _onModifyPost();
            },
            child: const Text('Modify Post'),
          ),
        ],
      ),
    );
  }

  void _onModifyPost() {
    BlocProvider.of<PostManagementBloc>(context).add(
      PostManagementUpdateEvent(
        post: widget.post.copyWith(
          content: _contentController.text,
          imageUrl: _imageUrlController.text,
        ),
      ),
    );
  }
}


