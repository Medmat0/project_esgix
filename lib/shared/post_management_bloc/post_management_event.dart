part of 'post_management_bloc.dart';

@immutable
sealed class PostManagementEvent {
  const PostManagementEvent();
}

class PostManagementAddEvent extends PostManagementEvent {
  final Post post;

  const PostManagementAddEvent({
    required this.post,
  });
}

class PostManagementDeleteEvent extends PostManagementEvent {
  final String idPost;

  const PostManagementDeleteEvent({
    required this.idPost,
  });
}

class PostManagementFindOneEvent extends PostManagementEvent {
  final String idPost;

  const PostManagementFindOneEvent({
    required this.idPost,
  });
}

class PostManagementUpdateEvent extends PostManagementEvent {
  final Post post;

  const PostManagementUpdateEvent({
    required this.post,
  });
}