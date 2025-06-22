import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/app_loading.dart';
import 'package:ajalah/core/widgets/app_snack_bar.dart';
import 'package:ajalah/core/widgets/responsive_scroll_view.dart';
import 'package:ajalah/features/home/presentation/widgets/brands_section.dart';
import 'package:ajalah/features/home/presentation/widgets/car_import_deals.dart';
import 'package:ajalah/features/home/presentation/widgets/car_list_section.dart';
import 'package:ajalah/features/home/presentation/widgets/car_new_section.dart';
import 'package:ajalah/features/home/presentation/widgets/car_rent_deals.dart';
import 'package:ajalah/features/home/presentation/widgets/hero_header.dart';
import 'package:ajalah/features/home/presentation/widgets/search_form.dart';
import 'package:ajalah/features/home/presentation/widgets/sell_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: LoadingWidget());
          } else {
            return ResponsiveScrollView(
              onRefresh: () => context.read<HomeCubit>().fetchHomeData(),
              isPaddine: false,
              child: const _HomeContent(),
            );
          }
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeCubit>();
    final state = context.watch<HomeCubit>().state;
    if (state is HomeFailure) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppSnackBar.error(context, state.error);
      });
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            HeroHeader(),
            const ResponsiveSpacer(size: SpacerSize.xLarge),
            const ResponsiveSpacer(size: SpacerSize.xLarge),
            const ResponsiveSpacer(size: SpacerSize.large),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CarNewDeals(cars: cubit.newCars!),
                  const ResponsiveSpacer(size: SpacerSize.large),
                  CarRentDeals(cars: cubit.newCars!),
                  const ResponsiveSpacer(size: SpacerSize.large),
                  CarImportDeals(cars: cubit.importCars!),
                  const ResponsiveSpacer(size: SpacerSize.large),
                  const SellYourCarBanner(),
                  const ResponsiveSpacer(size: SpacerSize.large),
                  CarListSection(cars: cubit.popularCars!),
                  const ResponsiveSpacer(size: SpacerSize.large),
                  BrandsSection(brands: cubit.brands!),
                  const ResponsiveSpacer(size: SpacerSize.large),
                ],
              ),
            ),
          ],
        ),
        Positioned(top: 560, left: 16, right: 16, child: SearchForm()),
      ],
    );
  }
}
