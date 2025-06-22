// ignore_for_file: unnecessary_null_comparison

import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/config/router.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/car_card.dart';
import 'package:ajalah/core/widgets/section_title.dart';
import 'package:ajalah/shared/models/car_card_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarImportDeals extends StatelessWidget {
  final List<CarCardItem> cars;
  const CarImportDeals({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    final filteredItems = cars.where((e) => e != null).toList();
    final t = context.t;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          actionText: t('moreDeals'),
          onTap: () {
            context.push(AppRoutes.imported);
          },
          title: t('ImportDeals'),
        ),
        const ResponsiveSpacer(size: SpacerSize.medium),
        SizedBox(
          height: 430,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: cars.length,
            separatorBuilder: (_, __) => const ResponsiveSpacer(
              axis: Axis.horizontal,
              size: SpacerSize.medium,
            ),

            itemBuilder: (context, index) {
              final car = filteredItems[index];
              return CarCard(
                width: 300,
                item: car,
                imageUrls: car.gallery,
                isImported: true,
              );
            },
          ),
        ),
      ],
    );
  }
}
