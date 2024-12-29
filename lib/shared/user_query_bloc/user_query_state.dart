part of 'user_query_bloc.dart';

enum UserQueryStatus {
  initial,
  loading,
  error,
  success,
  userById,
  userByLikePost,
  findUserById,
}

final class UserQueryState{
  final List<User> users;
  final UserQueryStatus status;
  final AppException? exception;

  const UserQueryState({
    this.users = const [],
    this.status = UserQueryStatus.initial,
    this.exception,
  });

  UserQueryState copyWith({
    UserQueryStatus? status,
    List<User>? users,
    AppException? exception,
  }) {
    return UserQueryState(
      status: status ?? this.status,
      users: users ?? this.users,
      exception: exception ?? this.exception,
    );
  }



}
