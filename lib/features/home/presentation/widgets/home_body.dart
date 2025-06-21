import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/app_loading.dart';
import 'package:ajalah/core/widgets/responsive_scroll_view.dart';
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
    return Builder(
      builder: (context) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: LoadingWidget());
            } else {
              return const ResponsiveScrollView(
                isPaddine: false,
                child: _HomeContent(),
              );
            }
          },
        );
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
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
                  const CarNewDeals(),
                  const ResponsiveSpacer(size: SpacerSize.large),
                  const CarRentDeals(),
                  const ResponsiveSpacer(size: SpacerSize.large),
                  const CarImportDeals(),
                  const ResponsiveSpacer(size: SpacerSize.large),
                  const SellYourCarBanner(),
                  const ResponsiveSpacer(size: SpacerSize.large),
                  const CarListSection(),
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
