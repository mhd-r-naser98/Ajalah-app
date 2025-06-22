import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/core/utils/responsive_spacer.dart';
import 'package:ajalah/features/splash/logic/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationController2;
  late Animation<double> fadingAni;
  late Animation<double> rotationAni;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    fadingAni = Tween<double>(begin: 0, end: 1).animate(animationController2);
    rotationAni = Tween<double>(begin: 0, end: 1).animate(animationController);

    animationController.repeat();
    animationController2.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController2.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage('assets/imgs/Load.webp'), context);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return BlocListener<SplashCubit, SplashStatus>(
      listener: (context, state) {
        if (state == SplashStatus.loaded) {
          context.go('/home');
        } else if (state == SplashStatus.error) {
          // show some error UI
        }
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotationTransition(
              turns: rotationAni,
              child: Image.asset(
                'assets/imgs/Load.webp',
                width: MediaQuery.of(context).size.width * 0.2,
                fit: BoxFit.contain,
              ),
            ),
            const ResponsiveSpacer(size: SpacerSize.medium),
            FadeTransition(
              opacity: fadingAni,
              child: Text(
                t('ajalah'),
                style: context.textStyles.styles.displaySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
