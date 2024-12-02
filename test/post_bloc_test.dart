import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:esgix_project/shared/post_bloc/post_bloc.dart';
import 'package:esgix_project/singleton/session_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:esgix_project/model/post.dart';

void main() {
  setUpAll(() async {
    final path = '${Directory.current.path}/assets/.env';
    await dotenv.load(fileName: path);
  });

  group('PostBloc - Intégration', () {
    late PostBloc postBloc;
    late Post testPost;
    late String
        testUserId;

    setUp(() {
      postBloc = PostBloc();

      testPost = Post(
        content: 'Test post ${DateTime.now().millisecondsSinceEpoch}',
      );

      testUserId = '7w6ux2kniy0o1zi';
    });

    tearDown(() {
      postBloc.close();
    });

    test('Ajout d\'un nouveau post', () async {
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2xsZWN0aW9uSWQiOiJfcGJfdXNlcnNfYXV0aF8iLCJleHAiOjE3MzQzNjEwOTksImlkIjoiN3c2dXgya25peTBvMXppIiwidHlwZSI6ImF1dGhSZWNvcmQifQ.jx8LXKk3tokVntWS94pDFWJjVUveH5mkeZDYMTDt4cQ';
      SessionManager.instance.setToken(token);
      postBloc.add(PostAddEvent(post: testPost));

      await expectLater(
          postBloc.stream,
          emitsInOrder([
            predicate<PostState>(
                (state) => state.status == PostBlocStatus.loading),

            predicate<PostState>((state) =>
                state.status == PostBlocStatus.addPostSuccess &&
                state.posts.isNotEmpty)
          ]));
    });

    test('Recherche de posts', () async {
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2xsZWN0aW9uSWQiOiJfcGJfdXNlcnNfYXV0aF8iLCJleHAiOjE3MzQzNDk1NTksImlkIjoiN3c2dXgya25peTBvMXppIiwidHlwZSI6ImF1dGhSZWNvcmQifQ.CQdMqFmjh60yvjc18d1OurPUgv0nDuTWReFUQfbKcIY';
      SessionManager.instance.setToken(token);
      postBloc.add(PostSearchEvent(content: 'Test post'));

      await expectLater(
          postBloc.stream,
          emitsInOrder([
            predicate<PostState>(
                (state) => state.status == PostBlocStatus.loading),

            predicate<PostState>((state) =>
                state.status == PostBlocStatus.searchPostSuccess &&
                state.posts.isNotEmpty)
          ]));
    });

    test('Récupération de posts par offset', () async {

      postBloc.add(PostOffsetEvent(page: 0, offset: 10));

      await expectLater(
          postBloc.stream,
          emitsInOrder([
            predicate<PostState>(
                (state) => state.status == PostBlocStatus.loading),

            predicate<PostState>((state) =>
                state.status == PostBlocStatus.offsetPagePostSuccess &&
                state.posts.isNotEmpty)
          ]));
    });

    test('Récupération de posts par utilisateur', () async {
      postBloc.add(PostByUserEvent(page: 0, offset: 10, userId: testUserId));

      // Vérifier les états émis
      await expectLater(
          postBloc.stream,
          emitsInOrder([
            predicate<PostState>(
                (state) => state.status == PostBlocStatus.loading),

            predicate<PostState>((state) =>
                state.status == PostBlocStatus.offsetPagePostByUserSuccess &&
                state.posts.isNotEmpty)
          ]));
    });

    test('Like d\'un post', () async {
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2xsZWN0aW9uSWQiOiJfcGJfdXNlcnNfYXV0aF8iLCJleHAiOjE3MzQzNDk1NTksImlkIjoiN3c2dXgya25peTBvMXppIiwidHlwZSI6ImF1dGhSZWNvcmQifQ.CQdMqFmjh60yvjc18d1OurPUgv0nDuTWReFUQfbKcIY';
      SessionManager.instance.setToken(token);
      final testPostId = 'aifp18fjdrhenor';
      postBloc.add(PostLikeEvent(id: testPostId));

      await expectLater(
          postBloc.stream,
          emitsInOrder([
            predicate<PostState>(
                (state) => state.status == PostBlocStatus.loading),

            predicate<PostState>(
                (state) => state.status == PostBlocStatus.findOnePostSuccess)
          ]));
    });

    test('Suppression d\'un post', () async {
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2xsZWN0aW9uSWQiOiJfcGJfdXNlcnNfYXV0aF8iLCJleHAiOjE3MzQzNDk1NTksImlkIjoiN3c2dXgya25peTBvMXppIiwidHlwZSI6ImF1dGhSZWNvcmQifQ.CQdMqFmjh60yvjc18d1OurPUgv0nDuTWReFUQfbKcIY';
      SessionManager.instance.setToken(token);
      final testPostId = 'eljv01klnqhd66y';

      postBloc.add(PostDeleteEvent(idPost: testPostId));

      // Vérifier les états émis
      await expectLater(
          postBloc.stream,
          emitsInOrder([
            predicate<PostState>(
                (state) => state.status == PostBlocStatus.loading),

            predicate<PostState>(
                (state) => state.status == PostBlocStatus.deletePostSuccess)
          ]));
    });
  });
}
