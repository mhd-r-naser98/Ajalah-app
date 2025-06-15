import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:new_ajalah/features/auth/presentation/confirm/logic/cubit/confirm_cubit.dart';
import 'package:new_ajalah/shared/widgets/app_button.dart';
import 'package:new_ajalah/shared/widgets/app_custom_link.dart';
import 'package:new_ajalah/shared/widgets/app_otp_field.dart';
import 'package:new_ajalah/shared/widgets/app_snack_bar.dart';
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

    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          Text(
            'Phone Number Verification',
            style: context.textStyles.styles.headlineMedium,
          ),
          const ResponsiveSpacer(size: SpacerSize.small),
          Text(
            'Enter OTP sent to: ${widget.phone}',
            style: context.textStyles.styles.labelLarge,
          ),
          const ResponsiveSpacer(size: SpacerSize.xLarge),
          ReactiveOtpField(formControlName: 'otp', showErrors: submitted),

          const ResponsiveSpacer(size: SpacerSize.large),
          CustomButton(
            text: 'Continue',
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
                      "Didn’t get the code?",
                      style: context.textStyles.styles.labelMedium,
                    ),
                    const ResponsiveSpacer(
                      axis: Axis.horizontal,
                      size: SpacerSize.xSmall,
                    ),
                    CustomLinkText(
                      text: "Resend",
                      onTap: () async {
                        if (widget.phone.isNotEmpty) {
                          cubit.resendCode(widget.phone);
                          AppSnackBar.success(context, 'Sent');
                        } else {
                          AppSnackBar.error(
                            context,
                            'There is no phone number',
                          );
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
