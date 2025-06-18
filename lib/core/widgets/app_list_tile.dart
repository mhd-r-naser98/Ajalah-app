import 'package:flutter/material.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';

class AppListTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget? leading;

  const AppListTile({super.key, required this.title, this.onTap, this.leading});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(context.radius.lg),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: colors.box,
            borderRadius: BorderRadius.circular(context.radius.lg),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: ListTile(
            leading: leading,
            title: Text(title),
            trailing: Icon(Icons.chevron_right_rounded, color: colors.text),
          ),
        ),
      ),
    );
  }
}
