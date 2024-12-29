import 'package:esgix_project/screen/screen_edit_profile.dart';
import 'package:esgix_project/shared/user_query_bloc/user_query_bloc.dart';
import 'package:esgix_project/singleton/session_manager.dart';
import 'package:esgix_project/widget/tweet_like_by_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user.dart';
import '../widget/app_bar_widget.dart';
import '../widget/base_screen.dart';
import '../widget/profile_widget.dart';
import '../widget/tweet_created_by_user_widget.dart';
import 'login_view_screen.dart';

class ScreenProfileEveryone extends StatefulWidget {
  final String? id;

  const ScreenProfileEveryone({super.key, required this.id});

  static Future<void> navigateTo(BuildContext context, String? id) {
    return Navigator.pushNamed(context, '/profile-everyone', arguments: id);
  }

  @override
  State<StatefulWidget> createState() => ScreenProfileEveryoneState();
}

class ScreenProfileEveryoneState extends State<ScreenProfileEveryone> {
  bool showLikedTweets = true;
  bool isCurrentUser = false;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      context.read<UserQueryBloc>().add(UserByIdEvent(userId: widget.id!));
    } else if (widget.id == null && SessionManager.instance.hasToken) {
      isCurrentUser = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!SessionManager.instance.hasToken &&
        widget.id == null &&
        !isCurrentUser) {
      _onTwitterFeed(context);

      return Container();
    }
    return Scaffold(
      appBar: const AppBarWidget(name: 'Profile'),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    showLikedTweets = true;
                  });
                },
                child: Text(
                  'Likes tweets',
                  style: TextStyle(
                    color: showLikedTweets ? Colors.blue : Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    showLikedTweets = false;
                  });
                },
                child: Text(
                  'Created tweets',
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
                  child: widget.id != null
                      ? BlocBuilder<UserQueryBloc, UserQueryState>(
                          builder: (context, state) {
                            if (state.status == UserQueryStatus.loading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (state.status == UserQueryStatus.error) {
                              return const Center(child: Text("Error"));
                            }
                            if (state.status == UserQueryStatus.success &&
                                state.users.isEmpty) {
                              return const Center(
                                  child: Text("User not found"));
                            }
                            if (state.status == UserQueryStatus.success) {
                              return _buildProfileWidget(state.users.first);
                            }
                            return const SizedBox();
                          },
                        )
                      : _buildProfileWidget(
                          User(
                            id: SessionManager.instance.userId,
                            username: SessionManager.instance.username!,
                            email: SessionManager.instance.email,
                            avatar: SessionManager.instance.avatar!,
                            description: SessionManager.instance.description,
                          ),
                        ),
                ),
                Expanded(
                  child: showLikedTweets
                      ? TweetLikeByUserWidget(
                          userId: widget.id ?? SessionManager.instance.userId!)
                      : TweetCreatedByUserWidget(
                          userId: widget.id ?? SessionManager.instance.userId!),
                ),
                isCurrentUser
                    ? IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          ScreenEditProfile.navigateTo(
                            context,
                            User(
                              id: SessionManager.instance.userId,
                              username: SessionManager.instance.username!,
                              email: SessionManager.instance.email,
                              avatar: SessionManager.instance.avatar!,
                              description: SessionManager.instance.description,
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
                isCurrentUser
                    ? IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            LoginScreen.navigateTo(context);
                            SessionManager.instance.clearAll();
                          });
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BaseScreen(
        initialIndex: 2,
      ),
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

  void _onTwitterFeed(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LoginScreen.navigateTo(context);
    });
  }
}
