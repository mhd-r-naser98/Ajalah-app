import 'package:ajalah/core/di/service_locator.dart';
import 'package:ajalah/core/widgets/responsive_scroll_view.dart';
import 'package:ajalah/features/auth/presentation/register/logic/cubit/register_cubit.dart';
import 'package:ajalah/features/auth/presentation/register/pages/register_step_one.dart';
import 'package:ajalah/features/auth/presentation/register/pages/register_step_two_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final t = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => locator<RegisterCubit>(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: ResponsiveScrollView(
                onRefresh: null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.currentStep == 1)
                      const RegisterStepOne()
                    else
                      const RegisterStepTwoOtp(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
