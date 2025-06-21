// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../../../../../app/theme/extensions/theme_extensions.dart';
import '../../../../../core/utils/responsive_spacer.dart';
import '../../../../../features/auth/presentation/login/logic/state/login_state.dart';

class UserRadioButtons extends StatelessWidget {
  final selected;
  final ValueChanged<UserLogin> onChanged;

  const UserRadioButtons({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return Row(
      children: [
        _buildRoleOption(UserLogin.phone, t('phone')),
        const ResponsiveSpacer(axis: Axis.horizontal, size: SpacerSize.large),
        _buildRoleOption(UserLogin.email, t('email')),
      ],
    );
  }

  Widget _buildRoleOption(UserLogin role, String label) {
    final bool isSelected = role == selected;
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
