import 'package:flutter/material.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';

class ProfileImgs extends StatelessWidget {
  final String? avatarUrl;
  final String? coverUrl;

  const ProfileImgs({super.key, this.avatarUrl, this.coverUrl});

  @override
  Widget build(BuildContext context) {
    final radius = context.radius;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radius.lg),
          child: Image.asset(
            coverUrl ?? 'assets/imgs/dealership_banner.webp',
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: -35,
          child: Image.asset(
            avatarUrl ?? 'assets/imgs/dealership_icon.webp',
            width: 74,
            height: 74,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
