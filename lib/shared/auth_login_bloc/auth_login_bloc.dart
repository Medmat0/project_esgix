import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../app_exception.dart';
import '../../model/auth_login_dto.dart';
import '../../model/user_login.dart';
import '../../singleton/session_manager.dart';

part 'auth_login_event.dart';

part 'auth_login_state.dart';

class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthLoginState> {
  AuthLoginBloc() : super(const AuthLoginState()) {
    on<PostAuthLogin>(_onLogin);
  }

  void _onLogin(PostAuthLogin event, Emitter<AuthLoginState> emit) async {
    emit(state.copyWith(status: AuthLoginStatus.enterLogin));
    try {
      final authLogin = await _postLogin(event.userLogin);
      emit(state.copyWith(
        status: AuthLoginStatus.successLogin,
        authLoginDto: authLogin,
      ));
    } on AuthException catch (_) {
      emit(state.copyWith(status: AuthLoginStatus.errorLogin));
    } on Exception catch (_) {
      emit(state.copyWith(status: AuthLoginStatus.errorLoginUnknown));
    }
    return;
  }

  Future<AuthLoginDto> _postLogin(UserLogin userLogin) async {
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['x-api-key'] =   dotenv.env['API_KEY'];
    final response =
        await dio.post("${dotenv.env['BASE_URL']}auth/login", data: userLogin);
    final json = response.data;
    final statusCode = response.statusCode;
    if (statusCode == 401) {
      throw AuthException(message: returnMessageErrorInRequest(json));
    } else {
      AuthLoginDto authLoginDto = AuthLoginDto.fromJson(json);
      SessionManager.instance.setToken(authLoginDto.token);
      return authLoginDto;
    }
  }

  String returnMessageErrorInRequest(Map<String, dynamic> json) {
    return json['message'];
  }
}
