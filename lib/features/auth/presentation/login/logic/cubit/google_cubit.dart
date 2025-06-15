import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/core/di/service_locator.dart';
import 'package:new_ajalah/features/auth/data/auth_repo.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/state/google_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final AuthRepository _authRepo = locator<AuthRepository>();

  GoogleAuthCubit() : super(GoogleAuthInitial());

  Future<void> signIn() async {
    emit(GoogleAuthLoading());

    final accessToken = await _authRepo.signInWithGoogle();

    if (accessToken == null) {
      emit(GoogleAuthFailure('فشل تسجيل الدخول عبر جوجل أو تم الإلغاء'));
      return;
    }

    final serverToken = await _authRepo.loginWithGoogleAccessToken(accessToken);

    if (serverToken == null) {
      emit(GoogleAuthFailure('فشل تسجيل الدخول على السيرفر'));
      return;
    }

    emit(GoogleAuthSuccess(serverToken));
  }
}
