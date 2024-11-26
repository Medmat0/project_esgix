part of 'auth_login_bloc.dart';


enum AuthLoginStatus {
  initial,
  loading,
  success,
  error,
  enterLogin,
  successLogin,
  errorLoginUnknown,
  errorLogin,
}

class AuthLoginState {
  final AuthLoginStatus status;
  final AuthLoginDto? authLoginDto;
  final AuthException? exception;

  const AuthLoginState({
    this.status = AuthLoginStatus.initial,
    this.authLoginDto,
    this.exception,
  });

  AuthLoginState copyWith({
    AuthLoginStatus? status,
    AuthLoginDto? authLoginDto,
    AuthException? exception,
  }) {
    return AuthLoginState(
      status: status ?? this.status,
      authLoginDto: authLoginDto ?? this.authLoginDto,
      exception: exception ?? this.exception,
    );
  }
}
