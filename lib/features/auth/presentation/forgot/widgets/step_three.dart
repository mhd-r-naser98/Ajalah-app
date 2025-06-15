import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/forms/app_form_field_config.dart';
import 'package:new_ajalah/core/forms/form_validation_messages.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:new_ajalah/features/auth/presentation/forgot/logic/cubit/forgot_cubit.dart';
import 'package:new_ajalah/features/auth/presentation/forgot/widgets/pass_requirements.dart';
import 'package:new_ajalah/shared/widgets/app_button.dart';
import 'package:new_ajalah/shared/widgets/app_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class StepThree extends StatefulWidget {
  final String phone;
  final String code;
  const StepThree({super.key, required this.phone, required this.code});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  late FormGroup form;
  var submitted = false;
  final passwordNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    form = FormGroup(
      {
        'password': FormControl<String>(
          validators: [
            Validators.required,
            Validators.minLength(8),
            passwordComplexityValidator,
          ],
        ),
        'confirmPassword': FormControl<String>(
          validators: [Validators.required],
        ),
      },
      validators: [Validators.mustMatch('password', 'confirmPassword')],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotCubit>();

    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reset Password',
            style: context.textStyles.styles.headlineMedium,
          ),

          const ResponsiveSpacer(size: SpacerSize.medium),
          AppTextField(
            config: AppFormFieldConfig(
              name: 'password',
              label: 'Password*',
              obscureText: true,
              hintText: '************',
              onChanged: (value) {
                passwordNotifier.value = value ?? '';
              },
            ),
            showErrors: submitted,
          ),

          ValueListenableBuilder<String>(
            valueListenable: passwordNotifier,
            builder: (context, password, _) {
              return Column(
                children: [PasswordRequirements(password: password)],
              );
            },
          ),
          const ResponsiveSpacer(size: SpacerSize.large),
          AppTextField(
            config: const AppFormFieldConfig(
              name: 'confirmPassword',
              label: 'Confirm Password*',
              obscureText: true,
              hintText: '************',
            ),
            showErrors: submitted,
          ),

          const ResponsiveSpacer(size: SpacerSize.medium),
          CustomButton(
            text: 'Reset Password',
            onTap: () {
              setState(() {
                submitted = true;
              });

              if (form.valid) {
                final password = form.control('password').value;
                cubit.submitPsssword(widget.phone, password, widget.code);
              } else {
                form.markAllAsTouched();
              }
            },
          ),
        ],
      ),
    );
  }
}
