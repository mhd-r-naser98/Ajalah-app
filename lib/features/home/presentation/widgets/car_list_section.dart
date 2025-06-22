// ignore_for_file: unnecessary_null_comparison

import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/config/router.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/car_card.dart';
import 'package:ajalah/core/widgets/section_title.dart';
import 'package:ajalah/shared/models/car_card_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarListSection extends StatelessWidget {
  final List<CarCardItem> cars;
  const CarListSection({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    final filteredItems = cars.where((e) => e != null).toList();
    final itemCount = filteredItems.length < 4 ? filteredItems.length : 4;
    final t = context.t;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          actionText: t('moreDeals'),
          onTap: () {
            context.push(AppRoutes.used);
          },
          title: t('findYourCar'),
        ),
        const ResponsiveSpacer(size: SpacerSize.medium),
        Column(
          children: List.generate(itemCount, (index) {
            final carItem = filteredItems[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CarCard(
                width: double.infinity,
                height: 240,
                item: carItem,
                imageUrls: carItem.gallery,
              ),
            );
          }),
        ),
      ],
    );
  }
}
