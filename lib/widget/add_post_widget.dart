  import 'package:esgix_project/screen/screen_feed.dart';
  import 'package:esgix_project/shared/post_management_bloc/post_management_bloc.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import '../model/post.dart';
  import '../shared/post_pagination_bloc/post_pagination_bloc.dart';

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
      return BlocListener<PostManagementBloc, PostManagementState>(
        listener: (context, state) {
          if (state.status == PostManagementStatus.addPostSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post added successfully')),
            );

            _contentController.clear();
            _imageUrlController.clear();

            Navigator.pop(context);


            context.read<PostPaginationBloc>().add(const PostPaginationOffsetEvent(
              offset: 0,
              page: 0,
            ));
          } else if (state.status == PostManagementStatus.error ||
              state.status == PostManagementStatus.errorAddPost) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error adding post')),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text(
                "Add Post",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(hintText: 'Content'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(hintText: 'Image URL'),
              ),
              const SizedBox(height: 16),
              BlocBuilder<PostManagementBloc, PostManagementState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.status == PostManagementStatus.loading
                        ? null
                        : () {
                      if (_contentController.text.isEmpty) return;
                      _onAddPost();
                    },
                    child: state.status == PostManagementStatus.loading
                        ? const CircularProgressIndicator()
                        : const Text('Add Post'),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    void _onAddPost() {
      BlocProvider.of<PostManagementBloc>(context).add(
        PostManagementAddEvent(
          post: Post(
            parent: widget.id,
            content: _contentController.text,
            imageUrl: _imageUrlController.text,
          ),
        ),
      );
    }
  }