part of 'post_interaction_bloc.dart';

enum PostInteractionStatus {
  initial,
  loading,
  success,
  error,
  likePostSuccess,
}


class PostInteractionState {
  final PostInteractionStatus status;
  final PostException? exception;

  const PostInteractionState({
    this.status = PostInteractionStatus.initial,
    this.exception,
  });

  PostInteractionState copyWith({
    PostInteractionStatus? status,
    PostException? exception,
  }) {
    return PostInteractionState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }
}

