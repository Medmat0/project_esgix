class AppException implements Exception {
  static AppException from(dynamic exception) {
    if (exception is AppException) return exception;
    return UnknownException();
  }
}

class UnknownException extends AppException {}


class AuthException extends AppException {
  final String message;

  AuthException({required this.message});


}