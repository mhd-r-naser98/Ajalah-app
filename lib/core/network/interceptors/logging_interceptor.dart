// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('* Request: [${options.method}] ${options.uri}');
    print('* Headers: ${options.headers}');
    print('* Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      '* Response [${response.statusCode}] => ${response.requestOptions.uri}',
    );
    print('* Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;

      final message = data['message'];

      final newErr = DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: message[0],
        stackTrace: err.stackTrace,
      );

      super.onError(newErr, handler);

      return;
    }

    super.onError(err, handler);
  }
}
