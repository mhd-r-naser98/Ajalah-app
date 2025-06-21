import 'package:ajalah/core/services/storage_service.dart';
import 'package:ajalah/features/auth/models/address.dart';
import 'package:ajalah/features/auth/models/geo_location.dart';
import 'package:ajalah/features/auth/models/register_dealer_model.dart';
import 'package:ajalah/features/auth/models/register_seller_model.dart';
import 'package:ajalah/features/auth/presentation/register/logic/state/register_steps_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/auth_repo.dart';
import 'package:equatable/equatable.dart';

part '../state/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepo;
  final StorageService _storageService;

  bool agreed = false;

  RegisterCubit(this._authRepo, this._storageService)
    : super(RegisterInitial());

  void setRole(UserRole role) {
    emit(state.copyWith(stepData: state.stepData.copyWith(role: role)));
  }

  void setAgreed(bool val) {
    emit(state.copyWith(stepData: state.stepData.copyWith(agreed: val)));
  }

  void setStep(int step) {
    emit(state.copyWith(currentStep: step));
  }

  void updateStepData(RegisterStepsData data) {
    emit(state.copyWith(stepData: data));
  }

  void updateOtp(String otp) {
    emit(state.copyWith(otp: otp));
  }

  void nextStep() {
    if (state.currentStep < 3) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 1) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void reset() {
    emit(RegisterInitial());
  }

  Future<void> registerSeller({
    required String fName,
    required String lName,
    required String password,
    required String phone,
    String? email,
    String? birth,
    required String city,
    String? gender,
  }) async {
    emit(RegisterLoading());
    try {
      final model = RegisterSellerModel(
        fName: fName,
        lName: lName,
        password: password,
        phone: phone,
        email: email,
        birth: birth,
        city: city,
        gender: gender,
      );
      await _authRepo.registerSeller(model);
      await _storageService.savePhone(phone);
      emit(RegisterSuccess());
      nextStep();
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }

  Future<void> confirmSignup({
    required String userPhone,
    required String code,
  }) async {
    emit(RegisterLoading());
    try {
      await _authRepo.confirmSignup(userPhone, code);
      await _storageService.removePhone();

      emit(ConfirmSuccess());
      reset();
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }

  Future<void> resendCode({required String userPhone}) async {
    emit(RegisterLoading());
    try {
      await _authRepo.resendCode(userPhone);

      emit(SendCodeSuccess());
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }

  Future<void> registerDealer({
    String? email,
    required String phone,
    required String password,
    required String tradingName,
    String? description,
    required Address address,
    required GeoLocation geoLocation,
  }) async {
    emit(RegisterLoading());
    try {
      final model = RegisterDealerModel(
        email: email,
        phone: phone,
        password: password,
        tradingName: tradingName,
        description: description,
        address: address,
        geoLocation: geoLocation,
      );
      await _authRepo.registerDealer(model);
      await _storageService.savePhone(phone);

      emit(RegisterSuccess());
      nextStep();
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }
}
