import 'package:flutter/material.dart';

class CustomLinkText extends StatefulWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onTap;
  final TextStyle? style;
  final bool underlineOnHover;

  const CustomLinkText({
    super.key,
    this.text,
    this.child,
    required this.onTap,
    this.style,
    this.underlineOnHover = true,
  }) : assert(
         (text != null && child == null) || (text == null && child != null),
         'You must provide either text or child, not both.',
       );
  @override
  State<CustomLinkText> createState() => _CustomLinkTextState();
}

class _CustomLinkTextState extends State<CustomLinkText> {
  bool _isHovered = false;
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    final baseStyle = widget.style ?? Theme.of(context).textTheme.labelMedium!;
    final showUnderline = widget.underlineOnHover || (_isHovered || _isPressed);
    Widget content;

    if (widget.child != null) {
      content = widget.underlineOnHover
          ? DefaultTextStyle.merge(
              style: showUnderline
                  ? baseStyle.copyWith(decoration: TextDecoration.underline)
                  : baseStyle,
              child: widget.child!,
            )
          : widget.child!;
    } else {
      content = AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        style: showUnderline
            ? baseStyle.copyWith(decoration: TextDecoration.underline)
            : baseStyle,
        child: Text(widget.text!),
      );
    }
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: widget.child != null
            ? content
            : AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                style: baseStyle,
                child: content,
              ),
      ),
    );
  }
}
