import 'package:flutter/material.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:new_ajalah/core/widgets/app_tag.dart';
import 'package:new_ajalah/core/widgets/car_img_slider.dart';

class CarCard extends StatefulWidget {
  final double width;
  final double height;
  final List<String> imageUrls;

  const CarCard({
    super.key,
    required this.imageUrls,
    this.width = 300,
    this.height = 225,
  });

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.5,
      child: Column(
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
                  const ResponsiveSpacer(size: SpacerSize.medium),
                  Text(
                    '\$ 999,999',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
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
