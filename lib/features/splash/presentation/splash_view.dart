import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/features/splash/logic/splash_cubit.dart';
import 'package:new_ajalah/features/splash/presentation/widgets/splash_body.dart';

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
