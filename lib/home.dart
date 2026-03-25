import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio/about_section.dart';
import 'package:portfolio/dev_info.dart';
import 'package:portfolio/header.dart';
import 'package:portfolio/modules/components/animated_background.dart';
import 'package:portfolio/project_section.dart';
import 'package:portfolio/skills.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController scrollController = ScrollController();

  // Global keys for each section
  final GlobalKey aboutKey = GlobalKey();
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
                      Header(
                        aboutKey: aboutKey,
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
                      // const SizedBox(height: 60),
                      // const ContactSection(),
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
}
