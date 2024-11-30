part of 'auth_register_bloc.dart';

enum AuthRegisterStatus {
  initial,
  loading,
  success,
  error,
  addingUser,
  successAddingUser,
}

class AuthRegisterState {
  final AuthRegisterStatus status;
  final User? user;
  final AuthException? exception;

  const AuthRegisterState({
    this.status = AuthRegisterStatus.initial,
    this.user,
    this.exception,
  });

  AuthRegisterState copyWith({
    AuthRegisterStatus? status,
    User? user,
    AuthException? exception,
  }) {
    return AuthRegisterState(
      status: status ?? this.status,
      user: user ?? this.user,
      exception: exception ?? this.exception,
    );
  }
}
