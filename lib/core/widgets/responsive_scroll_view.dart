// import 'package:flutter/material.dart';
// import 'package:new_ajalah/core/utils/size_config.dart';

// class ResponsiveScrollView extends StatelessWidget {
//   final Widget child;
//   final Future<void> Function()? onRefresh;
//   final bool childIsScrollable;

//   const ResponsiveScrollView({
//     super.key,
//     required this.child,
//     this.onRefresh,
//     this.childIsScrollable = false,
//   });

//   double calcMaxWidth(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     if (screenWidth < 400) {
//       return double.infinity;
//     } else if (screenWidth < 600) {
//       return 400;
//     } else if (screenWidth < 900) {
//       return 600;
//     } else {
//       return 900;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final padding = EdgeInsets.symmetric(
//       horizontal: SizeConfig.defaultSize! * 2,
//       vertical: SizeConfig.defaultSize! * 2,
//     );

//     final screenWidth = SizeConfig.screenWidth!;
//     final calculatedMaxWidth = calcMaxWidth(context);

//     final minWidth = screenWidth * 0.9;
//     final safeMinWidth = minWidth <= calculatedMaxWidth
//         ? minWidth
//         : calculatedMaxWidth;

//     final content = Center(
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           minWidth: safeMinWidth,
//           maxWidth: calculatedMaxWidth,
//         ),
//         child: child,
//       ),
//     );

//     if (childIsScrollable) {
//       final paddedContent = Padding(padding: padding, child: content);

//       if (onRefresh != null) {
//         return SafeArea(
//           child: RefreshIndicator(onRefresh: onRefresh!, child: paddedContent),
//         );
//       }

//       return SafeArea(child: paddedContent);
//     }

//     final scrollView = SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: padding,
//       child: content,
//     );

//     final wrapped = onRefresh != null
//         ? RefreshIndicator(onRefresh: onRefresh!, child: scrollView)
//         : scrollView;

//     return SafeArea(child: wrapped);
//   }
// }
import 'package:flutter/material.dart';

class ResponsiveScrollView extends StatelessWidget {
  final Widget child;
  final Future<void> Function()? onRefresh;
  final bool childIsScrollable;
  final double horizontalPadding;
  final double verticalPadding;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final bool isPaddine;

  static const double smallBreakpoint = 400;
  static const double mediumBreakpoint = 600;
  static const double largeBreakpoint = 900;

  const ResponsiveScrollView({
    super.key,
    required this.child,
    this.onRefresh,
    this.childIsScrollable = false,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 16.0,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.isPaddine = true,
  });

  double calcMaxWidth(double screenWidth) {
    if (screenWidth < smallBreakpoint) {
      return double.infinity;
    } else if (screenWidth < mediumBreakpoint) {
      return smallBreakpoint;
    } else if (screenWidth < largeBreakpoint) {
      return mediumBreakpoint;
    } else {
      return largeBreakpoint;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = isPaddine
        ? EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          )
        : EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0);

    final calculatedMaxWidth = calcMaxWidth(screenWidth);
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

    Widget wrappedContent;
    if (childIsScrollable) {
      final paddedContent = Padding(padding: padding, child: content);
      wrappedContent = onRefresh != null
          ? RefreshIndicator(onRefresh: onRefresh!, child: paddedContent)
          : paddedContent;
    } else {
      final scrollView = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: padding,
        child: content,
      );
      wrappedContent = onRefresh != null
          ? RefreshIndicator(onRefresh: onRefresh!, child: scrollView)
          : scrollView;
    }

    return SafeArea(
      top: safeAreaTop,
      bottom: safeAreaBottom,
      child: wrappedContent,
    );
  }
}
