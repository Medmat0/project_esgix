part of 'post_pagination_bloc.dart';

enum PostPaginationStatus {
  initial,
  loading,
  success,
  error,
  likePostSuccess,
  errorNotLogin,
  searchPostSuccess,
  offsetPagePostByUserLikedSuccess,
  offsetPagePostSuccess,
}

class PostPaginationState {
  final List<Post> posts;
  final PostPaginationStatus status;
  final PostException? exception;
  final bool hasMoreData;

  const PostPaginationState({
    this.status = PostPaginationStatus.initial,
    this.posts = const [],
    this.exception,
    this.hasMoreData = true,
  });

  PostPaginationState copyWith({
    PostPaginationStatus? status,
    List<Post>? posts,
    PostException? exception,
    bool? hasMoreData,
  }) {
    return PostPaginationState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      exception: exception ?? this.exception,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}