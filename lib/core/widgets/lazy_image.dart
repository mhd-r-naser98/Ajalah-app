import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LazyImage extends StatelessWidget {
  final dynamic image;
  const LazyImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final blendMode = BlendMode.darken;

    if (image is String &&
        (image.startsWith('http') || image.startsWith('https'))) {
      return Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            color: Colors.black.withAlpha((0.3 * 255).round()),
            colorBlendMode: BlendMode.darken,
            placeholder: (context, url) => Container(color: Colors.grey[300]),
            errorWidget: (context, url, error) =>
                Container(color: Colors.grey[300]),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: Colors.black.withAlpha((0.0 * 255).round()),
              ),
            ),
          ),
          Center(
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.contain,
              color: Colors.transparent,
              colorBlendMode: blendMode,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ],
      );
    } else if (image is String) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            color: Colors.black.withAlpha((0.3 * 255).round()),
            colorBlendMode: BlendMode.darken,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: Colors.black.withAlpha((0.0 * 255).round()),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              color: Colors.transparent,
              colorBlendMode: blendMode,
            ),
          ),
        ],
      );
    } else if (image is File) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            image,
            fit: BoxFit.cover,
            color: Colors.black.withAlpha((0.3 * 255).round()),
            colorBlendMode: BlendMode.darken,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: Colors.black.withAlpha((0.0 * 255).round()),
              ),
            ),
          ),
          Center(
            child: Image.file(
              image,
              fit: BoxFit.contain,
              color: Colors.transparent,
              colorBlendMode: blendMode,
            ),
          ),
        ],
      );
    } else if (image is ImageProvider) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: image,
            fit: BoxFit.cover,
            color: Colors.black.withAlpha((0.3 * 255).round()),
            colorBlendMode: BlendMode.darken,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: Colors.black.withAlpha((0.0 * 255).round()),
              ),
            ),
          ),
          Center(
            child: Image(
              image: image,
              fit: BoxFit.contain,
              color: Colors.transparent,
              colorBlendMode: blendMode,
            ),
          ),
        ],
      );
    } else {
      return const Center(child: Icon(Icons.broken_image));
    }
  }
}
