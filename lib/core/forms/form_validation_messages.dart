import 'package:flutter/material.dart';
import '../../app/theme/extensions/theme_extensions.dart';
import 'package:reactive_forms/reactive_forms.dart';

final passwordComplexityValidator = Validators.delegate((
  AbstractControl<dynamic> control,
) {
  final value = control.value?.toString() ?? '';

  final hasUppercase = value.contains(RegExp(r'[A-Z]'));
  final hasLowercase = value.contains(RegExp(r'[a-z]'));
  final hasDigit = value.contains(RegExp(r'[0-9]'));
  final hasSpecialChar = value.contains(
    RegExp(r'[!@#\$&*~%^()\-\[\]{}<>\?\/\\|_=+.,:;]'),
  );

  if (!hasUppercase || !hasLowercase || !hasDigit || !hasSpecialChar) {
    return {'passwordComplexity': true};
  }

  return null;
});

String getErrorMessage(BuildContext context, AbstractControl<dynamic> control) {
  final t = context.t;

  if (control.errors.isEmpty) return '';

  if (control.hasError(ValidationMessage.required)) {
    return t('required');
  } else if (control.hasError(ValidationMessage.email)) {
    return t('invalidEmail');
  } else if (control.errors.containsKey('minLength')) {
    return t('shortPassword');
  } else if (control.hasError(ValidationMessage.pattern)) {
    return t('InvalidFormat');
  } else if (control.hasError('mustMatch')) {
    return t('mustMatch');
  } else if (control.hasError('passwordComplexity')) {
    return t('passwordComplexity');
  }

  final firstError = control.errors.entries.first;
  return firstError.value.toString();
}
