import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/modules/screens/splash/splash_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String formsTab = '/register_forms';
  static const String forgotPassword = '/forgot_password';
}

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) => const PortfolioHomePage(),
      ),
    ],
  );
  static GoRouter get router => _router;
}
