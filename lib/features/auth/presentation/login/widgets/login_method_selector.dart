import 'package:ajalah/features/auth/presentation/login/logic/state/login_state.dart';
import 'package:ajalah/features/auth/presentation/login/widgets/email_phone_buttons.dart';
import 'package:flutter/material.dart';

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
