part of 'auth_register_bloc.dart';

@immutable
sealed class AuthRegisterEvent {
  const AuthRegisterEvent();
}

class PostAuthRegisterEvent extends AuthRegisterEvent {
  final User user;

  const PostAuthRegisterEvent({required this.user});
}
