part of 'post_bloc.dart';

enum PostBlocStatus {
  initial,
  loading,
  success,
  addPostSuccess,
  errorAddPost,
  error,
  deletePostSuccess,
  findOnePostSuccess,
  updatePostSuccess,
  searchPostSuccess,
  offsetPagePostSuccess,
  offsetPagePostByUserSuccess,
  offsetPagePostByUserLikedSuccess,
  errorNotLogin, likePostSuccess,
}

final class PostState {
  final List<Post> posts;
  final PostBlocStatus status;
  final PostException? exception;

  const PostState({
    this.status = PostBlocStatus.initial,
    this.posts = const [],
    this.exception,
  });

  PostState copyWith({
    PostBlocStatus? status,
    List<Post>? posts,
    PostException? exception,
  }) {
    return PostState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        exception: exception ?? this.exception);
  }
}
