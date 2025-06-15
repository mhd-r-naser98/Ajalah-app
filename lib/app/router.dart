// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ajalah/core/di/service_locator.dart';
import 'package:new_ajalah/core/services/storage_service.dart';
import 'package:new_ajalah/features/auth/presentation/confirm/confirm_screen.dart';
import 'package:new_ajalah/features/auth/presentation/forgot/forgot_screen.dart';
import 'package:new_ajalah/features/global/privacy/privacy_screen.dart';
import 'package:new_ajalah/features/global/terms/terms_screen.dart';
import 'package:new_ajalah/features/home/logic/home_cubit.dart';
import 'package:new_ajalah/features/home/presentation/widgets/home_body.dart';
import 'package:new_ajalah/features/imported/imported_screen.dart';
import 'package:new_ajalah/features/home/presentation/sell/sell_screen.dart';
import 'package:new_ajalah/features/home/presentation/settings/settings_screen.dart';
import 'package:new_ajalah/features/more/presentation/more_page.dart';
import 'package:new_ajalah/features/used/used_screen.dart';
import 'package:new_ajalah/features/splash/presentation/splash_view.dart';
// import 'package:new_ajalah/features/auth/data/auth_repo.dart';
import '../core/config/router.dart' as AppRoutes;
import '../features/auth/presentation/login/login_screen.dart';
import '../features/auth/presentation/register/register_screen.dart';
import '../features/home/presentation/home_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      /// Public (No auth needed)
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        name: 'login',
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'register',
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: 'confirm',
        path: AppRoutes.confirm,
        builder: (context, state) => const ConfirmScreen(),
      ),
      GoRoute(
        name: 'forgot',
        path: AppRoutes.forgot,
        builder: (context, state) => const ForgotScreen(),
      ),

      /// Shell for authenticated pages
      ShellRoute(
        builder: (context, state, child) => HomeShellScreen(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => BlocProvider(
              create: (_) => HomeCubit()..fetchCars(),
              child: const HomeBody(),
            ),
          ),
          GoRoute(
            path: AppRoutes.used,
            name: 'used',
            builder: (context, state) => const UsedScreen(),
          ),
          GoRoute(
            path: AppRoutes.sell,
            name: 'sell',
            builder: (context, state) => const SellScreen(),
          ),
          GoRoute(
            path: AppRoutes.imported,
            name: 'imported',
            builder: (context, state) => const ImportedScreen(),
          ),
          GoRoute(
            path: AppRoutes.more,
            name: 'more',
            builder: (context, state) => const MoreScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.terms,
            name: 'terms',
            builder: (context, state) => const TermsScreen(),
          ),
          GoRoute(
            path: AppRoutes.privacy,
            name: 'privacy',
            builder: (context, state) => const PrivacyScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) async {
      final location = state.matchedLocation;
      if (location == AppRoutes.splash) return null;

      final storageService = locator<StorageService>();
      final token = await storageService.getToken();
      final isLoggedIn = token != null;

      final loggingIn = [
        AppRoutes.login,
        AppRoutes.register,
        AppRoutes.forgot,
        AppRoutes.confirm,
      ].contains(location);

      if (!isLoggedIn && !loggingIn) return AppRoutes.login;
      if (isLoggedIn && loggingIn) return AppRoutes.home;

      return null;
    },
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('404: Not Found'))),
  );

  static BuildContext? get context => _rootNavigatorKey.currentContext;
}
