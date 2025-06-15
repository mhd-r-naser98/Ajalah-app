// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(' Dio Error Type: ${err.type}');
    print('🔴 Dio Error Message: ${err.message}');
    print(' Dio Error Response: ${err.response}');
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(' Request: [${options.method}] ${options.uri}');
    print(' Headers: ${options.headers}');
    print(' Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(' Response: ${response.statusCode} ${response.requestOptions.uri}');
    print(' Data: ${response.data}');
    super.onResponse(response, handler);
  }
}
