// ignore_for_file: library_prefixes

import 'package:dio/dio.dart';
import 'package:new_ajalah/app/router.dart';
import 'package:new_ajalah/core/config/router.dart';
import '../../services/storage_service.dart';

class TokenInterceptor extends Interceptor {
  final StorageService storageService;

  TokenInterceptor(this.storageService);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storageService.getToken();
    final savedLanguage = await storageService.getSavedLanguage();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    if (savedLanguage != null && savedLanguage.isNotEmpty) {
      options.headers['X-Lang'] = savedLanguage;
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await storageService.removeToken();
      AppRouter.router.go(AppRoutes.login);
    }
    handler.next(err);
  }
}
