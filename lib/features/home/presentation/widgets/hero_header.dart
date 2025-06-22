import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:flutter/material.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: const Color(0xFF102232),
          width: double.infinity,
          height: 600.0,
          padding: const EdgeInsets.only(top: 140, bottom: 0),
          child: Column(
            children: [
              const ResponsiveSpacer(size: SpacerSize.large),

              Text(
                '${t("driveDeals")} \n${t("sellFase")}',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: -155,
          child: Image.asset('assets/imgs/header-logo.webp', width: 320),
        ),
      ],
    );
  }
}
