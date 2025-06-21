import 'package:ajalah/core/utils/flags_util.dart';
import 'package:ajalah/shared/models/car_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../app/theme/extensions/theme_extensions.dart';
import '../../core/utils/responsive_spacer.dart';
import '../../core/widgets/app_tag.dart';
import '../../core/widgets/car_img_slider.dart';

class CarCard extends StatefulWidget {
  final double width;
  final double height;
  final bool isImported;
  final CarCardItem? item;

  final List<String> imageUrls;

  const CarCard({
    super.key,
    required this.imageUrls,
    this.width = 300,
    this.height = 225,
    this.isImported = false,
    this.item,
  });

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    final url = getFlagUrl(widget.item?.countryOfOrigin ?? "");

    return Card(
      elevation: 2.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          SizedBox(
            width: widget.width,
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                color: context.colors.box,
              ),
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: Stack(
                  children: [
                    CarImageSlider(
                      images: widget.imageUrls,
                      width: widget.width,
                      height: widget.height,
                    ),
                    Positioned(
                      top: 12,
                      left: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TagWidget(tagName: 'Tag Name'),
                          InkWell(
                            onTap: () {
                              // ignore: avoid_print
                              print('clicked');
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  // Icons.favorite_rounded,
                                  Icons.favorite_border,
                                  size: 22,
                                  color: context.colors.error.main,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            width: widget.width,
            // height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
              color: context.colors.box,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'Car Name & Model',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      height: 1.2,
                      color: context.colors.text,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const ResponsiveSpacer(size: SpacerSize.xSmall),

                  Text(
                    'Derivative Derivative Derivative Derivative Derivative Derivative Derivative ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.2,
                      color: context.colors.grey[600]!,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const ResponsiveSpacer(size: SpacerSize.small),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 6,
                    children: [
                      TagWidget(
                        tagName: 'Tag Name',
                        tagColor: context.colors.primary.main,
                        textColor: Colors.white,
                        fontSize: 12.0,
                      ),
                      const TagWidget(tagName: 'Tag Name'),
                      const TagWidget(tagName: 'Tag Name'),
                    ],
                  ),

                  const ResponsiveSpacer(size: SpacerSize.xLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 2,
                          children: [
                            if (widget.item?.countryOfOrigin == null) ...[
                              SvgPicture.asset(
                                'assets/icons/location.svg',
                                height: 21,
                                width: 20,

                                colorFilter: ColorFilter.mode(
                                  context.colors.text,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Text(
                                'Aleppo',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                  color: context.colors.text,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ] else
                              url.startsWith("http")
                                  ? Icon(
                                      Icons.location_off,
                                      size: 22,
                                      color: context.colors.secondary.main,
                                    )
                                  : Image.asset(url, width: 48, height: 36),
                          ],
                        ),
                      ),
                      Text(
                        '22000\$',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                          color: context.colors.text,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
