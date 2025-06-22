import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BrandBox extends StatelessWidget {
  final String label;
  final String img;
  final VoidCallback onTap;

  const BrandBox({
    super.key,
    required this.label,
    required this.img,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          Container(
            width: 60,
            height: 60,

            decoration: ShapeDecoration(
              shape: OvalBorder(
                side: BorderSide(width: 1, color: context.colors.grey[200]!),
              ),
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: img,

              fit: BoxFit.scaleDown,
              color: Colors.white,
              colorBlendMode: BlendMode.darken,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(
            width: 63.60,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: context.textStyles.styles.linkMedium.copyWith(
                color: context.colors.text,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
