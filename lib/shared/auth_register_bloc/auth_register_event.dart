part of 'auth_register_bloc.dart';

@immutable
sealed class AuthRegisterEvent {
  const AuthRegisterEvent();
}

class PostAuthRegister extends AuthRegisterEvent {
  final User user;

  const PostAuthRegister({required this.user});
}
