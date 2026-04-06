import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/modules/screens/splash/splash_view.dart';

import '../pages/website_form_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String formsTab = '/register_forms';
  static const String forgotPassword = '/forgot_password';
  static const notFound = '/404';
}

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) => _buildPage(
          const SplashView(),
          state,
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => _buildPage(
          const PortfolioHomePage(),
          state,
        ),
      ),
      /// 📝 Form Page (with animation)
      GoRoute(
        path: AppRoutes.formsTab,
        pageBuilder: (context, state) => _buildPage(
          const WebsiteFormPage(),
          state,
        ),
      ),
    ],
    /// ❌ Error Page (404)
    errorBuilder: (context, state) => const NotFoundPage(),
  );
  static GoRouter get router => _router;

  /// 🎬 Common Animation Builder (Reusable)
  static CustomTransitionPage _buildPage(Widget child, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,

      transitionDuration: const Duration(milliseconds: 400),

      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }
}
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "404 - Page Not Found",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}