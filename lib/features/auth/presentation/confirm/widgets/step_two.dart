import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/theme/extensions/theme_extensions.dart';
import '../../../../../core/utils/responsive_spacer.dart';
import '../../../../../features/auth/presentation/confirm/logic/cubit/confirm_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_custom_link.dart';
import '../../../../../core/widgets/app_otp_field.dart';
import '../../../../../core/widgets/app_snack_bar.dart';
import 'package:reactive_forms/reactive_forms.dart';

class StepTwo extends StatefulWidget {
  final String phone;
  const StepTwo({super.key, required this.phone});

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  late FormGroup form;
  var submitted = false;
  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'otp': FormControl<String>(validators: [Validators.required]),
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConfirmCubit>();
    final t = context.t;

    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          Text(
            t('PhoneVerification'),
            style: context.textStyles.styles.headlineMedium,
          ),
          const ResponsiveSpacer(size: SpacerSize.small),
          Text(
            '${t('EnterOTP')} ${widget.phone}',
            style: context.textStyles.styles.labelLarge,
          ),
          const ResponsiveSpacer(size: SpacerSize.xLarge),
          ReactiveOtpField(formControlName: 'otp', showErrors: submitted),

          const ResponsiveSpacer(size: SpacerSize.large),
          CustomButton(
            text: t('Continue'),
            onTap: () {
              setState(() {
                submitted = true;
              });

              if (form.valid) {
                final otp = form.control('otp').value;
                cubit.submitCode(widget.phone, otp);
              } else {
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
                      t('DidnCode'),
                      style: context.textStyles.styles.labelMedium,
                    ),
                    const ResponsiveSpacer(
                      axis: Axis.horizontal,
                      size: SpacerSize.xSmall,
                    ),
                    CustomLinkText(
                      text: t("Resend"),
                      onTap: () async {
                        if (widget.phone.isNotEmpty) {
                          cubit.resendCode(widget.phone);
                          AppSnackBar.success(
                            context,
                            t('SuccessfullyCompleted'),
                          );
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
    );
  }
}
