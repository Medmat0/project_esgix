import '../../../model/post.dart';
import '../local_posts_data_source/local_posts_data_source.dart';
import '../posts_data_source/posts_data_source.dart';

class PostsRepository {
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
    return await remoteDataSource.deletePost(id);
  }

  Future<Post> findOnPostById(String id) async {
    return await remoteDataSource.findOnPostById(id);
  }

  Future<Post> updatePost(Post post) async {
    return await remoteDataSource.updatePost(post);
  }

  Future<bool> likeAPost(String id) async {
    return await remoteDataSource.likeAPost(id);
  }

  Future<List<Post>> searchPost(String content) async {
    return await remoteDataSource.searchPost(content);
  }


  Future<List<Post>> getPostsByUserLiked(int page, int offset,
      String userId) async {
    return await remoteDataSource.getPostsByUserLiked(page, offset, userId);
  }

  Future<List<Post>> getPostByOffset(int page, int offset) async {
    return await remoteDataSource.getPostByOffset(page, offset);
  }

  Future<List<Post>> getPostsByUser(int page, int offset, String userId) async {
    return await remoteDataSource.getPostsByUser(page, offset, userId);
  }

  Future<List<Post>> getCommentsPost(String idPost, int page,
      int offset) async {
    return await remoteDataSource.getCommentsPost(idPost, page, offset);
  }

  Future<List<Post>> getPostsWithLikedStatus(int page, int offset,
      String? userId) async {
    final List<Post> allPosts = await remoteDataSource.getPostByOffset(
        page, offset);

    if (userId == null || userId.isEmpty) {
      return allPosts.map((post) => post.copyWith(likedByUser: false)).toList();
    }

    final List<Post> likedPosts = await remoteDataSource.getPostsByUserLiked(
        page, offset, userId);

    final Set<String> likedPostIds = likedPosts.map((post) => post.id ?? '')
        .toSet();

    final List<Post> updatedPosts = allPosts.map((post) {
      return post.copyWith(
        likedByUser: likedPostIds.contains(post.id),
      );
    }).toList();

    return updatedPosts;
  }

}