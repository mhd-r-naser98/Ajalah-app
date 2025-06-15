import 'package:flutter/material.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';

class AppCardButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const AppCardButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = context.radius;

    return SizedBox(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius.lg),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: colors.box,
            borderRadius: BorderRadius.circular(radius.lg),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const ResponsiveSpacer(
                axis: Axis.horizontal,
                size: SpacerSize.small,
              ),
              Icon(icon, color: colors.primary.main),
            ],
          ),
        ),
      ),
    );
  }
}
