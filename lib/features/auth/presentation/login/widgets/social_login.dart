import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/cubit/google_cubit.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/state/google_state.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is GoogleAuthSuccess) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      builder: (context, state) {
        if (state is GoogleAuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.read<GoogleAuthCubit>().signIn(),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.secondary.main,
                minimumSize: const Size(48, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.radius.lg),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Image.asset(
                'assets/imgs/google.webp',
                height: 24,
                width: 24,
                fit: BoxFit.contain,
              ),
            ),
          ],
        );
      },
    );
  }
}
