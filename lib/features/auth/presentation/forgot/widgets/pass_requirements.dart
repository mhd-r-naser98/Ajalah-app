import 'package:flutter/material.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/extensions/pass_extension.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check,
              color: password.isStrong()
                  ? context.colors.success.main
                  : context.colors.grey[600]!,
              size: 18,
            ),
            const ResponsiveSpacer(
              axis: Axis.horizontal,
              size: SpacerSize.small,
            ),

            Text(
              'Password Strength: ',
              style: context.textStyles.styles.labelMedium.copyWith(
                color: context.colors.grey[600]!,
              ),
            ),
            Text(
              password.strengthLabel,
              style: context.textStyles.styles.labelMedium.copyWith(
                color: password.strengthColor,
              ),
            ),
          ],
        ),
        const ResponsiveSpacer(size: SpacerSize.medium),

        _buildRequirement(
          context,
          password.hasMinLength,
          'At least 8 characters',
        ),
        const ResponsiveSpacer(size: SpacerSize.medium),

        _buildRequirement(
          context,
          password.hasSymbol,
          'Contains a number or symbol',
        ),
        const ResponsiveSpacer(size: SpacerSize.medium),

        _buildRequirement(
          context,
          password.isNotCommon,
          'Cannot be "password" or "123"',
        ),
      ],
    );
  }

  Widget _buildRequirement(BuildContext context, bool met, String text) {
    return Row(
      children: [
        Icon(
          Icons.check,
          color: met ? context.colors.success.main : context.colors.grey[600]!,
          size: 18,
        ),
        const ResponsiveSpacer(axis: Axis.horizontal, size: SpacerSize.small),
        Text(
          text,
          style: context.textStyles.styles.labelMedium.copyWith(
            color: context.colors.grey[600]!,
          ),
        ),
      ],
    );
  }
}
