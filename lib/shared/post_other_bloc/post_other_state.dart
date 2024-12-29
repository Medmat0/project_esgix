part of 'post_other_bloc.dart';

enum PostOtherStatus { initial, loading, success, error }

class PostOtherState  {
  final PostOtherStatus status;
  final PostException? exception;
  final List<Post> posts;

  const PostOtherState({
    this.status = PostOtherStatus.initial,
    this.exception,
    this.posts = const [],
  });

  PostOtherState copyWith({
    PostOtherStatus? status,
    PostException? exception,
    List<Post>? posts,
  }) {
    return PostOtherState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      posts: posts ?? this.posts,
    );
  }
}
