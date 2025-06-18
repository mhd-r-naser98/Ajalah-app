import 'package:flutter/material.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:new_ajalah/core/widgets/car_card.dart';
import 'package:new_ajalah/core/widgets/section_title.dart';

class CarImportDeals extends StatelessWidget {
  const CarImportDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          actionText: 'View more deals',
          onTap: () {},
          title: 'Car Import Deals',
        ),
        const ResponsiveSpacer(size: SpacerSize.medium),
        SizedBox(
          height: 420,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const ResponsiveSpacer(
              axis: Axis.horizontal,
              size: SpacerSize.medium,
            ),

            itemBuilder: (context, index) => CarCard(
              width: 300,
              imageUrls: [
                'assets/imgs/car_sample.webp',
                'https://picsum.photos/id/237/200/300',
                "assets/imgs/car_sample.webp",
              ],
            ),
          ),
        ),
      ],
    );
  }
}
