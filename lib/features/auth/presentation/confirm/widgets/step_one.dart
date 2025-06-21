import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../../../app/theme/extensions/theme_extensions.dart';
import '../../../../../core/forms/app_form_field_config.dart';
import '../../../../../core/utils/responsive_spacer.dart';
import '../../../../../features/auth/presentation/confirm/logic/cubit/confirm_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_phone_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class StepOne extends StatefulWidget {
  const StepOne({super.key});

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  late FormGroup form;
  var submitted = false;
  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'phone': FormControl<PhoneNumber>(validators: [Validators.required]),
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          Text(
            t('ConfirmAccount'),
            style: context.textStyles.styles.headlineMedium,
          ),
          AppPhoneField(
            config: AppFormFieldConfig(
              name: 'phone',
              label: t('phone'),
              hintText: '',
              forceLTR: true,

              keyboardType: TextInputType.phone,
            ),
            showErrors: submitted,
          ),
          const ResponsiveSpacer(size: SpacerSize.medium),
          CustomButton(
            text: t('SendCode'),
            onTap: () {
              setState(() {
                submitted = true;
              });

              if (form.valid) {
                final phone = form.control('phone').value.phoneNumber;
                context.read<ConfirmCubit>().submitPhone(phone);
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
