import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/app/localization/logic/cubit/locale_cubit.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ajalah/app/theme/logic/cubit/theme_cubit.dart';
import 'package:new_ajalah/core/di/service_locator.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:new_ajalah/features/auth/data/auth_repo.dart';
import 'package:new_ajalah/shared/widgets/app_card_button.dart';
import 'package:new_ajalah/shared/widgets/app_list_tile.dart';
import 'package:new_ajalah/shared/widgets/responsive_scroll_view.dart';
// ignore: library_prefixes
import '../../../core/config/router.dart' as AppRoutes;

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final radius = context.radius;
    final theme = context.read<ThemeCubit>();
    final local = context.read<LocaleCubit>();
    final authRepo = locator<AuthRepository>();

    final textStyle = context.textStyles.styles;
    Future<void> handleRefresh() async {
      debugPrint("Refresh started");
      await Future.delayed(Duration(seconds: 2));
      debugPrint("Refresh ended");
    }

    return Scaffold(
      body: ResponsiveScrollView(
        onRefresh: handleRefresh,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radius.lg),
                  child: Image.asset(
                    'assets/imgs/dealership_banner.webp',
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -35,
                  child: Image.asset(
                    'assets/imgs/dealership_icon.webp',
                    width: 74,
                    height: 74,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const ResponsiveSpacer(size: SpacerSize.xLarge),
            Center(
              child: Text('Dealership name', style: textStyle.headlineSmall),
            ),
            const ResponsiveSpacer(size: SpacerSize.medium),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basics Section
                Text(t('Basics'), style: textStyle.titleLarge),
                const ResponsiveSpacer(size: SpacerSize.medium),
                AppListTile(
                  title: t('dashboard'),
                  onTap: () => context.push(AppRoutes.dashboard),
                ),
                AppListTile(
                  title: t('orders'),
                  onTap: () => context.push(AppRoutes.orders),
                ),
                AppListTile(
                  title: t('savedCars'),
                  onTap: () => context.push(AppRoutes.savedCars),
                ),
                AppListTile(
                  title: t('newCars'),
                  onTap: () => context.push(AppRoutes.newCars),
                ),
                AppListTile(
                  title: t('Compare'),
                  onTap: () => context.push(AppRoutes.compare),
                ),
                AppListTile(
                  title: t('about'),
                  onTap: () => context.push(AppRoutes.about),
                ),
                const ResponsiveSpacer(size: SpacerSize.large),

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
                      onTap: () async {
                        await authRepo.logout();
                        // ignore: use_build_context_synchronously
                        context.push(AppRoutes.login);
                      },
                    ),
                  ],
                ),
                const ResponsiveSpacer(size: SpacerSize.large),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
