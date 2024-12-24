import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/post_bloc/post_bloc.dart';
import '../screen/login_view_screen.dart';

class TweetWidget extends StatefulWidget {
  final String id;
  final String profileImageUrl;
  final String username;
  final String handle;
  final String timeAgo;
  final String? imageUrl;
  final String content;
  final int likes;
  final int comments;

  const TweetWidget({
    super.key,
    required this.id,
    required this.profileImageUrl,
    required this.username,
    required this.handle,
    required this.timeAgo,
    required this.content,
    required this.likes,
    required this.comments,
    this.imageUrl,
  });

  @override
  TweetWidgetState createState() => TweetWidgetState();
}

class TweetWidgetState extends State<TweetWidget> {
  late int likes;
  late int comments;
  bool isLiked = false; // Variable d'état pour le like
  bool isCommented = false; // Variable d'état pour le commentaire

  @override
  void initState() {
    super.initState();
    likes = widget.likes;
    comments = widget.comments;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state.status == PostBlocStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Erreur lors de l'ajout du like")),
          );
        }

        if (state.status == PostBlocStatus.errorNotLogin) {
          LoginScreen.navigateTo(context);
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: widget.profileImageUrl.isNotEmpty
                    ? NetworkImage(widget.profileImageUrl)
                    : const AssetImage('egg.jpeg') as ImageProvider,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '@${widget.handle} · ${widget.timeAgo}',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    if (widget.imageUrl != null &&
                        widget.imageUrl!.isNotEmpty &&
                        isImageUrl(widget.imageUrl!))
                      Image.network(widget.imageUrl!),
                    Text(widget.content),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildIconText(Icons.comment, comments, addCommentOnTweet, isCommented),
                        _buildIconText(Icons.favorite, likes, addLikeOnTweet, isLiked),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isImageUrl(String url) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    final urlExtension = url.split('.').last.toLowerCase();
    return imageExtensions.contains(urlExtension);
  }

  void addLikeOnTweet() {
    BlocProvider.of<PostBloc>(context).add(PostLikeEvent(id: widget.id));
    setState(() {
      isLiked = !isLiked;
      likes += isLiked ? 1 : -1;
    });
  }

  void addCommentOnTweet() {
    setState(() {
      isCommented = !isCommented;
      comments += isCommented ? 1 : -1;
    });
  }

  Widget _buildIconText(IconData icon, int count, Function() onPressed, bool isSelected) {
    return Row(
      children: [
        IconButton(
          color: isSelected ? Colors.blue : Colors.grey,
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
        ),
        const SizedBox(width: 5),
        Text(
          count.toString(),
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
