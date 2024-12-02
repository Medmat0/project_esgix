part of 'user_bloc.dart';

enum UserBlocStatus {
  initial,
  loading,
  error,
  success,
  addUser,
  successAddingUser,
  loginUser,
  successLoginUser,
  findUserById,
  successFindUser,
  findUserByLiked,
  successFindUserByLiked,
  updateUser,
  successUpdateUser,
  errorNotLogin,
}

final class UserState {
  final List<User> users;
  final UserBlocStatus status;
  final UserException? exception;

  const UserState({
    this.status = UserBlocStatus.initial,
    this.users = const [],
    this.exception,
  });

  UserState copyWith({
    UserBlocStatus? status,
    List<User>? users,
    UserException? exception,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      exception: exception ?? this.exception,
    );
  }
}
