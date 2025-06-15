import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_ajalah/features/home/logic/home_cubit.dart';
import 'package:new_ajalah/features/home/logic/home_state.dart';
import 'package:new_ajalah/shared/widgets/app_loading.dart';
import 'package:new_ajalah/shared/widgets/responsive_scroll_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..fetchCars(),
      child: Center(
        child: ResponsiveScrollView(
          child: Column(
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: LoadingWidget());
                  } else {
                    return Text('SettingsScreen');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
