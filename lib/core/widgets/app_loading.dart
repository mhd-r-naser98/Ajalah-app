import 'package:flutter/material.dart';
import '../../app/theme/extensions/theme_extensions.dart';
import '../../core/utils/responsive_spacer.dart';
import '../../core/utils/size_config.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadingAni;
  late Animation<double> rotationAni;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    fadingAni = Tween<double>(begin: 0, end: 1).animate(animationController);
    rotationAni = Tween<double>(begin: 0, end: 1).animate(animationController);

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: rotationAni,
            child: Image.asset(
              'assets/imgs/Load.webp',
              width: SizeConfig.screenWidth! * 0.2,
              fit: BoxFit.contain,
            ),
          ),
          const ResponsiveSpacer(size: SpacerSize.medium),
          FadeTransition(
            opacity: fadingAni,
            child: Text(
              'ajalah',
              style: context.textStyles.styles.displaySmall,
            ),
          ),
        ],
      ),
    );
  }
}
