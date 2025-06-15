import 'package:flutter/material.dart';

extension PasswordStrengthExtension on String {
  bool isStrong() {
    return strengthScore == 3;
  }

  int get strengthScore {
    int score = 0;

    if (length >= 8) score++;
    if (contains(RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]'))) score++;
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
  bool get hasSymbol => contains(RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]'));
  bool get isNotCommon =>
      !(toLowerCase().contains('password') || contains('123'));
}
