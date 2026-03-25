import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final Size size;

  const HeroSection({required this.size, super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation1;
  late Animation<Offset> _slideAnimation2;
  late Animation<Offset> _slideAnimation3;
  late Animation<Offset> _slideAnimation4;
  late Animation<double> _scaleAnimation;

  bool _isHovering = false;
  bool _isButtonHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _slideAnimation1 = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnimation2 = Tween<Offset>(
      begin: const Offset(-0.7, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnimation3 = Tween<Offset>(
      begin: const Offset(-0.9, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnimation4 = Tween<Offset>(
      begin: const Offset(-1.1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.9, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive layout
        final isSmallScreen = constraints.maxWidth < 800;

        return isSmallScreen ? _buildMobileLayout() : _buildDesktopLayout();
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.blue.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _slideAnimation1,
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        Strings.technology,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SlideTransition(
                  position: _slideAnimation2,
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: const Text(
                      Strings.name,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SlideTransition(
                  position: _slideAnimation3,
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _isHovering ? Colors.white : Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: _isHovering
                            ? [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 5),
                                ),
                              ]
                            : [],
                      ),
                      child: MouseRegion(
                        onEnter: (_) => setState(() => _isHovering = true),
                        onExit: (_) => setState(() => _isHovering = false),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "I build beautiful mobile and web apps using Flutter.",
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.5,
                                color: _isHovering ? Colors.black87 : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 12),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: _isHovering ? 100 : 50,
                              height: 3,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.pinkAccent, Colors.blue.shade700],
                                ),
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SlideTransition(
                  position: _slideAnimation4,
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Row(
                      children: [
                        MouseRegion(
                          onEnter: (_) => setState(() => _isButtonHovered = true),
                          onExit: (_) => setState(() => _isButtonHovered = false),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            transform: _isButtonHovered ? Matrix4.translationValues(0, -5, 0) : Matrix4.identity(),
                            child: ElevatedButton(
                              onPressed: () => launchUrl(
                                Uri.parse(
                                    Strings.resumePDFLink),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                backgroundColor: _isButtonHovered ? Colors.blue.shade700 : Colors.white,
                                foregroundColor: _isButtonHovered ? Colors.white : Colors.blue.shade700,
                                elevation: _isButtonHovered ? 8 : 2,
                                shadowColor: Colors.blue.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: Colors.blue.shade700,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.download_rounded),
                                  const SizedBox(width: 8),
                                  const Text(
                                    Strings.downloadResume,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        _buildSocialLinks(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
          ScaleTransition(
            scale: _scaleAnimation,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    5 * math.sin((_controller.value * 2 * math.pi) + math.pi),
                  ),
                  child: child,
                );
              },
              child: MouseRegion(
                onEnter: (_) => _startImageAnimation(),
                child: SvgPicture.asset(
                  'assets/svg/dev_logo.svg',
                  height: 350,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.blue.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: SvgPicture.asset(
              'assets/svg/dev_logo.svg',
              height: 200,
            ),
          ),
          const SizedBox(height: 32),
          SlideTransition(
            position: _slideAnimation1,
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  Strings.technology,
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SlideTransition(
            position: _slideAnimation2,
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: const Text(
                Strings.name,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SlideTransition(
            position: _slideAnimation3,
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: const Text(
                "I build beautiful mobile and web apps using Flutter.",
                style: TextStyle(fontSize: 18, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 24),
          SlideTransition(
            position: _slideAnimation4,
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => launchUrl(Uri.parse(Strings.resumePDFLink)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade700,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: Colors.blue.shade700,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.download_rounded),
                        const SizedBox(width: 8),
                        const Text(
                          "   Download Resume",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSocialLinks(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(
            image: "assets/svg/linkdin_logo.svg",
            Icons.link,
            Colors.blue.shade800,
            Strings.linkedInURL),
        _buildSocialIcon(
          image: "assets/svg/git_icon.svg",
          Icons.code,
          Colors.black87,
          Strings.gitHubURL,
        ),
        _buildSocialIcon(
          Icons.mail_outline,
          Colors.red.shade700,
          'mailto:${Strings.mailId}',
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color, String url, {String? image}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(url)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: image != null
                ? SvgPicture.asset(
                    image,
                    width: 24,
                  )
                : Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
          ),
        ),
      ),
    );
  }

  void _startImageAnimation() {
    // You could add additional animations when hovering over the image
    // For example, a quick pulse or glow effect
  }
}
