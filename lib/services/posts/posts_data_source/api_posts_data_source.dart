import 'package:esgix_project/model/post.dart';
import 'package:esgix_project/services/posts/posts_data_source/posts_data_source.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../dio_service.dart';
import '../../error_service.dart';

class ApiPostsDataSource implements PostsDataSource {
  @override
  Future<Post> addPost(Post post) async {
    checkIfIHaveTheTokenForPathSecurise();
    final dio = makeTheHeaderWithToken();
    final response = await dio.post(
      "${dotenv.env['BASE_URL']}posts",
      data: post.toJson(),
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return post;
  }

  @override
  Future<bool> deletePost(String id) async {
    checkIfIHaveTheTokenForPathSecurise();
    final dio = makeTheHeaderWithToken();
    final response = await dio.delete(
      "${dotenv.env['BASE_URL']}posts/$id",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return true;
  }

  @override
  Future<Post> findOnPostById(String id) async {
    final dio = makeTheHeader();
    final response = await dio.get(
      "${dotenv.env['BASE_URL']}posts/$id",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return Post.fromJson(response.data);
  }

  @override
  Future<Post> updatePost(Post post) async {
    checkIfIHaveTheTokenForPathSecurise();
    final dio = makeTheHeaderWithToken();
    final response = await dio.put("${dotenv.env['BASE_URL']}posts/${post.id}",
        data: post.toJson());
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return Post.fromJson(response.data);
  }

  @override
  Future<bool> likeAPost(String id) async {
    checkIfIHaveTheTokenForPathSecurise();
    final dio = makeTheHeaderWithToken();
    final response = await dio.post(
      "${dotenv.env['BASE_URL']}likes/$id",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return true;
  }

  @override
  Future<List<Post>> searchPost(String content) async {
    final dio = makeTheHeader();
    final response = await dio.get(
      "${dotenv.env['BASE_URL']}search?query=$content",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    final jsonList = response.data['data'] as List;
    final test =
        jsonList.map((jsonElement) => Post.fromJson(jsonElement)).toList();
    return test;
  }

  @override
  Future<List<Post>> getPostByOffset(int page, int offset) async {
    final dio = makeTheHeader();
    final response = await dio.get(
      "${dotenv.env['BASE_URL']}posts?page=$page&offset=$offset",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    final jsonList = response.data['data'] as List;
    return jsonList.map((jsonElement) => Post.fromJson(jsonElement)).toList();
  }

  @override
  Future<List<Post>> getPostsByUser(int page, int offset, String userId) async {
    final dio = makeTheHeader();
    final response = await dio.get(
      "${dotenv.env['BASE_URL']}user/$userId/posts?page=$page&offset=$offset",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    final jsonList = response.data['data'] as List;
    return jsonList.map((jsonElement) => Post.fromJson(jsonElement)).toList();
  }

  @override
  Future<List<Post>> getPostsByUserLiked(
      int page, int offset, String userId) async {
    final dio = makeTheHeader();
    final response = await dio.get(
      "${dotenv.env['BASE_URL']}user/$userId/likes?page=$page&offset=$offset",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    final jsonList = response.data['data'] as List;
    return jsonList.map((jsonElement) => Post.fromJson(jsonElement)).toList();
  }
}
