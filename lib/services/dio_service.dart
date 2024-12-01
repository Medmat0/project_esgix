import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../app_exception.dart';
import '../singleton/session_manager.dart';

void checkIfIHaveTheTokenForPathSecurise() {
  if (!SessionManager.instance.hasToken) {
    throw UnauthorizedPathWithNoToken(message: 'no authorize path because your are not login');
  }
}

Dio makeTheHeaderWithToken() {
  Dio dio = Dio();
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers['x-api-key'] = dotenv.env['API_KEY'];
  dio.options.headers['Authorization'] =
      'Bearer ${SessionManager.instance.getBearerToken()}';
  return dio;
}

Dio makeTheHeader() {
  Dio dio = Dio();
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers['x-api-key'] = dotenv.env['API_KEY'];
  return dio;
}
