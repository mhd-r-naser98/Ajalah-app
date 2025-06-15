sealed class ConfirmState {
  const ConfirmState();
}

class ConfirmLoadingInitial extends ConfirmState {}

class ConfirmInitial extends ConfirmState {
  final String? phone;
  final String? verificationCode;
  final int currentStep;

  ConfirmInitial({this.phone, this.verificationCode, this.currentStep = 1});

  ConfirmInitial copyWith({
    String? phone,
    String? verificationCode,
    int? currentStep,
  }) {
    return ConfirmInitial(
      phone: phone ?? this.phone,
      verificationCode: verificationCode ?? this.verificationCode,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

class ConfirmLoading extends ConfirmState {}

class ConfirmSuccess extends ConfirmState {}

class ConfirmFailure extends ConfirmState {
  final String error;
  final ConfirmInitial previousState;

  ConfirmFailure({required this.error, required this.previousState});
}
