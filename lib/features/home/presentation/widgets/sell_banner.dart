import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class SellYourCarBanner extends StatelessWidget {
  const SellYourCarBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(context.radius.md)),

        image: const DecorationImage(
          image: AssetImage('assets/imgs/sell_banner.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You're in control, \nchoose how you \nwant to sell your car.",
              style: context.textStyles.styles.titleSmall.copyWith(
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const ResponsiveSpacer(size: SpacerSize.medium),
            SizedBox(
              width: 160,
              child: CustomButton(
                text: 'Sell your car',
                onTap: () {},
                height: 40,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
