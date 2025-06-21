import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/car_card.dart';
import 'package:ajalah/core/widgets/section_title.dart';
import 'package:flutter/material.dart';

class CarListSection extends StatelessWidget {
  const CarListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          actionText: 'View more deals',
          onTap: () {},
          title: 'Find your special car',
        ),
        const ResponsiveSpacer(size: SpacerSize.medium),
        Column(
          children: List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CarCard(
                width: double.infinity,
                height: 280,
                imageUrls: [
                  "assets/imgs/car_sample.webp",
                  "assets/imgs/car_sample.webp",
                  "assets/imgs/car_sample.webp",
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
