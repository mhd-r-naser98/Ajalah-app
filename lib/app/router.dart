import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../core/di/service_locator.dart';
import '../core/services/storage_service.dart';
import '../features/account/dashboard/dashboard_screen.dart';
import '../features/account/order-tracking/order_tracking.dart';
import '../features/account/saved/saved_screen.dart';
import '../features/auth/presentation/confirm/confirm_screen.dart';
import '../features/auth/presentation/forgot/forgot_screen.dart';
import '../features/carListing/new/new_car_screen.dart';
import '../features/carListing/rent/rent_car_screen.dart';
import '../features/carListing/search-by/search_by_screen.dart';
import '../features/compare/compare_screen.dart';
import '../features/global/about/about_screen.dart';
import '../features/global/privacy/privacy_screen.dart';
import '../features/global/terms/terms_screen.dart';
import '../features/home/logic/home_cubit.dart';
import '../features/home/presentation/widgets/home_body.dart';
import '../features/carListing/imported/imported_screen.dart';
import '../features/account/sell/sell_screen.dart';
import '../features/more/presentation/more_screen.dart';
import '../features/carListing/used/used_screen.dart';
import '../features/splash/presentation/splash_view.dart';
import '../core/config/router.dart';
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
            path: AppRoutes.terms,
            name: 'terms',
            builder: (context, state) => const TermsScreen(),
          ),
          GoRoute(
            path: AppRoutes.privacy,
            name: 'privacy',
            builder: (context, state) => const PrivacyScreen(),
          ),
          GoRoute(
            path: AppRoutes.about,
            name: 'about',
            builder: (context, state) => const AboutScreen(),
          ),
          GoRoute(
            path: AppRoutes.compare,
            name: 'compare',
            builder: (context, state) => const CompareScreen(),
          ),
          GoRoute(
            path: AppRoutes.searchBy,
            name: 'searchBy',
            builder: (context, state) => const SearchByScreen(),
          ),
          GoRoute(
            path: AppRoutes.newCars,
            name: 'newCars',
            builder: (context, state) => const NewCarScreen(),
          ),
          GoRoute(
            path: AppRoutes.rent,
            name: 'rent',
            builder: (context, state) => const RentCarScreen(),
          ),
          GoRoute(
            path: AppRoutes.savedCars,
            name: 'savedCars',
            builder: (context, state) => const SavedScreen(),
          ),
          GoRoute(
            path: AppRoutes.orders,
            name: 'orders',
            builder: (context, state) => const OrderTracking(),
          ),
          GoRoute(
            path: AppRoutes.dashboard,
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
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

      final account = [
        AppRoutes.dashboard,
        AppRoutes.orders,
        AppRoutes.savedCars,
        AppRoutes.sell,
      ].contains(location);

      if (!isLoggedIn && (!loggingIn || account)) return AppRoutes.login;
      if (isLoggedIn && loggingIn) return AppRoutes.home;

      return null;
    },
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('404: Not Found'))),
  );

  static BuildContext? get context => _rootNavigatorKey.currentContext;
}
