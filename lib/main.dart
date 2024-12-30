import 'package:esgix_project/screen/login_view_screen.dart';
import 'package:esgix_project/screen/register_view_screen.dart';
import 'package:esgix_project/screen/screen_add_post.dart';
import 'package:esgix_project/screen/screen_edit_profile.dart';
import 'package:esgix_project/screen/screen_feed.dart';
import 'package:esgix_project/screen/screen_modify_post.dart';
import 'package:esgix_project/screen/screen_people_like_post.dart';
import 'package:esgix_project/screen/screen_profile_everyone.dart';
import 'package:esgix_project/screen/screen_search.dart';
import 'package:esgix_project/screen/screen_tweet.dart';
import 'package:esgix_project/services/posts/local_posts_data_source/fake_local_posts_data_source.dart';
import 'package:esgix_project/services/posts/posts_data_source/api_posts_data_source.dart';
import 'package:esgix_project/services/posts/posts_repository/posts_repository.dart';
import 'package:esgix_project/services/user/local_users_data_source/fake_local_users_data_source.dart';
import 'package:esgix_project/services/user/users_data_source/api_users_data_source.dart';
import 'package:esgix_project/services/user/users_repository/users_repository.dart';
import 'package:esgix_project/shared/post_bloc/post_bloc.dart';
import 'package:esgix_project/shared/post_management_bloc/post_management_bloc.dart';
import 'package:esgix_project/shared/post_other_bloc/post_other_bloc.dart';
import 'package:esgix_project/shared/post_pagination_bloc/post_pagination_bloc.dart';
import 'package:esgix_project/shared/user_management_bloc/user_management_bloc.dart';
import 'package:esgix_project/shared/user_query_bloc/user_query_bloc.dart';
import 'package:esgix_project/singleton/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'model/user.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/.env');
  SessionManager.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => UserManagementBloc(
                  usersRepository: UsersRepository(
                    remoteDataSource: ApiUsersDataSource(),
                    localUsersDataSource: FakeLocalUsersDataSource(),
                  ),
                )),
        BlocProvider(
            create: (context) => UserQueryBloc(
                  usersRepository: UsersRepository(
                    remoteDataSource: ApiUsersDataSource(),
                    localUsersDataSource: FakeLocalUsersDataSource(),
                  ),
                )),
        BlocProvider(
            create: (context) => PostBloc(
                  postsRepository: PostsRepository(
                    remoteDataSource: ApiPostsDataSource(),
                    localPostsDataSource: FakeLocalPostsDataSource(),
                  ),
                )),
        BlocProvider(
            create: (context) => PostManagementBloc(
                  postsRepository: PostsRepository(
                    remoteDataSource: ApiPostsDataSource(),
                    localPostsDataSource: FakeLocalPostsDataSource(),
                  ),
                )),
        BlocProvider(
            create: (context) => PostPaginationBloc(
                  postsRepository: PostsRepository(
                    remoteDataSource: ApiPostsDataSource(),
                    localPostsDataSource: FakeLocalPostsDataSource(),
                  ),
                )),
        BlocProvider(
            create: (context) => PostOtherBloc(
                  postsRepository: PostsRepository(
                    remoteDataSource: ApiPostsDataSource(),
                    localPostsDataSource: FakeLocalPostsDataSource(),
                  ),
                )),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/tweet_feed',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/tweet_feed': (context) => const ScreenFeed(),
          '/search': (context) => const ScreenSearch(),
          '/tweet': (context) => ScreenTweet(
                id: ModalRoute.of(context)!.settings.arguments as String,
              ),
          '/add_post': (context) => ScreenAddPost(
                id: ModalRoute.of(context)!.settings.arguments as String?,
              ),
          '/profile-everyone': (context) => ScreenProfileEveryone(
                id: ModalRoute.of(context)!.settings.arguments as String?,
              ),
          '/people_like_post': (context) => ScreenPeopleLikePost(
                postId: ModalRoute.of(context)!.settings.arguments as String,
              ),
          '/edit-profile': (context) => ScreenEditProfile(
                user: ModalRoute.of(context)!.settings.arguments as User,
              ),
          '/edit-post': (context) => ScreenModifyPost(
                id: ModalRoute.of(context)!.settings.arguments as String,
              ),
        },
      ),
    );
  }
}
