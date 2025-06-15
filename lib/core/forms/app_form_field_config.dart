import 'package:flutter/material.dart';

class AppFormFieldConfig {
  final String name;
  final String label;
  final String type;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final int? maxLines;
  final String? initialCountryCode;
  final InputBorder? border;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final bool filled;
  final void Function(String?)? onChanged;

  const AppFormFieldConfig({
    required this.name,
    required this.label,
    this.onChanged,
    this.type = 'string',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.maxLines = 1,
    this.border,
    this.labelStyle,
    this.fillColor,
    this.filled = false,
    this.initialCountryCode,
  });
}
