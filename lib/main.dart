import 'package:esgix_project/screen/screen_feed.dart';
import 'package:esgix_project/screen/screen_profile.dart';
import 'package:esgix_project/screen/screen_search.dart';
import 'package:esgix_project/services/posts/local_posts_data_source/fake_local_posts_data_source.dart';
import 'package:esgix_project/services/posts/posts_data_source/api_posts_data_source.dart';
import 'package:esgix_project/services/posts/posts_repository/posts_repository.dart';
import 'package:esgix_project/services/user/local_users_data_source/fake_local_users_data_source.dart';
import 'package:esgix_project/services/user/users_data_source/api_users_data_source.dart';
import 'package:esgix_project/services/user/users_repository/users_repository.dart';
import 'package:esgix_project/shared/post_bloc/post_bloc.dart';
import 'package:esgix_project/shared/user_management_bloc/user_management_bloc.dart';
import 'package:esgix_project/shared/user_query_bloc/user_query_bloc.dart';
import 'package:esgix_project/singleton/session_manager.dart';
import 'package:esgix_project/screen/login_view_screen.dart';
import 'package:esgix_project/screen/register_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async {

  try {
    await dotenv.load(fileName: ".env");
    SessionManager.instance;
    runApp(const MyApp());
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  //await dotenv.load(fileName: '.env');

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/tweet_feed': (context) => const ScreenFeed(),
          '/search': (context) => const ScreenSearch(),
          '/profile': (context) => const ScreenProfile(),
        },
      ),
    );
  }
}
