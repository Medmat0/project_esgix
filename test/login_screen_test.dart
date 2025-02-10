import 'package:esgix_project/services/user/local_users_data_source/fake_local_users_data_source.dart';
import 'package:esgix_project/services/user/users_data_source/api_users_data_source.dart';
import 'package:esgix_project/services/user/users_repository/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:esgix_project/screen/login_view_screen.dart';
import 'package:esgix_project/shared/user_management_bloc/user_management_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  testWidgets('LoginScreen UI test', (WidgetTester tester) async {
    final userManagementBloc = UserManagementBloc(
      usersRepository: UsersRepository(
        remoteDataSource: ApiUsersDataSource(),
        localUsersDataSource: FakeLocalUsersDataSource(),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserManagementBloc>(
          create: (context) => userManagementBloc,
          child: LoginScreen(),
        ),
        routes: {
          '/register': (context) => Scaffold(body: Center(child: Text('Register Screen'))),
        },
      ),
    );

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Log in to continue'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text("Don't have an account? Sign up"), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'invalid-email');
    await tester.tap(find.text('Log In'));
    await tester.pump();

    expect(find.text('Please enter a valid email address.'), findsOneWidget);





    await tester.tap(find.text("Don't have an account? Sign up"));
    await tester.pumpAndSettle();
    expect(find.text('Register Screen'), findsOneWidget);
  });

  testWidgets('LoginScreen UI test', (WidgetTester tester) async {
    final userManagementBloc = UserManagementBloc(
      usersRepository: UsersRepository(
        remoteDataSource: ApiUsersDataSource(),
        localUsersDataSource: FakeLocalUsersDataSource(),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserManagementBloc>(
          create: (context) => userManagementBloc,
          child: LoginScreen(),
        ),
        routes: {
          '/register': (context) => Scaffold(body: Center(child: Text('Register Screen'))),
        },
      ),
    );

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Log in to continue'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text("Don't have an account? Sign up"), findsOneWidget);


    await tester.enterText(find.byType(TextField).at(0), 'valid@email.com');
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    expect(find.text("Password cannot be empty."), findsOneWidget);

  });







}
