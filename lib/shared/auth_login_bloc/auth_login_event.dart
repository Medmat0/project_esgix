part of 'auth_login_bloc.dart';

@immutable
sealed class AuthLoginEvent {
  const AuthLoginEvent();
}

class PostAuthLogin extends AuthLoginEvent {
  final UserLogin userLogin;

  const PostAuthLogin({required this.userLogin});
}
