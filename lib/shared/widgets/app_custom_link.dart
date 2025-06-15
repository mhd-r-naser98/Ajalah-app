import 'package:flutter/material.dart';

class CustomLinkText extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? style;

  const CustomLinkText({
    super.key,
    required this.text,
    required this.onTap,
    this.style,
  });

  @override
  State<CustomLinkText> createState() => _CustomLinkTextState();
}

class _CustomLinkTextState extends State<CustomLinkText> {
  bool _isHovered = false;
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    final baseStyle = widget.style ?? Theme.of(context).textTheme.labelMedium!;
    final showUnderline = _isHovered || _isPressed;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          style: showUnderline
              ? baseStyle.copyWith(decoration: TextDecoration.underline)
              : baseStyle,
          child: Text(widget.text),
        ),
      ),
    );
  }
}
