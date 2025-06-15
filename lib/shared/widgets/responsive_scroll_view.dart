import 'package:flutter/material.dart';
import 'package:new_ajalah/core/utils/size_config.dart';

class ResponsiveScrollView extends StatelessWidget {
  final Widget child;
  final Future<void> Function()? onRefresh;
  final bool childIsScrollable;

  const ResponsiveScrollView({
    super.key,
    required this.child,
    this.onRefresh,
    this.childIsScrollable = false,
  });

  double calcMaxWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 400) {
      return double.infinity;
    } else if (screenWidth < 600) {
      return 400;
    } else if (screenWidth < 900) {
      return 600;
    } else {
      return 900;
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: SizeConfig.defaultSize! * 2,
      vertical: SizeConfig.defaultSize! * 2,
    );

    final screenWidth = SizeConfig.screenWidth!;
    final calculatedMaxWidth = calcMaxWidth(context);

    final minWidth = screenWidth * 0.9;
    final safeMinWidth = minWidth <= calculatedMaxWidth
        ? minWidth
        : calculatedMaxWidth;

    final content = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: safeMinWidth,
          maxWidth: calculatedMaxWidth,
        ),
        child: child,
      ),
    );

    if (childIsScrollable) {
      final paddedContent = Padding(padding: padding, child: content);

      if (onRefresh != null) {
        return SafeArea(
          child: RefreshIndicator(onRefresh: onRefresh!, child: paddedContent),
        );
      }

      return SafeArea(child: paddedContent);
    }

    final scrollView = SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: padding,
      child: content,
    );

    final wrapped = onRefresh != null
        ? RefreshIndicator(onRefresh: onRefresh!, child: scrollView)
        : scrollView;

    return SafeArea(child: wrapped);
  }
}
