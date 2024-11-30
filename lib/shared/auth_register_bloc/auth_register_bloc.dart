import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esgix_project/app_exception.dart';
import 'package:esgix_project/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'auth_register_event.dart';

part 'auth_register_state.dart';


class AuthRegisterBloc extends Bloc<AuthRegisterEvent, AuthRegisterState> {
  AuthRegisterBloc() : super(const AuthRegisterState()) {
    on<PostAuthRegisterEvent>(_onAddUser);
  }

  void _onAddUser(PostAuthRegisterEvent event,
      Emitter<AuthRegisterState> emit) async {
    emit(state.copyWith(status: AuthRegisterStatus.addingUser));
    try {
      final user = await _postRegister(event.user);
      emit(state.copyWith(
        status: AuthRegisterStatus.successAddingUser,
        user: user,
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: AuthRegisterStatus.error));
    }
    return;
  }

  Future<User> _postRegister(User user) async {

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['x-api-key'] =   dotenv.env['API_KEY'];
      final response = await dio.post(
          "${dotenv.env['BASE_URL']}auth/register",
          data: user.toJson()
      );
      return User.fromJson(response.data);
  }


}
