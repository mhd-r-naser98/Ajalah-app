// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/core/di/service_locator.dart';
import '../state/confirm_state.dart';
import '../../../../data/auth_repo.dart';

class ConfirmCubit extends Cubit<ConfirmState> {
  final AuthRepository _authRepo = locator<AuthRepository>();

  final ConfirmInitial _lastInitialState = ConfirmInitial();

  ConfirmCubit() : super(ConfirmInitial());

  void submitPhone(String phone) async {
    try {
      emit(ConfirmLoading());
      await _authRepo.resendCode(phone);
      emit(ConfirmInitial(phone: phone, currentStep: 2));
      emit(ConfirmSuccess());
    } catch (e) {
      emit(
        ConfirmFailure(error: e.toString(), previousState: _lastInitialState),
      );
    }
  }

  void submitCode(String phone, String code) async {
    try {
      emit(ConfirmLoading());
      await _authRepo.confirmSignup(phone, code);
      emit(ConfirmSuccess());
      reset();
    } catch (e) {
      emit(
        ConfirmFailure(error: e.toString(), previousState: _lastInitialState),
      );
    }
  }

  void resendCode(String phone) async {
    try {
      emit(ConfirmLoading());
      await _authRepo.resendCode(phone);
      emit(ConfirmInitial(phone: phone, currentStep: 2));
    } catch (e) {
      emit(
        ConfirmFailure(error: e.toString(), previousState: _lastInitialState),
      );
    }
  }

  void reset() {
    emit(ConfirmInitial());
  }
}
