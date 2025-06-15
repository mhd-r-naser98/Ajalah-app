import 'package:flutter/material.dart';

enum SpacerSize { xSmall, small, medium, large, xLarge }

class ResponsiveSpacer extends StatelessWidget {
  final SpacerSize size;
  final Axis axis;
  final bool considerOrientation;
  final bool considerScreenSize;
  final Duration duration;

  const ResponsiveSpacer({
    super.key,
    this.size = SpacerSize.medium,
    this.axis = Axis.vertical,
    this.considerOrientation = true,
    this.considerScreenSize = true,
    this.duration = const Duration(milliseconds: 300),
  });

  static const Map<SpacerSize, double> _baseValues = {
    SpacerSize.xSmall: 4.0,
    SpacerSize.small: 8.0,
    SpacerSize.medium: 16.0,
    SpacerSize.large: 32.0,
    SpacerSize.xLarge: 48.0,
  };

  double _scaleFactor(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < 320) return 0.7;
    if (shortestSide < 480) return 0.85;
    if (shortestSide < 720) return 1.0;
    if (shortestSide < 1080) return 1.2;
    return 1.5;
  }

  double _calculateDimension(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final base = _baseValues[size] ?? 16.0;

    double orientationFactor = considerOrientation
        ? (isPortrait ? 1.0 : 0.5)
        : 1.0;

    double screenFactor = considerScreenSize ? _scaleFactor(context) : 1.0;

    return base * orientationFactor * screenFactor;
  }

  @override
  Widget build(BuildContext context) {
    final dimension = _calculateDimension(context);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: dimension),
      duration: duration,
      builder: (context, value, child) {
        return axis == Axis.vertical
            ? SizedBox(height: value)
            : SizedBox(width: value);
      },
    );
  }
}
