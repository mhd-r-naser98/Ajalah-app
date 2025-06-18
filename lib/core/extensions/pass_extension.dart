import 'package:flutter/material.dart';

extension PasswordStrengthExtension on String {
  bool get isComplexPassword {
    final password = this;

    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialChar = RegExp(
      r'[!@#\$%^&*(),.?":{}|<>]',
    ).hasMatch(password);

    return hasUppercase && hasLowercase && hasNumber && hasSpecialChar;
  }

  bool isStrong() {
    return strengthScore == 3;
  }

  int get strengthScore {
    int score = 0;

    if (length >= 8) score++;
    if (isComplexPassword) score++;
    if (!(toLowerCase().contains('password') || contains('123'))) score++;

    return score;
  }

  String get strengthLabel {
    switch (strengthScore) {
      case 3:
        return 'Strong';
      case 2:
        return 'Medium';
      default:
        return 'Weak';
    }
  }

  Color get strengthColor {
    switch (strengthScore) {
      case 3:
        return Colors.green;
      case 2:
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  bool get hasMinLength => length >= 8;
  bool get hasSymbol => isComplexPassword;
  bool get isNotCommon =>
      !(toLowerCase().contains('password') || contains('123'));
}
