// ignore_for_file: overridden_fields

part of '../cubit/register_cubit.dart';

class RegisterState extends Equatable {
  final int currentStep;
  final RegisterStepsData stepData;
  final String otp;
  final String? error;

  const RegisterState({
    this.currentStep = 1,
    this.stepData = const RegisterStepsData(),
    this.otp = '',
    this.error,
  });

  RegisterState copyWith({
    int? currentStep,
    RegisterStepsData? stepData,
    String? otp,
    String? error,
  }) {
    return RegisterState(
      currentStep: currentStep ?? this.currentStep,
      stepData: stepData ?? this.stepData,
      otp: otp ?? this.otp,
      error: error,
    );
  }

  @override
  List<Object?> get props => [currentStep, stepData, otp, error];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial() : super();
}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class SendCodeSuccess extends RegisterState {}

class ConfirmSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  @override
  final String error;
  const RegisterFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
