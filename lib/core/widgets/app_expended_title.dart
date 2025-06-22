import 'package:flutter/material.dart';
import 'package:ajalah/app/theme/extensions/theme_extensions.dart';

class AppExpandableTile extends StatefulWidget {
  final String title;
  final Widget? leading;
  final List<Widget> children;

  const AppExpandableTile({
    super.key,
    required this.title,
    required this.children,
    this.leading,
  });

  @override
  State<AppExpandableTile> createState() => _AppExpandableTileState();
}

class _AppExpandableTileState extends State<AppExpandableTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = context.radius.lg;
    final textStyle = context.textStyles.styles.bodyLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () => setState(() => _expanded = !_expanded),
          child: Ink(
            decoration: BoxDecoration(
              color: colors.box,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: ListTile(
              leading: widget.leading,
              title: Text(widget.title, style: textStyle),
              trailing: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                color: _expanded ? colors.primary.main : colors.text,
              ),
            ),
          ),
        ),
        if (_expanded)
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
            child: Column(spacing: 10, children: widget.children),
          ),
      ],
    );
  }
}
