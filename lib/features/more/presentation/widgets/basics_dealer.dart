import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/config/router.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/app_expended_title.dart';
import 'package:ajalah/core/widgets/app_list_tile.dart';
import 'package:ajalah/features/auth/presentation/login/logic/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BasicsDealer extends StatelessWidget {
  const BasicsDealer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final textStyle = context.textStyles.styles;

    return BlocProvider<UserCubit>(
      create: (_) => UserCubit(),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(t('Basics'), style: textStyle.titleLarge),
          const ResponsiveSpacer(size: SpacerSize.xSmall),
          AppExpandableTile(
            title: t('dashboard'),
            children: [
              AppListTile(
                title: t('BasicInfo'),
                onTap: () => context.push(AppRoutes.dashboard),
              ),
              AppListTile(
                title: t('MyCars'),
                onTap: () => context.push(AppRoutes.dashboard),
              ),
              AppListTile(
                title: t('Messages'),
                onTap: () => context.push(AppRoutes.dashboard),
              ),
              AppListTile(
                title: t('Reviews'),
                onTap: () => context.push(AppRoutes.dashboard),
              ),
              AppListTile(
                title: t('SellCar'),
                onTap: () => context.push(AppRoutes.sell),
              ),

              AppListTile(
                title: t('savedCars'),
                onTap: () => context.push(AppRoutes.savedCars),
              ),
            ],
          ),
          AppExpandableTile(
            title: 'Cars pages',
            children: [
              AppListTile(
                title: t('newCars'),
                onTap: () => context.push(AppRoutes.newCars),
              ),

              AppListTile(
                title: t('UsedCars'),
                onTap: () => context.push(AppRoutes.newCars),
              ),
              AppListTile(
                title: t('ImportedCars'),
                onTap: () => context.push(AppRoutes.newCars),
              ),
              AppListTile(
                title: t('RentCars'),
                onTap: () => context.push(AppRoutes.newCars),
              ),
              // AppListTile(
              //   title: t('Compare'),
              //   onTap: () => context.push(AppRoutes.compare),
              // ),
            ],
          ),
          AppExpandableTile(
            title: 'Global',
            children: [
              AppListTile(
                title: t('about'),
                onTap: () => context.push(AppRoutes.about),
              ),
              AppListTile(
                title: t('ContactUs'),
                onTap: () => context.push(AppRoutes.about),
              ),
              AppListTile(
                title: t('FAQ'),
                onTap: () => context.push(AppRoutes.about),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
