import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ajalah/shared/widgets/app_nav_bar.dart';
// ignore: library_prefixes
import '../../../core/config/router.dart' as AppRoutes;

class HomeShellScreen extends StatelessWidget {
  final Widget child;

  const HomeShellScreen({super.key, required this.child});

  static final tabs = [
    AppRoutes.home,
    AppRoutes.used,
    AppRoutes.sell,
    AppRoutes.imported,
    AppRoutes.more,
  ];

  int _getIndexFromLocation(String location) {
    final index = tabs.indexWhere((tab) => location.startsWith(tab));
    return index >= 0 ? index : 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _getIndexFromLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: index,
        onTap: (i) => context.go(tabs[i]),
      ),
    );
  }
}
