part of 'user_query_bloc.dart';

@immutable
sealed class UserQueryEvent {
  const UserQueryEvent();
}

class UserByIdEvent extends UserQueryEvent {
  final String userId;

  const UserByIdEvent({
    required this.userId,
  });
}

class UserByLikePostEvent extends UserQueryEvent {
  final String idPost;

  const UserByLikePostEvent({
    required this.idPost,
  });
}
