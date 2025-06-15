import 'package:dio/dio.dart';

class BaseUrlInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra.containsKey('baseUrl')) {
      final overrideUrl = options.extra['baseUrl'];
      if (overrideUrl is String && overrideUrl.isNotEmpty) {
        options.baseUrl = overrideUrl;
      }
    }
    super.onRequest(options, handler);
  }
}
