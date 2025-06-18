import '../app_shared_colors.dart';
import 'package:flutter/material.dart';
import '../groups/color_group.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final ColorGroup primary;
  final ColorGroup secondary;
  final ColorGroup success;
  final ColorGroup info;
  final ColorGroup warning;
  final ColorGroup error;
  final Map<int, Color> grey;

  final Color background;
  final Color paper;
  final Color neutral;
  final Color box;
  final Color text;
  final Color input;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.info,
    required this.warning,
    required this.error,
    required this.grey,
    required this.background,
    required this.paper,
    required this.neutral,
    required this.box,
    required this.text,
    required this.input,
  });

  @override
  AppColors copyWith({
    ColorGroup? primary,
    ColorGroup? secondary,
    ColorGroup? success,
    ColorGroup? info,
    ColorGroup? warning,
    ColorGroup? error,
    Map<int, Color>? grey,
    Color? background,
    Color? paper,
    Color? neutral,
    Color? box,
    Color? text,
    Color? input,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      grey: grey ?? this.grey,
      background: background ?? this.background,
      paper: paper ?? this.paper,
      neutral: neutral ?? this.neutral,
      box: box ?? this.box,
      text: text ?? this.text,
      input: input ?? this.input,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) => this;

  static const light = AppColors(
    primary: SharedColors.primary,
    secondary: SharedColors.secondary,
    success: SharedColors.success,
    info: SharedColors.info,
    warning: SharedColors.info,
    error: SharedColors.error,
    grey: SharedColors.grey,
    background: Color(0xFFFCFCFC),
    paper: Colors.white,
    neutral: Color(0xFFF2F2F7),
    box: Colors.white,
    text: Color(0xFF2A3950),
    input: Colors.red,
  );

  static const dark = AppColors(
    primary: SharedColors.primary,
    secondary: SharedColors.secondary,
    success: SharedColors.success,
    info: SharedColors.info,
    warning: SharedColors.info,
    error: SharedColors.error,
    grey: SharedColors.grey,
    background: Color(0xFF2A3950),
    paper: Color(0xFF2A3950),
    neutral: Color.fromRGBO(145, 158, 171, 0.12),
    box: Color(0xFF233043),
    text: Colors.white,
    input: Colors.red,
  );
}
