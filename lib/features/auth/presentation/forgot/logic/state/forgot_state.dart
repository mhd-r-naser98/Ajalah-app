sealed class ForgotState {
  const ForgotState();
}

class ForgotLoadingInitial extends ForgotState {}

class ForgotInitial extends ForgotState {
  final String? phone;
  final String? verificationCode;
  final int currentStep;

  ForgotInitial({this.phone, this.verificationCode, this.currentStep = 1});

  ForgotInitial copyWith({
    String? phone,
    String? verificationCode,
    int? currentStep,
  }) {
    return ForgotInitial(
      phone: phone ?? this.phone,
      verificationCode: verificationCode ?? this.verificationCode,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

class ForgotLoading extends ForgotState {}

class ForgotSuccess extends ForgotState {}

class ForgotFailure extends ForgotState {
  final String error;
  final ForgotInitial previousState;

  ForgotFailure({required this.error, required this.previousState});
}
