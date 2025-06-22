import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/app_brand_box.dart';
import 'package:ajalah/features/home/presentation/widgets/small_brands.dart';
import 'package:flutter/material.dart';

class BrandSectionBody extends StatelessWidget {
  final List<dynamic> firstFive;
  final List<dynamic> remaining;
  final VoidCallback? onTap;

  final bool isShow;

  const BrandSectionBody({
    super.key,
    required this.firstFive,
    required this.remaining,
    required this.isShow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: firstFive.map((brand) {
              return BrandBox(
                label: brand.name,
                img: brand.brandImageUrl,
                onTap: () {
                  print('Tapped ${brand.name}');
                },
              );
            }).toList(),
          ),
        ),
        const ResponsiveSpacer(size: SpacerSize.large),

        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isShow ? Icons.close : Icons.add),
              const SizedBox(width: 4),
              Text(
                isShow ? t('brandHide') : t('brandShow'),
                style: context.textStyles.styles.bodyLarge,
              ),
            ],
          ),
        ),
        const ResponsiveSpacer(size: SpacerSize.large),

        if (isShow) SmallBrands(remaining: remaining),
      ],
    );
  }
}
