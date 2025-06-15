// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_ajalah/core/network/api_provider.dart';
import 'package:new_ajalah/core/services/storage_service.dart';
import 'package:new_ajalah/features/auth/models/register_dealer_model.dart';
import 'package:new_ajalah/features/auth/models/register_seller_model.dart';
import 'package:new_ajalah/features/auth/models/user_model.dart';

class AuthRepository {
  final ApiProvider apiProvider;
  final StorageService storageService;
  final GoogleSignIn googleSignIn;

  AuthRepository({
    required this.apiProvider,
    required this.storageService,
    GoogleSignIn? googleSignIn,
  }) : googleSignIn =
           googleSignIn ?? GoogleSignIn(scopes: ['email', 'profile']);

  Future<String?> signInWithGoogle() async {
    try {
      final account = await googleSignIn.signIn();

      if (account == null) {
        return null;
      }

      final auth = await account.authentication;
      print('Google sign auth: $auth');
      return auth.accessToken;
    } catch (e) {
      print('Google sign in failed: $e');
      return null;
    }
  }

  Future<String?> loginWithGoogleAccessToken(String accessToken) async {
    try {
      final response = await apiProvider.client.post(
        '/auth/google-login',
        data: {'access_token': accessToken},
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      }
      return null;
    } catch (e) {
      print('Server login failed: $e');
      return null;
    }
  }

  Future<void> login({required String phone, required String password}) async {
    try {
      final response = await apiProvider.client.post(
        '/auth/login',
        data: {'phoneOrEmail': phone, 'password': password},
      );
      print('respons $response');
      final token = response.data['data']['accessToken'] as String;
      storageService.saveToken(token);
      final userJson = response.data['data']['user'];
      final user = await compute(parseUserModel, userJson);
      storageService.saveUser(user);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception(
          'لم نتمكّن من الاتصال بالخادم، الرجاء المحاولة لاحقاً.',
        );
      }
      throw Exception(_handleDioError(e));
    }
  }

  Future<void> registerSeller(RegisterSellerModel model) async {
    try {
      await apiProvider.client.post(
        '/auth/register-client',
        data: model.toJson(),
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<void> registerDealer(RegisterDealerModel model) async {
    try {
      await apiProvider.client.post(
        '/auth/register-dealership',
        data: model.toJson(),
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<void> confirmSignup(String phone, String confirmationCode) async {
    try {
      await apiProvider.client.post(
        '/auth/confirm-signup',
        data: {"phone": phone, "confirmationCode": confirmationCode},
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<void> forgotPass(String phone) async {
    try {
      await apiProvider.client.post(
        '/auth/forgot-password',
        data: {"phone": phone},
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<void> verifyforgotPassCode(
    String phone,
    String verificationCode,
  ) async {
    try {
      await apiProvider.client.post(
        '/auth/verify-forgot-password-code',
        data: {"phone": phone, "verificationCode": verificationCode},
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<void> forgotPasswordVerify(
    String phone,
    String newPassword,
    String verificationCode,
  ) async {
    try {
      await apiProvider.client.post(
        '/auth/reset-password',
        data: {
          "phone": phone,
          "newPassword": newPassword,
          "verificationCode": verificationCode,
        },
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<void> resendCode(String phone) async {
    try {
      await apiProvider.client.post(
        '/auth/resend-confirmation',
        data: {"phone": phone},
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<void> logout() async {
    await apiProvider.client.post('/auth/logout');
    await storageService.removeToken();
  }

  String? _handleDioError(DioException error) {
    if (error.response != null && error.response?.data != null) {
      final data = error.response!.data;

      if (data is Map<String, dynamic>) {
        final msg = data['message'];

        if (msg is List) {
          return msg[0];
        } else if (msg is String) {
          return msg;
        } else if (msg != null) {
          return msg.toString();
        }
      }

      return error.response?.statusMessage ?? 'حدث خطأ غير معروف من السيرفر';
    } else {
      return error.message;
    }
  }
}

UserModel parseUserModel(dynamic json) {
  return UserModel.fromJson(json as Map<String, dynamic>);
}
