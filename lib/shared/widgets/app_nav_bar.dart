import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = context.colors.background;
    final radius = context.radius.lg;
    final t = context.t;

    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              asset: 'assets/imgs/home.svg',
              label: t('Home'),
              selected: currentIndex == 0,
              onTap: () => onTap(0),
              colors: context.colors,
            ),
            _NavItem(
              asset: 'assets/imgs/used.svg',
              label: t('Used'),
              selected: currentIndex == 1,
              onTap: () => onTap(1),
              colors: context.colors,
            ),
            _NavItem(
              asset: 'assets/imgs/sell.svg',
              label: t('Sell'),
              selected: currentIndex == 2,
              onTap: () => onTap(2),
              colors: context.colors,
            ),
            _NavItem(
              asset: 'assets/imgs/imported.svg',
              label: t('Imported'),
              selected: currentIndex == 3,
              onTap: () => onTap(3),
              colors: context.colors,
            ),
            _NavItem(
              asset: 'assets/imgs/more.svg',
              label: t('More'),
              selected: currentIndex == 4,
              onTap: () => onTap(4),
              colors: context.colors,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String asset;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final dynamic colors;

  const _NavItem({
    required this.asset,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.colors,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails _) {
    setState(() {
      _scale = 0.9;
    });
  }

  void _onTapUp(TapUpDetails _) {
    setState(() {
      _scale = 1.0;
    });
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.selected
        ? widget.colors.text
        : widget.colors.grey[600]!;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        behavior: HitTestBehavior.translucent,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ResponsiveSpacer(size: SpacerSize.medium),
                SvgPicture.asset(
                  widget.asset,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    widget.selected
                        ? context.colors.text
                        : widget.colors.grey[600]!,
                    BlendMode.srcIn,
                  ),
                ),
                const ResponsiveSpacer(size: SpacerSize.xSmall),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                  child: Text(widget.label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
