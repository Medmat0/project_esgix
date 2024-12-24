import 'package:flutter/material.dart';
import 'package:esgix_project/widget/tweet_widget.dart';
import 'base_screen.dart';

class TweetScreen extends StatelessWidget {
  final String tweetContent = "This is a sample tweet!";
  final List<Map<String, dynamic>> comments = [
    {
      'profileImageUrl': 'https://cdn-icons-png.flaticon.com/512/455/455705.png',
      'username': 'User1',
      'handle': 'user1',
      'timeAgo': '1h',
      'content': 'Great tweet!',
      'likes': 2,
      'comments': 1,
    },
    {
      'profileImageUrl': 'https://cdn-icons-png.flaticon.com/512/455/455705.png',
      'username': 'User2',
      'handle': 'user2',
      'timeAgo': '2h',
      'content': 'I totally agree!',
      'likes': 3,
      'comments': 2,
    },
  ];

  TweetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tweet"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: TweetWidget(
                  profileImageUrl: 'https://cdn-icons-png.flaticon.com/512/455/455705.png',
                  username: 'John Doe',
                  handle: 'johndoe',
                  timeAgo: '2h',
                  content: tweetContent,
                  likes: 10,
                  comments: 5,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Comments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...comments.map((comment) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: IntrinsicHeight(
                  child: TweetWidget(
                    profileImageUrl: comment['profileImageUrl'],
                    username: comment['username'],
                    handle: comment['handle'],
                    timeAgo: comment['timeAgo'],
                    content: comment['content'],
                    likes: comment['likes'],
                    comments: comment['comments'],
                  ),
                ),
              )).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BaseScreen(),
    );
  }
}