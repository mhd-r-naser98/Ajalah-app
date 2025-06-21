// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/features/auth/presentation/register/logic/state/register_steps_data.dart';
import 'package:flutter/material.dart';

class RoleRadioButtons extends StatelessWidget {
  final selectedRole;
  final ValueChanged<UserRole> onChanged;

  const RoleRadioButtons({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Row(
      children: [
        _buildRoleOption(UserRole.seller, t('Seller')),
        const ResponsiveSpacer(axis: Axis.horizontal, size: SpacerSize.large),
        _buildRoleOption(UserRole.dealer, t('Dealership')),
      ],
    );
  }

  Widget _buildRoleOption(UserRole role, String label) {
    final bool isSelected = role == selectedRole;
    return GestureDetector(
      onTap: () => onChanged(role),
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Color(0xFF02C0AA) : Colors.grey,
            ),
            const ResponsiveSpacer(
              axis: Axis.horizontal,
              size: SpacerSize.xSmall,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Color(0xFF02C0AA) : Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
