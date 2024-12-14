import 'package:esgix_project/shared/post_bloc/post_bloc.dart';
import 'package:esgix_project/shared/user_bloc/user_bloc.dart';
import 'package:esgix_project/singleton/session_manager.dart';
import 'package:esgix_project/view/login_view_screen.dart';
import 'package:esgix_project/view/register_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  //await dotenv.load();
  //SessionManager.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => PostBloc()),
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
        },
      ),
    );
  }
}


