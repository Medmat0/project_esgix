import '../../../model/post.dart';

abstract class PostsDataSource {
  Future<Post> addPost(Post post);

  Future<bool> deletePost(String id);

  Future<Post> findOnPostById(String id);

  Future<Post> updatePost(Post post);

  Future<bool> likeAPost(String id);

  Future<List<Post>> searchPost(String content);

  Future<List<Post>> getPostsByUserLiked(int page, int offset, String userId);

  Future<List<Post>> getPostByOffset(int page, int offset);

  Future<List<Post>> getPostsByUser(int page, int offset, String userId);

  Future<List<Post>> getCommentsPost(String idPost, int page, int offset);
}
