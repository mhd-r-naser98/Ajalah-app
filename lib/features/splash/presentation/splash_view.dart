import 'package:ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:ajalah/features/splash/logic/splash_cubit.dart';
import 'package:ajalah/features/splash/presentation/widgets/splash_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..startInitialization(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: const SplashBody(),
      ),
    );
  }
}
