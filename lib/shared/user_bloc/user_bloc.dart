import 'package:bloc/bloc.dart';
import 'package:esgix_project/app_exception.dart';
import 'package:esgix_project/model/auth_login_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../model/user.dart';
import '../../services/dio_service.dart';
import '../../services/error_service.dart';
import '../../singleton/session_manager.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<UserRegisterEvent>(_onAddUser);
    on<UserLoginEvent>(_onLoginUser);
    on<UserByIdEvent>(_onFindUserById);
    on<UserByLikePostEvent>(_onFindUserByLikePost);
    on<UserUpdateEvent>(_onUpdateUser);
  }

  void _onAddUser(UserRegisterEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserBlocStatus.addUser));
    try {
      final userUpdated = await _postRegister(event.user);
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
      await _postLogin(event.email, event.password);
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
      final user = await _findUserById(event.userId);
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
      final users = await _findListUsersByLikedIdPost(event.idPost);
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
      final user = await _updateUser(event);
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

  Future<User> _postRegister(User user) async {
    final dio = makeTheHeader();
    final response = await dio.post("${dotenv.env['BASE_URL']}auth/register",
        data: user.toJson());
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return User.fromJson(response.data);
  }

  Future<bool> _postLogin(String email, String password) async {
    final dio = makeTheHeader();
    final data = {
      'email': email,
      'password': password,
    };
    final response =
        await dio.post("${dotenv.env['BASE_URL']}auth/login", data: data);
    final json = response.data;
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    final user = AuthLoginDto.fromJson(json);
    SessionManager.instance.setToken(user.token);
    return true;
  }

  Future<User> _findUserById(String idUser) async {
    final dio = makeTheHeader();
    final response = await dio.get("${dotenv.env['BASE_URL']}users/$idUser");
    final statusCode = response.statusCode;
    final json = response.data;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return User.fromJson(json);
  }

  Future<List<User>> _findListUsersByLikedIdPost(String idPost) async {
    final dio = makeTheHeader();
    final response =
        await dio.get("${dotenv.env['BASE_URL']}likes/$idPost/users");
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    final jsonList = response.data as List;
    return jsonList.map((jsonElement) => User.fromJson(jsonElement)).toList();
  }

  Future<User> _updateUser(UserUpdateEvent user) async {
    final dio = makeTheHeaderWithToken();
    final data = {
      if (user.username != null) 'username': user.username,
      if (user.avatar != null) 'avatar': user.avatar,
      if (user.description != null) 'description': user.description,
    };
    final response = await dio
        .put("${dotenv.env['BASE_URL']}users/${user.userId}", data: data);
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return User.fromJson(response.data);
  }
}
