import 'dart:io';

import 'package:esgix_project/shared/user_bloc/user_bloc.dart';
import 'package:esgix_project/singleton/session_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:esgix_project/model/user.dart';

void main() {
  setUpAll(() async {
    final path = '${Directory.current.path}/assets/.env';
    await dotenv.load(fileName: path);
  });

  group('UserBloc - Intégration', () {
    late UserBloc userBloc;
    late Dio dio;

    setUp(() {
      dio = Dio();
      userBloc = UserBloc();
    });

    tearDown(() {
      userBloc.close();
    });

    test('Enregistrement d\'un nouvel utilisateur', () async {
      final testSecond = DateTime.now().millisecondsSinceEpoch;
      const testUser = User(
        username: 'testuser',
        email: 'test201@example.com',
        password: 'testpassword123',
        avatar: 'https://picsum.photos/200/300',
      );

      userBloc.add(UserRegisterEvent(user: testUser));

      await expectLater(
          userBloc.stream,
          emitsInOrder([
            predicate<UserState>(
                (state) => state.status == UserBlocStatus.addUser),

            predicate<UserState>((state) =>
                state.status == UserBlocStatus.successAddingUser &&
                state.users.isNotEmpty)
          ]));

    });

    test('Connexion utilisateur', () async {
      final email = 'test201@example.com';
      final password = 'testpassword123';

      userBloc.add(UserLoginEvent(email: email, password: password));

      await expectLater(
          userBloc.stream,
          emitsInOrder([
            predicate<UserState>(
                (state) => state.status == UserBlocStatus.loginUser),

            predicate<UserState>(
                (state) => state.status == UserBlocStatus.successLoginUser)
          ]));
    });

    test('Recherche d\'un utilisateur par ID', () async {
      const userId =
          '7w6ux2kniy0o1zi';

      userBloc.add(UserByIdEvent(userId: userId));

      await expectLater(
          userBloc.stream,
          emitsInOrder([
            predicate<UserState>(
                (state) => state.status == UserBlocStatus.findUserById),

            predicate<UserState>((state) =>
                state.status == UserBlocStatus.successFindUser &&
                state.users.isNotEmpty)
          ]));
    });

    test('Mise à jour d\'utilisateur', () async {
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2xsZWN0aW9uSWQiOiJfcGJfdXNlcnNfYXV0aF8iLCJleHAiOjE3MzQzNDg0NTUsImlkIjoiN3c2dXgya25peTBvMXppIiwidHlwZSI6ImF1dGhSZWNvcmQifQ.oNU80gHZU2yyG8cyXVNfIK0_ArhGrr-G1uI6KsLuB_g';
      SessionManager.instance.setToken(token);
      const updateData = UserUpdateEvent(
          userId: '7w6ux2kniy0o1zi',
          description : 'Test de mise à jour de description');

      userBloc.add(updateData);

      await expectLater(
          userBloc.stream,
          emitsInOrder([
            predicate<UserState>(
                (state) => state.status == UserBlocStatus.updateUser),

            predicate<UserState>((state) =>
                state.status == UserBlocStatus.successUpdateUser &&
                state.users.isNotEmpty)
          ]));
    });


    test('Recherche d\'utilisateurs par ID de publication aimée', () async {
      const postId = 'aifp18fjdrhenor';

      userBloc.add(const UserByLikePostEvent(idPost: postId));

      await expectLater(
          userBloc.stream,
          emitsInOrder([
            predicate<UserState>(
                    (state) => state.status == UserBlocStatus.findUserByLiked),

            predicate<UserState>((state) =>
            state.status == UserBlocStatus.successFindUserByLiked &&
                state.users.isNotEmpty)
          ]));
    });
  });

}
