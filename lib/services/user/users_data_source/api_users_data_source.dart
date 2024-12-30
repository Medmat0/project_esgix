
import 'package:dio/dio.dart';
import 'package:esgix_project/model/user.dart';
import 'package:esgix_project/services/user/users_data_source/users_data_source.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../app_exception.dart';
import '../../../model/auth_login_dto.dart';
import '../../../singleton/session_manager.dart';
import '../../dio_service.dart';
import '../../error_service.dart';

class ApiUsersDataSource implements UsersDataSource {

  @override
  Future<User> addUser(User user) async {

      final dio = makeTheHeader();
      final response = await dio.post("${dotenv.env['BASE_URL']}auth/register",
          data: user.toJson(),
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),);
      final statusCode = response.statusCode;
      if(statusCode != 200) {
        String apiMessage = response.data["message"] ?? "Unknown error occurred.";
        throw whatTypeOfError(statusCode!, apiMessage: apiMessage);
      }
      return User.fromJson(response.data);

  }

  @override
  Future<bool> loginUser(String email, String password) async {
    final dio = makeTheHeader();
    final data = {
      "email": email,
      "password": password,
    };

      final response = await dio.post("${dotenv.env['BASE_URL']}auth/login",
          data: data,options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),);

      final json = response.data;
      final statusCode = response.statusCode;
      if (statusCode != 200) {
        String apiMessage = response.data["message"] ?? "Unknown error occurred.";
        throw whatTypeOfError(statusCode!, apiMessage: apiMessage);
      }
      final user = AuthLoginDto.fromJson(json);

      SessionManager.instance.setToken(user.token);
      SessionManager.instance.setUserId(user.record.id);
      return true;



  }

  @override
  Future<User> findUserById(String idUser) async {
    final dio = makeTheHeader();
    final response = await dio.get("${dotenv.env['BASE_URL']}users/$idUser");
    final statusCode = response.statusCode;
    final json = response.data;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return User.fromJson(json);
  }

  @override
  Future<List<User>> findListUsersByLikedIdPost(String idPost) async {
    final dio = makeTheHeader();
    final response =
    await dio.get("${dotenv.env['BASE_URL']}likes/$idPost/users");
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    final jsonList = response.data as List;
    return jsonList.map((jsonElement) => User.fromJson(jsonElement)).toList();
  }

  @override
  Future<User> updateUser(String userId, String? username, String? avatar, String? description) async {
    final dio = makeTheHeaderWithToken();
    final data = {
      if (username != null) 'username': username,
      if (avatar != null) 'avatar': avatar,
      if (description != null) 'description': description,
    };
    final response = await dio
        .put("${dotenv.env['BASE_URL']}users/$userId", data: data);
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return User.fromJson(response.data);
  }

}