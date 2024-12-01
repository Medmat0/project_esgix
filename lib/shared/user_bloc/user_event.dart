part of 'user_bloc.dart';

@immutable
sealed class UserEvent {
  const UserEvent();
}

class UserRegisterEvent extends UserEvent {
  final User user;

  const UserRegisterEvent({
    required this.user,
  });
}

class UserLoginEvent extends UserEvent {
  final String email;
  final String password;

  const UserLoginEvent({
    required this.email,
    required this.password,
  });
}

class UserByIdEvent extends UserEvent {
  final String userId;

  const UserByIdEvent({
    required this.userId,
  });
}

class UserByLikePostEvent extends UserEvent {
  final String idPost;

  const UserByLikePostEvent({
    required this.idPost,
  });
}

class UserUpdateEvent extends UserEvent {
  final String userId;
  final String? username;
  final String? description;
  final String? avatar;

  const UserUpdateEvent({
    required this.userId,
    this.username,
    this.description,
    this.avatar,
  });
}
