import 'package:esgix_project/services/user/local_users_data_source/fake_local_users_data_source.dart';
import 'package:esgix_project/services/user/users_data_source/api_users_data_source.dart';
import 'package:esgix_project/services/user/users_repository/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:esgix_project/screen/register_view_screen.dart';
import 'package:esgix_project/shared/user_management_bloc/user_management_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  testWidgets('RegisterScreen UI test with invalid inputs', (WidgetTester tester) async {
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
          child: RegisterScreen(),
        ),
        routes: {
          '/login': (context) => Scaffold(body: Center(child: Text('Login Screen'))),
        },
      ),
    );

    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Sign up to get started'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(5));
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text("Already have an account? Log in"), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), '');
    await tester.enterText(find.byType(TextField).at(1), 'invalid-email');
    await tester.enterText(find.byType(TextField).at(2), 'bio');
    await tester.enterText(find.byType(TextField).at(3), '123');
    await tester.enterText(find.byType(TextField).at(4), '123');

    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('All fields are required.'), findsOneWidget);





  });



  testWidgets('RegisterScreen UI test with invalid inputs', (WidgetTester tester) async {
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
          child: RegisterScreen(),
        ),
        routes: {
          '/login': (context) => Scaffold(body: Center(child: Text('Login Screen'))),
        },
      ),
    );

    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Sign up to get started'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(5));
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text("Already have an account? Log in"), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'user');
    await tester.enterText(find.byType(TextField).at(1), 'invalid-email');
    await tester.enterText(find.byType(TextField).at(2), 'bio');
    await tester.enterText(find.byType(TextField).at(3), '123');
    await tester.enterText(find.byType(TextField).at(4), '123');

    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a valid email address.'), findsOneWidget);

  });



}
