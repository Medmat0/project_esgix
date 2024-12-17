import 'package:esgix_project/model/post.dart';

import 'local_posts_data_source.dart';

class FakeLocalPostsDataSource implements LocalPostsDataSource {


  @override
  Future<Post> addPost(Post post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<bool> deletePost(String id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Post> findOnPostById(String id) {
    // TODO: implement findOnPostById
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPostByOffset(int page, int offset) {
    // TODO: implement getPostByOffset
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPostsByUser(int page, int offset, String userId) {
    // TODO: implement getPostsByUser
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPostsByUserLiked(int page, int offset, String userId) {
    // TODO: implement getPostsByUserLiked
    throw UnimplementedError();
  }

  @override
  Future<bool> likeAPost(String id) {
    // TODO: implement likeAPost
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> searchPost(String content) {
    // TODO: implement searchPost
    throw UnimplementedError();
  }

  @override
  Future<Post> updatePost(Post post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}