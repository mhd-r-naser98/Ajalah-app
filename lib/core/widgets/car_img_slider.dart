import 'dart:ui';
import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/widgets/lazy_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarImageSlider extends StatefulWidget {
  final List<dynamic> images;
  final double height;
  final double width;
  final void Function(int)? onPageChanged;

  const CarImageSlider({
    super.key,
    required this.images,
    required this.width,
    required this.height,
    this.onPageChanged,
  });

  @override
  State<CarImageSlider> createState() => _CarImageSliderState();
}

class _CarImageSliderState extends State<CarImageSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.images.length,
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() => _current = index);
              widget.onPageChanged?.call(index);
            },
          ),
          itemBuilder: (context, index, _) {
            return ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LazyImage(image: widget.images[index]),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        color: Colors.black.withAlpha((0.0 * 255).round()),
                      ),
                    ),
                  ),
                  LazyImage(image: widget.images[index]),
                ],
              ),
            );
          },
        ),

        if (widget.images.length > 1)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key
                          ? context.colors.primary.main
                          : Colors.white.withAlpha((0.4 * 255).round()),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
