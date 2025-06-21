import 'package:ajalah/features/auth/presentation/register/logic/cubit/register_cubit.dart';
import 'package:ajalah/features/auth/presentation/register/logic/state/register_steps_data.dart';
import 'package:ajalah/features/auth/presentation/register/widgets/register_form_dealer.dart';
import 'package:ajalah/features/auth/presentation/register/widgets/register_form_seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterStepOne extends StatelessWidget {
  const RegisterStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.select((RegisterCubit c) => c.state.stepData.role);
    switch (role) {
      case UserRole.seller:
        return RegisterFormSeller();
      case UserRole.dealer:
        return RegisterFormDealer();
      default:
        return RegisterFormSeller();
    }
  }
}
