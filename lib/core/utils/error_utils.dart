import 'package:dio/dio.dart';

class ErrorUtils {
  static String parseDioError(Object error) {
    if (error is DioException) {
      final data = error.response?.data;
      final message = data?['message'];

      if (message is List) {
        return message.join(' - ');
      } else if (message is String) {
        return message;
      } else if (error.message != null) {
        return error.message!;
      }
      return 'UnexpectedError';
    } else {
      return error.toString();
    }
  }
}
