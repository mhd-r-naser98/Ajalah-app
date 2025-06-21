// ignore_for_file: avoid_print, unused_field, unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../../core/di/service_locator.dart';
import '../../../../../../features/auth/data/auth_repo.dart';
import '../../../../../../features/auth/presentation/login/logic/state/google_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final AuthRepository _authRepo = locator<AuthRepository>();

  GoogleAuthCubit() : super(GoogleAuthInitial());
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      "openid",
      "profile",
      "email",
      "https://www.googleapis.com/auth/user.addresses.read",
      "https://www.googleapis.com/auth/user.birthday.read",
      "https://www.googleapis.com/auth/user.gender.read",
      "https://www.googleapis.com/auth/user.phonenumbers.read",
    ],
  );
  Future<void> signIn() async {
    // final accessToken = await _authRepo.signInWithGoogle();

    // if (accessToken == null) {
    //   emit(GoogleAuthFailure('فشل تسجيل الدخول عبر جوجل أو تم الإلغاء'));
    //   return;
    // }

    // final serverToken = await _authRepo.loginWithGoogleAccessToken(accessToken);

    // if (serverToken == null) {
    //   emit(GoogleAuthFailure('فشل تسجيل الدخول على السيرفر'));
    //   return;
    // }

    try {
      emit(GoogleAuthLoading());
      final account = await _googleSignIn.signIn();
      final auth = await account?.authentication;

      final accessToken = auth?.accessToken;
      if (accessToken == null) {
        emit(GoogleAuthFailure('فشل تسجيل الدخول عبر جوجل أو تم الإلغاء'));
        return;
      }
      final serverToken = await _authRepo.loginWithGoogleAccessToken(
        accessToken,
      );
      print('serverToken: $serverToken');

      emit(GoogleAuthSuccess(''));
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }
}
