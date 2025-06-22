import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/config/router.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/car_card.dart';
import 'package:ajalah/core/widgets/section_title.dart';
import 'package:ajalah/shared/models/car_card_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarNewDeals extends StatelessWidget {
  final List<CarCardItem> cars;
  const CarNewDeals({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    final filteredItems = cars.where((e) => e != null).toList();
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          actionText: t('moreDeals'),
          onTap: () {
            context.push(AppRoutes.newCars);
          },
          title: t('newDeals'),
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
              return CarCard(width: 300, item: car, imageUrls: car.gallery);
            },
          ),
        ),
      ],
    );
  }
}
