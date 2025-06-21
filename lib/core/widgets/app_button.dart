import 'package:flutter/material.dart';
import '../../app/theme/extensions/theme_extensions.dart';
import '../../core/utils/size_config.dart';

class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton({super.key, this.text = 'Next', this.onTap});
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: context.colors.primary.main,
          borderRadius: BorderRadius.circular(context.radius.md),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    super.key,
    required this.text,
    this.onTap,
    this.iconData,
    this.color,
  });
  final String text;
  final IconData? iconData;
  final VoidCallback? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF707070)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: color),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final double? height;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    this.text = 'Next',
    this.onTap,
    this.height,
    this.textStyle,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  double get _scale => _isPressed
      ? 1.01
      : _isHovered
      ? 1.02
      : 1.0;

  List<BoxShadow> get _boxShadow {
    if (_isPressed) {
      return [
        BoxShadow(
          color: context.colors.primary.light,
          offset: const Offset(0, 2),
          blurRadius: 2,
        ),
      ];
    } else if (_isHovered) {
      return [
        BoxShadow(
          color: context.colors.primary.lighter,
          offset: const Offset(0, 2),
          blurRadius: 3,
        ),
      ];
    } else {
      return [BoxShadow()];
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color baseColor = context.colors.primary.main;
    final Color hoverColor = context.colors.primary.dark;
    final backgroundColor = (_isHovered || _isPressed) ? hoverColor : baseColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _isPressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            height: widget.height ?? 50,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(context.radius.md),
              boxShadow: _boxShadow,
            ),
            child: Center(
              child: Text(
                widget.text,
                style:
                    widget.textStyle ??
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
