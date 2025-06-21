import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../core/forms/form_validation_messages.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../app/theme/extensions/theme_extensions.dart';

class ReactiveOtpField extends StatelessWidget {
  final String formControlName;
  final bool obscureText;
  final bool autoFocus;
  final bool showErrors;

  const ReactiveOtpField({
    super.key,
    required this.formControlName,
    this.obscureText = false,
    this.autoFocus = true,
    this.showErrors = false,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ReactiveFormField<String, String>(
        formControlName: formControlName,
        builder: (field) {
          final hasError =
              showErrors && field.control.invalid && field.control.touched;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OtpTextField(
                numberOfFields: 4,
                showFieldAsBox: true,
                fieldWidth: 72,
                borderRadius: BorderRadius.circular(context.radius.lg),
                borderColor: hasError
                    ? context.colors.error.main
                    : context.colors.grey[300]!,
                focusedBorderColor: context.colors.primary.main,
                filled: true,
                obscureText: obscureText,
                autoFocus: autoFocus,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: context.textStyles.styles.headlineMedium,
                onCodeChanged: (code) {
                  debugPrint('OTP changed: $code');
                  field.control.updateValue(code);

                  if (code.length == 4 && field.control.value != code) {
                    field.didChange(code);
                  }
                },
                onSubmit: (code) {
                  field.didChange(code);
                },
              ),
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Text(
                  hasError ? getErrorMessage(context, field.control) : "",
                  style: TextStyle(
                    color: context.colors.error.main,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
