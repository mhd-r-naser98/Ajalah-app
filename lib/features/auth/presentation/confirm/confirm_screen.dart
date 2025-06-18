import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ajalah/features/auth/presentation/confirm/logic/cubit/confirm_cubit.dart';
import 'package:new_ajalah/features/auth/presentation/confirm/logic/state/confirm_state.dart';
import 'package:new_ajalah/features/auth/presentation/confirm/widgets/step_one.dart';
import 'package:new_ajalah/features/auth/presentation/confirm/widgets/step_two.dart';
import 'package:new_ajalah/core/widgets/app_loading.dart';
import 'package:new_ajalah/core/widgets/app_snack_bar.dart';
import 'package:new_ajalah/core/widgets/responsive_scroll_view.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConfirmCubit(),
      child: BlocConsumer<ConfirmCubit, ConfirmState>(
        listener: (context, state) {
          if (state is ConfirmSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppSnackBar.success(context, 'تمت العملية بنجاح');
            });
          } else if (state is ConfirmFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppSnackBar.error(context, state.error);
            });
          }
        },
        builder: (context, state) {
          if (state is ConfirmLoading) {
            return const Scaffold(body: Center(child: LoadingWidget()));
          }
          if (state is ConfirmFailure) {
            state = state.previousState;
          }
          Widget stepWidget;
          if (state is ConfirmInitial) {
            switch (state.currentStep) {
              case 1:
                stepWidget = StepOne();
                break;
              case 2:
                stepWidget = StepTwo(phone: state.phone ?? '');
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
