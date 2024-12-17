import 'package:bloc/bloc.dart';
import 'package:esgix_project/app_exception.dart';
import 'package:esgix_project/services/user/users_repository/users_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../model/user.dart';
import '../../services/dio_service.dart';

part 'user_event.dart';

part 'user_state.dart';

/*
UserManagementBloc: Handles user registration, login, and updates.
UserQueryBloc: Handles finding users by ID and by liked posts.
 */
class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository usersRepository;

  UserBloc({required this.usersRepository}) : super(const UserState()) {
    on<UserRegisterEvent>(_onAddUser);
    on<UserLoginEvent>(_onLoginUser);
    on<UserByIdEvent>(_onFindUserById);
    on<UserByLikePostEvent>(_onFindUserByLikePost);
    on<UserUpdateEvent>(_onUpdateUser);
  }

  void _onAddUser(UserRegisterEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserBlocStatus.addUser));
    try {
      final userUpdated = await usersRepository.addUser(event.user);
      emit(state.copyWith(
        status: UserBlocStatus.successAddingUser,
        users: [userUpdated],
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: UserBlocStatus.error));
    }
    return;
  }

  void _onLoginUser(UserLoginEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserBlocStatus.loginUser));
    try {
      await usersRepository.loginUser(event.email, event.password);
      emit(state.copyWith(
        status: UserBlocStatus.successLoginUser,
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: UserBlocStatus.error));
    }
    return;
  }

  void _onFindUserById(UserByIdEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserBlocStatus.findUserById));
    try {
      final user = await usersRepository.findUserById(event.userId);
      emit(state.copyWith(
        status: UserBlocStatus.successFindUser,
        users: [user],
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: UserBlocStatus.error));
    }
    return;
  }

  void _onFindUserByLikePost(
      UserByLikePostEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserBlocStatus.findUserByLiked));
    try {
      final users =
          await usersRepository.findListUsersByLikedIdPost(event.idPost);
      emit(state.copyWith(
        status: UserBlocStatus.successFindUserByLiked,
        users: users,
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: UserBlocStatus.error));
    }
    return;
  }

  void _onUpdateUser(UserUpdateEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserBlocStatus.updateUser));
    try {
      checkIfIHaveTheTokenForPathSecurise();
      final user = await usersRepository.updateUser(
          event.userId, event.username, event.username, event.description);
      emit(state.copyWith(
        status: UserBlocStatus.successUpdateUser,
        users: [user],
      ));
    } on UnauthorizedPathWithNoToken catch (_) {
      emit(state.copyWith(status: UserBlocStatus.errorNotLogin));
    } on Exception catch (_) {
      emit(state.copyWith(status: UserBlocStatus.error));
    }
    return;
  }
}
