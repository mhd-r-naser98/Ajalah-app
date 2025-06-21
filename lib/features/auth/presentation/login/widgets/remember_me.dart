import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/config/router.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/app_custom_link.dart';
import 'package:ajalah/features/auth/presentation/login/logic/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RememberMeCheckbox extends StatelessWidget {
  const RememberMeCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              SizedBox(
                width: 26,
                height: 26,
                child: Checkbox(
                  value: context.read<LoginCubit>().rememberMe,
                  onChanged: (value) =>
                      context.read<LoginCubit>().toggleRememberMe(value!),
                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return context.colors.primary.main;
                    }
                    return Colors.transparent;
                  }),
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const ResponsiveSpacer(
                axis: Axis.horizontal,
                size: SpacerSize.xSmall,
              ),
              InkWell(
                onTap: () {
                  context.read<LoginCubit>().toggleRememberMe(
                    !context.read<LoginCubit>().rememberMe,
                  );
                },
                child: Text(
                  t("RememberMe"),
                  style: context.textStyles.styles.labelMedium,
                ),
              ),
            ],
          ),
        ),
        CustomLinkText(
          text: t('ForgotPassword'),
          onTap: () => context.push(AppRoutes.forgot),
          style: context.textStyles.styles.labelMedium,
        ),
      ],
    );
  }
}
