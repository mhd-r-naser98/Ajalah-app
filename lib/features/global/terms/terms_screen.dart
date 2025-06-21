import 'package:ajalah/core/di/service_locator.dart';
import 'package:ajalah/core/widgets/responsive_scroll_view.dart';
import 'package:ajalah/features/auth/presentation/register/logic/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<RegisterCubit>(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: ResponsiveScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('TermsScreen')],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
