part of 'post_other_bloc.dart';

enum PostOtherStatus {
  initial,
  loading,
  success,
  error,
}

class PostOtherState {
  final List<Post> posts;
  final PostOtherStatus status;
  final bool hasMoreData;

  const PostOtherState({
    this.status = PostOtherStatus.initial,
    this.posts = const [],
    this.hasMoreData = true,
  });

  PostOtherState copyWith({
    PostOtherStatus? status,
    List<Post>? posts,
    bool? hasMoreData,
  }) {
    return PostOtherState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}