import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/core/di/service_locator.dart';
import 'package:new_ajalah/features/auth/presentation/register/logic/cubit/register_cubit.dart';
import 'package:new_ajalah/shared/widgets/responsive_scroll_view.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

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
                  children: [Text('PrivacyScreen')],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
