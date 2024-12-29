part of 'post_management_bloc.dart';

enum PostManagementStatus {
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
  errorNotLogin,
  likePostSuccess,
}

class PostManagementState {
  final Post? post;
  final PostManagementStatus status;
  final AppException? exception;

  const PostManagementState({
    this.status = PostManagementStatus.initial,
    this.post,
    this.exception,
  });

  PostManagementState copyWith({
    PostManagementStatus? status,
    Post? post,
    PostException? exception,
  }) {
    return PostManagementState(
        status: status ?? this.status,
        post: post ?? this.post,
        exception: exception ?? this.exception);
  }
}
