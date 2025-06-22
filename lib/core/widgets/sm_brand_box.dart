import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SmBrandBox extends StatefulWidget {
  final String label;
  final Object? count;
  final String img;
  final VoidCallback onTap;
  const SmBrandBox({
    super.key,
    required this.label,
    this.count,
    required this.img,
    required this.onTap,
  });

  @override
  State<SmBrandBox> createState() => _SmBrandBoxState();
}

class _SmBrandBoxState extends State<SmBrandBox> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = context.radius;
    final style = context.textStyles.styles;
    return SizedBox(
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(radius.lg),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colors.box,
            borderRadius: BorderRadius.circular(radius.lg),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      width: 35,
                      height: 35,

                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: colors.secondary.contrast,
                        borderRadius: BorderRadius.circular(context.radius.md),
                        border: Border.all(width: 1, color: Color(0xFFF2F2F7)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.img,

                        fit: BoxFit.contain,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Text(
                      widget.label,
                      style: style.linkMedium.copyWith(
                        color: context.colors.text,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              const ResponsiveSpacer(
                axis: Axis.horizontal,
                size: SpacerSize.small,
              ),
              Text(
                '',
                style: style.bodySmall.copyWith(color: colors.grey[700]),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
