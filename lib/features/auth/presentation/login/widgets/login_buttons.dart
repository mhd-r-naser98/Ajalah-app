import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/config/router.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/app_button.dart';
import 'package:ajalah/core/widgets/app_custom_link.dart';
import 'package:ajalah/features/auth/presentation/login/logic/cubit/login_cubit.dart';
import 'package:ajalah/features/auth/presentation/login/logic/state/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginButtons extends StatelessWidget {
  final FormGroup form;
  final bool submitted;
  final UserLogin selected;

  const LoginButtons({
    super.key,
    required this.form,
    required this.submitted,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return Column(
      children: [
        CustomButton(
          text: t('login'),
          onTap: () {
            if (form.valid) {
              final phone = form.control('phone').value?.phoneNumber as String?;
              final email = form.control('email').value;
              final pass = form.control('password').value;
              final res = selected == UserLogin.email ? email : phone;
              context.read<LoginCubit>().logIn(
                identifier: res ?? '',
                password: pass,
              );
            } else {
              form.markAllAsTouched();
            }
          },
        ),
        const ResponsiveSpacer(size: SpacerSize.large),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    t('dontHaveAccount'),
                    style: context.textStyles.styles.labelMedium,
                  ),
                  const ResponsiveSpacer(
                    axis: Axis.horizontal,
                    size: SpacerSize.xSmall,
                  ),
                  CustomLinkText(
                    text: t("Signup"),
                    onTap: () => context.push(AppRoutes.register),
                    style: context.textStyles.styles.linkMedium,
                  ),
                ],
              ),
            ),
            CustomLinkText(
              text: t('ConfirmAccount'),
              onTap: () => context.push(AppRoutes.confirm),
              style: context.textStyles.styles.linkMedium,
            ),
          ],
        ),
      ],
    );
  }
}
