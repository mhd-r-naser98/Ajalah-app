import 'package:flutter/material.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/state/login_state.dart';
import 'package:new_ajalah/features/auth/presentation/login/widgets/email_phone_buttons.dart';

class LoginMethodSelector extends StatelessWidget {
  final UserLogin selected;
  final ValueChanged<UserLogin> onChanged;

  const LoginMethodSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return UserRadioButtons(selected: selected, onChanged: onChanged);
  }
}
