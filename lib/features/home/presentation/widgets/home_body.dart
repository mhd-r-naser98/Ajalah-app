// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/shared/widgets/app_loading.dart';
import 'package:new_ajalah/shared/widgets/responsive_scroll_view.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: LoadingWidget());
            } else {
              return const ResponsiveScrollView(
                child: Center(child: Text('HomeBody')),
              );
            }
          },
        );
      },
    );
  }
}
