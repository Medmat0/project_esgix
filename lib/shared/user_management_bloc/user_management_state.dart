part of 'user_management_bloc.dart';

enum UserManagementStatus {
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
  updateUser,
  successUpdateUser,
  errorNotLogin,
}

final class UserManagementState {
  final User? user;
  final UserManagementStatus status;
  final AppException? exception;
  final String? errorMessage;

  const UserManagementState({
    this.status = UserManagementStatus.initial,
    this.user,
    this.exception,
    this.errorMessage,
  });

  UserManagementState copyWith({
    UserManagementStatus? status,
    User? user,
    UserException? exception,
    String? errorMessage,
  }) {
    return UserManagementState(
      status: status ?? this.status,
      user: user ?? this.user,
      exception: exception ?? this.exception,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}