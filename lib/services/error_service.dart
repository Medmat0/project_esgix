import 'package:esgix_project/app_exception.dart';

AppException whatTypeOfError(int statusCode) {
  switch (statusCode) {
    case 401: // Unauthorized
      return UnauthorizedPathWithNoToken(
        message: "Unauthorized request with no token.",
      );
    case 403: // Forbidden
      return RequestForbidden(
        message: "You do not have permission to access this resource.",
      );
    case 404: // Not Found
      return ResourceNotFound(
        message: "The requested resource was not found.",
      );
    case 409: // Conflict
      return RequestConflict(
        message: "There was a conflict with the request.",
      );
    case 204: // No Content
      return RequestNoContent(
        message: "The request was successful but there is no content.",
      );
    case 400: // Bad Request
      return PostException(
        message: "The request was invalid or cannot be otherwise served.",
      );
    case 500: // Internal Server Error
      return AuthException(
        message: "An unexpected server error occurred.",
      );
    default: // Unknown status code
      return UnknownException();
  }
}
