import 'package:flutter/material.dart';

class ColorGroup {
  final Color main;
  final Color lighter;
  final Color light;
  final Color dark;
  final Color darker;
  final Color contrast;

  const ColorGroup({
    required this.main,
    required this.lighter,
    required this.light,
    required this.dark,
    required this.darker,
    required this.contrast,
  });
}
