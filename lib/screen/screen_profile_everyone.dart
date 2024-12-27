import 'package:esgix_project/shared/user_query_bloc/user_query_bloc.dart';
import 'package:esgix_project/widget/tweet_like_by_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user.dart';
import '../widget/app_bar_widget.dart';
import '../widget/base_screen.dart';
import '../widget/profile_widget.dart';
import '../widget/tweet_created_by_user_widget.dart';

class ScreenProfileEveryone extends StatefulWidget {
  final String id;

  const ScreenProfileEveryone({super.key, required this.id});

  static Future<void> navigateTo(BuildContext context, String id) {
    return Navigator.pushNamed(context, '/profile-everyone', arguments: id);
  }

  @override
  State<StatefulWidget> createState() => ScreenProfileEveryoneState();
}

class ScreenProfileEveryoneState extends State<ScreenProfileEveryone> {
  // Variable d'état pour savoir quel widget afficher
  bool showLikedTweets = true;

  @override
  void initState() {
    super.initState();
    context.read<UserQueryBloc>().add(UserByIdEvent(userId: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(name: 'Profile'),
      body: Column(
        children: [
          // Ligne de boutons pour basculer entre les vues
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bouton pour afficher les tweets aimés
              TextButton(
                onPressed: () {
                  setState(() {
                    showLikedTweets = true;
                  });
                },
                child: Text(
                  'Tweets aimés',
                  style: TextStyle(
                    color: showLikedTweets ? Colors.blue : Colors.black,
                  ),
                ),
              ),
              // Bouton pour afficher les tweets créés
              TextButton(
                onPressed: () {
                  setState(() {
                    showLikedTweets = false;
                  });
                },
                child: Text(
                  'Tweets créés',
                  style: TextStyle(
                    color: !showLikedTweets ? Colors.blue : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: BlocBuilder<UserQueryBloc, UserQueryState>(
                    builder: (context, state) {
                      if (state.status == UserQueryStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.status == UserQueryStatus.error) {
                        return const Center(child: Text('Erreur lors de la récupération des données'));
                      }
                      if (state.users.isEmpty) {
                        return const Center(child: Text('Aucun utilisateur trouvé'));
                      }
                      return _buildProfileWidget(state.users.first);
                    },
                  ),
                ),
                Expanded(
                  child: showLikedTweets
                      ? TweetLikeByUserWidget(userId: widget.id)
                      : TweetCreatedByUserWidget(userId: widget.id),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BaseScreen(),
    );
  }

  Widget _buildProfileWidget(User user) {
    return ProfileWidget(
      id: user.id!,
      username: user.username,
      email: user.email,
      avatar: user.avatar,
      description: user.description,
    );
  }
}
