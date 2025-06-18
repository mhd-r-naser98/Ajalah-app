import 'package:flutter/material.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/shared/widgets/app_custom_link.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onTap;
  const SectionTitle({
    super.key,
    required this.title,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textStyles.styles.titleSmall),

        CustomLinkText(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('View more deals'),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_sharp,
                size: 16,
                color: context.colors.text,
              ),
            ],
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
