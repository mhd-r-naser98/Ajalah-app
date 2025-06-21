// ignore: file_names
import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/config/router.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/app_list_tile.dart';
import 'package:ajalah/features/auth/presentation/login/logic/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BasicsSeller extends StatelessWidget {
  const BasicsSeller({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final textStyle = context.textStyles.styles;

    return BlocProvider<UserCubit>(
      create: (_) => UserCubit(),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${t('Basics')} Seller', style: textStyle.titleLarge),
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
        ],
      ),
    );
  }
}
