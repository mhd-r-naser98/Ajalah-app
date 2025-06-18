import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  final String? tagName;
  final double? fontSize;
  final Color? textColor;
  final Color? tagColor;

  const TagWidget({
    super.key,
    this.tagName,
    this.tagColor = const Color(0xFFF2F2F7),
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        color: tagColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4,
        children: [
          Text(
            tagName ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor ?? const Color(0xFF2A3950),
              fontSize: fontSize ?? 14,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}
