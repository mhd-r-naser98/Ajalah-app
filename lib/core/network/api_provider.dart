import 'package:dio/dio.dart';
import '../../core/network/interceptors/base_url_interceptor.dart';
import '../../core/network/interceptors/logging_interceptor.dart';
import '../services/storage_service.dart';
import 'interceptors/token_interceptor.dart';

class ApiProvider {
  final Dio dio;
  final String defaultBaseUrl;

  ApiProvider._(this.dio, this.defaultBaseUrl);

  static Future<ApiProvider> init({
    required StorageService storageService,
  }) async {
    final defaultUrl = 'https://eng-api.ajalah.net';

    final dio = Dio(
      BaseOptions(
        baseUrl: defaultUrl,
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 25),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.interceptors.add(LoggingInterceptor());
    dio.interceptors.add(TokenInterceptor(storageService));
    dio.interceptors.add(BaseUrlInterceptor());

    return ApiProvider._(dio, defaultUrl);
  }

  Dio get client => dio;
}
