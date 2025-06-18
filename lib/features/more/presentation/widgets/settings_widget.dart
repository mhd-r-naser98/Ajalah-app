// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ajalah/app/localization/logic/cubit/locale_cubit.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/app/theme/logic/cubit/theme_cubit.dart';
import 'package:new_ajalah/core/config/router.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/cubit/user_cubit.dart';
import 'package:new_ajalah/core/widgets/app_card_button.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  bool isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final textStyle = context.textStyles.styles;
    final theme = context.read<ThemeCubit>();
    final local = context.read<LocaleCubit>();

    return BlocProvider<UserCubit>(
      create: (_) => UserCubit(),

      child: Builder(
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t('Settings'), style: textStyle.titleLarge),
              const ResponsiveSpacer(size: SpacerSize.medium),
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 3 / 1,
                children: [
                  AppCardButton(
                    label: t('ThemeMode'),
                    icon: Icons.change_circle,
                    onTap: () => theme.toggleTheme(),
                  ),
                  AppCardButton(
                    label: t('Language'),
                    icon: Icons.language,
                    onTap: () => local.toggleLocale(),
                  ),

                  AppCardButton(
                    label: t('EditProfile'),
                    icon: Icons.edit,
                    onTap: () => context.push(AppRoutes.editProfile),
                  ),
                  AppCardButton(
                    label: t('SignOut'),
                    icon: Icons.logout,
                    isLoading: isLoggingOut,

                    onTap: () async {
                      setState(() => isLoggingOut = true);

                      final success = await context.read<UserCubit>().logout();
                      if (success) {
                        context.go(AppRoutes.login);
                      } else {
                        setState(() => isLoggingOut = false);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t('LogoutFailed'))),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
