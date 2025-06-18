import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/core/di/service_locator.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/cubit/google_cubit.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/cubit/login_cubit.dart';
import 'package:new_ajalah/features/auth/presentation/login/widgets/login_form.dart';
import 'package:new_ajalah/core/widgets/responsive_scroll_view.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => locator<LoginCubit>()),
        BlocProvider<GoogleAuthCubit>(create: (context) => GoogleAuthCubit()),
      ],
      child: const Scaffold(
        body: Center(child: ResponsiveScrollView(child: LoginForm())),
      ),
    );
  }
}
