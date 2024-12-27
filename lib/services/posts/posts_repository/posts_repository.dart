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
    return await remoteDataSource.addPost(post);
  }

  Future<bool> deletePost(String id) async {
    return  await remoteDataSource.deletePost(id);
  }

  Future<Post> findOnPostById(String id) async {
    return  await remoteDataSource.findOnPostById(id);
  }

  Future<Post> updatePost(Post post) async {
    return  await remoteDataSource.updatePost(post);
  }

  Future<bool> likeAPost(String id) async {
    return await remoteDataSource.likeAPost(id);
  }

  Future<List<Post>> searchPost(String content) async {
    return await remoteDataSource.searchPost(content);
  }


  Future<List<Post>> getPostsByUserLiked(int page, int offset, String userId) async {
      return await remoteDataSource.getPostsByUserLiked(page, offset, userId);
  }

  Future<List<Post>> getPostByOffset(int page, int offset) async {
    return await remoteDataSource.getPostByOffset(page, offset);
  }

  Future<List<Post>> getPostsByUser(int page, int offset, String userId) async {
      return await remoteDataSource.getPostsByUser(page, offset, userId);
  }
}