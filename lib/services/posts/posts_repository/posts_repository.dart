import 'package:esgix_project/app_exception.dart';

import '../../../model/post.dart';
import '../local_posts_data_source/local_posts_data_source.dart';
import '../posts_data_source/posts_data_source.dart';

class PostsRepository{
  final PostsDataSource remoteDataSource;
  final LocalPostsDataSource localPostsDataSource;

  PostsRepository({
    required this.remoteDataSource,
    required this.localPostsDataSource,
  });

  Future<Post> savePost(Post post) async {
    try {
      final postSave = await remoteDataSource.addPost(post);
      localPostsDataSource.addPost(postSave);
      return post;
    } catch (error) {
      if(post.id == null){
        throw AppException();
      }
      return localPostsDataSource.findOnPostById(post.id!);
    }
  }

  Future<bool> deletePost(String id) async {
    try {
      final postDelete = await remoteDataSource.deletePost(id);
      localPostsDataSource.deletePost(id);
      return postDelete;
    } catch (error) {
      return false;
    }
  }

  Future<Post> findOnPostById(String id) async {
    try {
      final post = await remoteDataSource.findOnPostById(id);
      localPostsDataSource.addPost(post);
      return post;
    } catch (error) {
      return localPostsDataSource.findOnPostById(id);
    }
  }

  Future<Post> updatePost(Post post) async {
    try {
      final postUpdate = await remoteDataSource.updatePost(post);
      localPostsDataSource.addPost(postUpdate);
      return postUpdate;
    } catch (error) {
      return post;
    }
  }

  Future<bool> likeAPost(String id) async {
    try {
      final postLike = await remoteDataSource.likeAPost(id);
      localPostsDataSource.likeAPost(id);
      return postLike;
    } catch (error) {
      return false;
    }
  }

  Future<List<Post>> searchPost(String content) async {
    try {
      final posts = await remoteDataSource.searchPost(content);
      return posts;
    } catch (error) {
      return localPostsDataSource.searchPost(content);
    }
  }


  Future<List<Post>> getPostsByUserLiked(int page, int offset, String userId) async {
    try {
      final posts = await remoteDataSource.getPostsByUserLiked(page, offset, userId);
      return posts;
    } catch (error) {
      return localPostsDataSource.getPostsByUserLiked(page, offset, userId);
    }
  }

  Future<List<Post>> getPostByOffset(int page, int offset) async {
    try {
      final posts = await remoteDataSource.getPostByOffset(page, offset);
      return posts;
    } catch (error) {
      return localPostsDataSource.getPostByOffset(page, offset);
    }
  }

  Future<List<Post>> getPostsByUser(int page, int offset, String userId) async {
    try {
      final posts = await remoteDataSource.getPostsByUser(page, offset, userId);
      return posts;
    } catch (error) {
      return localPostsDataSource.getPostsByUser(page, offset, userId);
    }
  }
}