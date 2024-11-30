class AppException implements Exception {
  static AppException from(dynamic exception) {
    if (exception is AppException) return exception;
    return UnknownException();
  }
}

class UnknownException extends AppException {}

class AuthException extends AppException {
  final String message;

  AuthException({
    required this.message,
  });
}

class PostException extends AppException {
  final String? message;

  PostException({
    required this.message,
  });
}

class UnauthorizedPathWithNoToken extends AppException {
  final String? message;

  UnauthorizedPathWithNoToken({
    required this.message,
  });
}

class ResourceNotFound extends AppException {
  final String? message;

  ResourceNotFound({
    this.message,
  });
}

class RequestForbidden extends AppException {
  final String? message;

  RequestForbidden({
    this.message,
  });
}

class RequestConflict extends AppException {
  final String? message;

  RequestConflict({
    this.message,
  });
}

class RequestNoContent extends AppException {
  final String? message;

  RequestNoContent({
    this.message,
  });
}
