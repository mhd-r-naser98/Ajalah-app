// ignore_for_file: use_build_context_synchronously

import 'package:ajalah/app/router.dart';
import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/config/router.dart';
import 'package:ajalah/core/di/service_locator.dart';
import 'package:ajalah/core/services/storage_service.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/app_button.dart';
import 'package:ajalah/core/widgets/app_custom_link.dart';
import 'package:ajalah/core/widgets/app_loading.dart';
import 'package:ajalah/core/widgets/app_otp_field.dart';
import 'package:ajalah/core/widgets/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../logic/cubit/register_cubit.dart';

class RegisterStepTwoOtp extends StatefulWidget {
  const RegisterStepTwoOtp({super.key});

  @override
  State<RegisterStepTwoOtp> createState() => _RegisterStepTwoOtpState();
}

class _RegisterStepTwoOtpState extends State<RegisterStepTwoOtp> {
  String? phone;

  @override
  void initState() {
    super.initState();
    final storageService = locator<StorageService>();
    storageService.getSavedPhone().then((value) {
      setState(() {
        phone = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final t = context.t;

    late final FormGroup form = FormGroup({
      'otp': FormControl<String>(
        value: '',
        validators: [Validators.required, Validators.minLength(4)],
      ),
    });
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            AppSnackBar.error(context, state.error);
          });
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
          return const Center(child: LoadingWidget());
        }
        if (state is RegisterFailure) {
          AppSnackBar.error(context, state.error);
        }
        return Center(
          child: ReactiveForm(
            formGroup: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  t('PhoneVerification'),
                  style: context.textStyles.styles.headlineMedium,
                ),
                const ResponsiveSpacer(size: SpacerSize.small),
                Text(
                  '${t('EnterOTP')} $phone',
                  style: context.textStyles.styles.labelLarge,
                ),
                const ResponsiveSpacer(size: SpacerSize.xLarge),

                ReactiveOtpField(formControlName: 'otp', showErrors: true),
                const ResponsiveSpacer(size: SpacerSize.xLarge),
                CustomButton(
                  text: t('Continue'),
                  onTap: () async {
                    final otp = form.control('otp').value;
                    if (form.valid) {
                      if (otp == null || otp is! String || otp.trim().isEmpty) {
                        AppSnackBar.error(context, t('CodeRequired'));
                        return;
                      }
                      await cubit.confirmSignup(userPhone: phone!, code: otp);
                      AppSnackBar.success(context, t('Confirmed'));
                      AppRouter.router.go(AppRoutes.login);
                    } else {
                      AppSnackBar.error(context, t('codeMustBe'));

                      form.markAllAsTouched();
                    }
                  },
                ),

                const ResponsiveSpacer(size: SpacerSize.medium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t("DidnCode"),
                            style: context.textStyles.styles.labelMedium,
                          ),
                          const ResponsiveSpacer(
                            axis: Axis.horizontal,
                            size: SpacerSize.xSmall,
                          ),
                          CustomLinkText(
                            text: t("Resend"),
                            onTap: () async {
                              if (phone != null && phone!.isNotEmpty) {
                                await cubit.resendCode(userPhone: phone!);
                                AppSnackBar.success(context, t('CodeSent'));
                              } else {
                                AppSnackBar.error(context, t('NoNumber'));
                              }
                            },

                            style: context.textStyles.styles.linkMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
