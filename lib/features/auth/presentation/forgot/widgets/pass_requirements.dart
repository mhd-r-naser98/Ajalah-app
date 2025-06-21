import 'package:flutter/material.dart';
import '../../../../../app/theme/extensions/theme_extensions.dart';
import '../../../../../core/extensions/pass_extension.dart';
import '../../../../../core/utils/responsive_spacer.dart';

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
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
              '${t('PasswordStrength')}: ',
              style: context.textStyles.styles.labelMedium.copyWith(
                color: context.colors.grey[600]!,
              ),
            ),
            Text(
              t(password.strengthLabel),
              style: context.textStyles.styles.labelMedium.copyWith(
                color: password.strengthColor,
              ),
            ),
          ],
        ),
        const ResponsiveSpacer(size: SpacerSize.medium),

        _buildRequirement(context, password.hasMinLength, t('shortPassword')),
        const ResponsiveSpacer(size: SpacerSize.medium),

        _buildRequirement(context, password.hasSymbol, t('passwordComplexity')),
        const ResponsiveSpacer(size: SpacerSize.medium),

        _buildRequirement(context, password.isNotCommon, t('PassBe')),
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
