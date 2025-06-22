import 'package:ajalah/core/widgets/sm_brand_box.dart';
import 'package:flutter/material.dart';

class SmallBrands extends StatelessWidget {
  final List<dynamic> remaining;
  const SmallBrands({super.key, required this.remaining});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: remaining.length,
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.8,
      ),
      itemBuilder: (context, index) {
        final brand = remaining[index];
        return SmBrandBox(
          label: brand.name,
          img: brand.brandImageUrl,
          // count: brand['count'],
          onTap: () {
            print('Tapped ${brand.name}');
          },
        );
      },
    );
  }
}
