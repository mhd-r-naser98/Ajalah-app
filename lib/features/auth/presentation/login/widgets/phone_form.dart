import 'package:ajalah/core/forms/app_form_field_config.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/app_phone_field.dart';
import 'package:ajalah/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class PhoneForm extends StatelessWidget {
  const PhoneForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppPhoneField(
          config: AppFormFieldConfig(
            name: 'phone',
            label: 'Phone*',
            hintText: '',
            keyboardType: TextInputType.phone,
          ),
          showErrors: true,
        ),
        ResponsiveSpacer(size: SpacerSize.xSmall),
        AppTextField(
          config: AppFormFieldConfig(
            name: 'password',
            label: 'Password*',
            obscureText: true,
            hintText: '************',
          ),
          showErrors: true,
        ),
        ResponsiveSpacer(size: SpacerSize.small),
      ],
    );
  }
}
