// ignore_for_file: avoid_print

import 'package:ajalah/core/utils/error_utils.dart';
import 'package:flutter/foundation.dart';
import '../../../core/network/api_provider.dart';
import '../../../core/services/storage_service.dart';
import '../../../features/auth/models/register_dealer_model.dart';
import '../../../features/auth/models/register_seller_model.dart';
import '../../../features/auth/models/user_model.dart';

class AuthRepository {
  final ApiProvider apiProvider;
  final StorageService storageService;

  AuthRepository({required this.apiProvider, required this.storageService});

  Future<String?> loginWithGoogleAccessToken(String accessToken) async {
    try {
      final response = await apiProvider.client.post(
        '/auth/login-google',
        data: {'access_token': accessToken},
      );

      if (response.statusCode == 200) {
        print('response');
        return response.data['token'];
      }
      return null;
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
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
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }

  Future<void> registerSeller(RegisterSellerModel model) async {
    try {
      await apiProvider.client.post(
        '/auth/register-client',
        data: model.toJson(),
      );
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }

  Future<void> registerDealer(RegisterDealerModel model) async {
    try {
      await apiProvider.client.post(
        '/auth/register-dealership',
        data: model.toJson(),
      );
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }

  Future<void> confirmSignup(String phone, String confirmationCode) async {
    try {
      await apiProvider.client.post(
        '/auth/confirm-signup',
        data: {"phone": phone, "confirmationCode": confirmationCode},
      );
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }

  Future<void> forgotPass(String phone) async {
    try {
      await apiProvider.client.post(
        '/auth/forgot-password',
        data: {"phone": phone},
      );
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
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
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
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
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }

  Future<void> resendCode(String phone) async {
    try {
      await apiProvider.client.post(
        '/auth/resend-confirmation',
        data: {"phone": phone},
      );
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }

  Future<void> logout() async {
    try {
      await apiProvider.client.post('/auth/logout');
      await storageService.removeToken();
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }
}

UserModel parseUserModel(dynamic json) {
  return UserModel.fromJson(json as Map<String, dynamic>);
}
