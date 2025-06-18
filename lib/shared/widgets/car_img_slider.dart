import 'dart:io';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';

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
                  _buildImage(widget.images[index], isBlurred: true),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        color: Colors.black.withAlpha((0.0 * 255).round()),
                      ),
                    ),
                  ),
                  _buildImage(widget.images[index]),
                ],
              ),
            );
          },
        ),

        if (widget.images.length > 1) ...[
          Positioned(
            top: widget.height / 2 - 20,
            left: 8,
            child: _navButton(
              Icons.arrow_back_ios_sharp,
              _controller.previousPage,
            ),
          ),
          Positioned(
            top: widget.height / 2 - 20,
            right: 8,
            child: _navButton(
              Icons.arrow_forward_ios_sharp,
              _controller.nextPage,
            ),
          ),
        ],
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
                          ? Colors.white
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

  Widget _navButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Center(
          child: Icon(icon, size: 16, color: context.colors.secondary.main),
        ),
      ),
    );
  }

  Widget _buildImage(dynamic image, {bool isBlurred = false}) {
    final blendColor = Colors.black.withAlpha((0.4 * 255).round());
    final blendMode = BlendMode.darken;

    if (image is String &&
        (image.startsWith('http') || image.startsWith('https'))) {
      return CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        color: blendColor,
        colorBlendMode: blendMode,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else if (image is String) {
      // Asset Image
      return Image.asset(
        image,
        fit: BoxFit.cover,
        color: blendColor,
        colorBlendMode: blendMode,
      );
    } else if (image is File) {
      return Image.file(
        image,
        fit: BoxFit.cover,
        color: blendColor,
        colorBlendMode: blendMode,
      );
    } else if (image is ImageProvider) {
      return Image(
        image: image,
        fit: BoxFit.cover,
        color: blendColor,
        colorBlendMode: blendMode,
      );
    } else {
      return const Center(child: Icon(Icons.broken_image));
    }
  }
}
