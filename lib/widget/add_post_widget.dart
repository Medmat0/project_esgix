import 'package:esgix_project/screen/screen_feed.dart';
import 'package:esgix_project/shared/post_management_bloc/post_management_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/post.dart';

class AddPostWidget extends StatefulWidget {
  final String? id;
  const AddPostWidget({super.key, this.id});

  @override
  State<StatefulWidget> createState() => AddPostState();
}

class AddPostState extends State<AddPostWidget> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            "Add Post",
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
              _onAddPost();
              _contentController.clear();
              _imageUrlController.clear();
              ScreenFeed.navigateTo(context);
            },
            child: const Text('Add Post'),
          ),
        ],
      ),
    );
  }

  void _onAddPost(){
    BlocProvider.of<PostManagementBloc>(context).add(
        PostManagementAddEvent(
          post: Post(
            parent: widget.id,
            content: _contentController.text,
            imageUrl: _imageUrlController.text,
          ),
        )
    );
  }
}