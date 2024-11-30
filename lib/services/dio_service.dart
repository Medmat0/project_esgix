
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../app_exception.dart';
import '../singleton/session_manager.dart';

void checkIfIHaveTheTokenForPathSecurise(){
  if (!SessionManager.instance.hasToken) {
    throw UnauthorizedPathWithNoToken(
      message: 'is path add post');
  }
}

Dio makeTheHeaderWithApiKey(){
  Dio dio = Dio();
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers['x-api-key'] = dotenv.env['API_KEY'];
  dio.options.headers['Authorization'] =
      SessionManager.instance.getBearerToken();
  return dio;
}