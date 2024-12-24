import 'package:flutter/material.dart';

class TweetWidget extends StatefulWidget {
  final String profileImageUrl;
  final String username;
  final String handle;
  final String timeAgo;
  final String content;
  final int likes;
  final int comments;

  const TweetWidget({
    super.key,
    required this.profileImageUrl,
    required this.username,
    required this.handle,
    required this.timeAgo,
    required this.content,
    required this.likes,
    required this.comments,
  });

  @override
  TweetWidgetState createState() => TweetWidgetState();
}

class TweetWidgetState extends State<TweetWidget> {
  late int likes;
  late int comments;

  @override
  void initState() {
    super.initState();
    likes = widget.likes;
    comments = widget.comments;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  Text(widget.content),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIconText(Icons.comment, comments),
                      _buildIconText(Icons.favorite, likes),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, int count) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(width: 5),
        Text(
          count.toString(),
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}