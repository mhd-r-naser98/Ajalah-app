// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/di/service_locator.dart';
import '../state/forgot_state.dart';
import '../../../../data/auth_repo.dart';

class ForgotCubit extends Cubit<ForgotState> {
  final AuthRepository _authRepo = locator<AuthRepository>();

  final ForgotInitial _lastInitialState = ForgotInitial();

  ForgotCubit() : super(ForgotInitial());

  void submitPhone(String phone) async {
    try {
      emit(ForgotLoading());
      await _authRepo.forgotPass(phone);
      emit(ForgotInitial(phone: phone, currentStep: 2));
      emit(ForgotSuccess());
    } catch (e) {
      emit(
        ForgotFailure(error: e.toString(), previousState: _lastInitialState),
      );
    }
  }

  void submitCode(String phone, String code) async {
    try {
      emit(ForgotLoading());
      await _authRepo.verifyforgotPassCode(phone, code);
      emit(ForgotInitial(verificationCode: code, currentStep: 3));
      emit(ForgotSuccess());
    } catch (e) {
      emit(
        ForgotFailure(error: e.toString(), previousState: _lastInitialState),
      );
    }
  }

  void resendCode(String phone) async {
    try {
      emit(ForgotLoading());
      await _authRepo.resendCode(phone);
      emit(ForgotInitial(phone: phone, currentStep: 2));
    } catch (e) {
      emit(
        ForgotFailure(error: e.toString(), previousState: _lastInitialState),
      );
    }
  }

  void submitPsssword(
    String phone,
    String newPassword,
    verificationCode,
  ) async {
    try {
      emit(ForgotLoading());
      await _authRepo.forgotPasswordVerify(
        phone,
        newPassword,
        verificationCode,
      );
      emit(ForgotSuccess());
      reset();
    } catch (e) {
      emit(
        ForgotFailure(error: e.toString(), previousState: _lastInitialState),
      );
    }
  }

  void reset() {
    emit(ForgotInitial());
  }
}
