import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ajalah/features/auth/presentation/forgot/logic/cubit/forgot_cubit.dart';
import 'package:new_ajalah/features/auth/presentation/forgot/logic/state/forgot_state.dart';
import 'package:new_ajalah/features/auth/presentation/forgot/widgets/step_one.dart';
import 'package:new_ajalah/features/auth/presentation/forgot/widgets/step_three.dart';
import 'package:new_ajalah/features/auth/presentation/forgot/widgets/step_two.dart';
import 'package:new_ajalah/core/widgets/app_loading.dart';
import 'package:new_ajalah/core/widgets/app_snack_bar.dart';
import 'package:new_ajalah/core/widgets/responsive_scroll_view.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotCubit(),
      child: BlocConsumer<ForgotCubit, ForgotState>(
        listener: (context, state) {
          if (state is ForgotSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppSnackBar.success(context, 'SuccessfullyCompleted');
            });
          } else if (state is ForgotFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppSnackBar.error(context, state.error);
            });
          }
        },
        builder: (context, state) {
          if (state is ForgotLoading) {
            return const Scaffold(body: Center(child: LoadingWidget()));
          }
          if (state is ForgotFailure) {
            state = state.previousState;
          }
          Widget stepWidget;
          if (state is ForgotInitial) {
            switch (state.currentStep) {
              case 1:
                stepWidget = StepOne();
                break;
              case 2:
                stepWidget = StepTwo(phone: state.phone ?? '');
                break;
              case 3:
                stepWidget = StepThree(
                  phone: state.phone ?? '',
                  code: state.verificationCode ?? '',
                );
                break;
              default:
                stepWidget = StepOne();
            }

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/home');
                    }
                  },
                ),
                elevation: 0,
              ),
              body: Center(
                child: ResponsiveScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [stepWidget],
                  ),
                ),
              ),
            );
          }

          return const Scaffold(body: Center(child: LoadingWidget()));
        },
      ),
    );
  }
}
