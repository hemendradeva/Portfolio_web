import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/about_section.dart';
import 'package:portfolio/dev_info.dart';
import 'package:portfolio/header.dart';
import 'package:portfolio/modules/components/animated_background.dart';
import 'package:portfolio/project_section.dart';
import 'package:portfolio/skills.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_selection.dart';
import 'routes/app_routes.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController scrollController = ScrollController();

  // Global keys for each section
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBackground(
        child: AnimationLimiter(
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
            child: AnimationConfiguration.staggeredList(
              position: 0,
              duration: const Duration(milliseconds: 1000),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () => _openFormPage(),
                            child: const Text(
                              "Create Your Website 🚀",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Header(
                        aboutKey: aboutKey,
                        contactKey: contactKey,
                        projectsKey: projectsKey,
                        scrollController: scrollController,
                        skillsKey: skillsKey,
                      ),
                      const SizedBox(height: 60),
                      HeroSection(size: size),
                      const SizedBox(height: 60),
                      SkillsSection(widgetKey: skillsKey),
                      const SizedBox(height: 60),
                      ProjectsSection(widgetKey: projectsKey),
                      const SizedBox(height: 60),
                      AboutSection(widgetKey: aboutKey),
                      const SizedBox(height: 60),
                      ContactSection(contactKey: contactKey),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openFormPage() async {
    // final url = Uri.parse("https://docs.google.com/forms/d/e/1FAIpQLSdS-0_7PxTmu44ZmDLp1OgmLcjneZ0eYw8wWc1KU9VQM2g3AQ/viewform?usp=publish-editor");
    //
    // await launchUrl(
    //   url,
    //   mode: LaunchMode.externalApplication, // 👈 opens in browser
    // );
    context.push(AppRoutes.formsTab);
  }
}
