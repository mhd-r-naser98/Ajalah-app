import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarCardLoading extends StatelessWidget {
  final double width;
  final double height;
  const CarCardLoading({super.key, this.width = 300, this.height = 210});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey[300]!;
    final highlightColor = Colors.grey[100]!;
    return Column(
      spacing: 2,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Flexible(
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: width,
                    height: height,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: width, height: 16, color: baseColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(12),

          width: width,
          height: height - 10,
          child: Flexible(
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 3,
                    children: [
                      Container(
                        width: width - 30,
                        height: 20,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      Container(
                        width: width - 30,
                        height: 40,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      Row(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Container(
                              width: 40,
                              height: 20,
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),

                      Container(
                        width: 50,
                        height: 20,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                  const ResponsiveSpacer(size: SpacerSize.medium),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
