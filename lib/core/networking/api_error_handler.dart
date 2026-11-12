import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please try again.';

      case DioExceptionType.sendTimeout:
        return 'Sending request took too long.';

      case DioExceptionType.receiveTimeout:
        return 'Receiving response took too long.';

      case DioExceptionType.badCertificate:
        return 'Invalid server certificate.';

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';

      case DioExceptionType.transformTimeout:
        return 'Processing server response took too long.';

      case DioExceptionType.unknown:
        return 'Something went wrong. Please try again.';
    }
  }

  static String _handleStatusCode(int? statusCode) {
    if (statusCode == null) {
      return 'Something went wrong. Please try again.';
    }

    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';

      case 401:
        return 'Unauthorized. Please login again.';

      case 403:
        return 'You do not have permission to access this resource.';

      case 404:
        return 'Requested resource was not found.';

      case 405:
        return 'This request method is not allowed.';

      case 408:
        return 'Request timeout. Please try again.';

      case 409:
        return 'Conflict occurred.';

      case 422:
        return 'Invalid data. Please check your input.';

      case 429:
        return 'Too many requests. Please try again later.';

      default:
        if (statusCode >= 500) {
          return 'Server error. Please try again later.';
        }

        if (statusCode >= 400) {
          return 'Request failed. Please check your input.';
        }

        return 'Unexpected response from server.';
    }
  }
}
