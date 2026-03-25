import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/routes/app_routes.dart';
import 'package:portfolio/strings.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    _scaleController.forward();
    Future.delayed(
      const Duration(seconds: 4),
      () => AppRouter.router.pushReplacement(AppRoutes.home),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fontSize;
    if (MediaQuery.of(context).size.width < 240) {
      fontSize = 10; // small phone
    }else if (MediaQuery.of(context).size.width < 360) {
      fontSize = 12; // small phone
    }if (MediaQuery.of(context).size.width < 390) {
      fontSize = 14; // small phone
    }else if (MediaQuery.of(context).size.width < 480) {
      fontSize = 16; // small phone
    } else if (MediaQuery.of(context).size.width < 720) {
      fontSize = 18; // small phone
    }else if (MediaQuery.of(context).size.width < 768) {
      fontSize = 20; // large phone / small tablet
    } else if (MediaQuery.of(context).size.width < 810) {
      fontSize = 25; // large phone / small tablet
    } else if (MediaQuery.of(context).size.width < 900) {
      fontSize = 30; // large phone / small tablet
    } else if (MediaQuery.of(context).size.width < 1024) {
      fontSize = 44; // tablet
    } else {
      fontSize = 64; // desktop
    }
    return Scaffold(
      backgroundColor: const Color(0xFF0f172a),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Text(
                Strings.name,
                softWrap: true,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent[700],
                  overflow: TextOverflow.ellipsis,
                  letterSpacing: 4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(Strings.position),
                  TypewriterAnimatedText(Strings.position),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 120,
              height: 2,
              color: Colors.blueAccent[700],
            )
          ],
        ),
      ),
    );
  }
}
