import 'package:flutter/material.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';

class AppSnackBar {
  static void success(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    _show(context, message, Colors.green, Icons.check_circle, duration);
  }

  static void error(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    _show(context, message, Colors.red, Icons.error, duration);
  }

  static void warning(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    _show(
      context,
      message,
      Colors.orange,
      Icons.warning_amber_rounded,
      duration,
    );
  }

  static void _show(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
    Duration? duration,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 3),
        backgroundColor: context.colors.box,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        content: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
