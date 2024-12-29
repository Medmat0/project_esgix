part of 'user_management_bloc.dart';

@immutable
sealed class UserManagementEvent {
  const UserManagementEvent();
}


class UserRegisterEvent extends UserManagementEvent {
  final User user;

  const UserRegisterEvent({
    required this.user,
  });
}

class UserLoginEvent extends UserManagementEvent {
  final String email;
  final String password;

  const UserLoginEvent({
    required this.email,
    required this.password,
  });
}

class UserUpdateEvent extends UserManagementEvent {
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


