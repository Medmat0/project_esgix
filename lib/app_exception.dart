class AppException implements Exception {
  final String? message;
  AppException({this.message});

  static AppException from(dynamic exception) {
    if (exception is AppException) return exception;
    return UnknownException();
  }
}

class UnknownException extends AppException {
  UnknownException() : super(message: 'An unknown error occurred');
}

class AuthException extends AppException {
  AuthException({super.message});
}

class UserException extends AppException {
  UserException({super.message});
}

class PostException extends AppException {
  PostException({super.message});
}

class UnauthorizedPathWithNoToken extends AppException {
  UnauthorizedPathWithNoToken({super.message});
}

class ResourceNotFound extends AppException {
  ResourceNotFound({super.message});
}

class RequestForbidden extends AppException {
  RequestForbidden({super.message});
}

class RequestConflict extends AppException {
  RequestConflict({super.message});
}

class RequestNoContent extends AppException {
  RequestNoContent({super.message});
}