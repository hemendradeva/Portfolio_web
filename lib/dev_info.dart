import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
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
  bool _isHovering1 = false;
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
          colors: [
            const Color(0xFF0F172A), // dark blue
            const Color(0xFF1E293B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
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
                    child: Text(
                      Strings.name,
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [Colors.blueAccent, Colors.pinkAccent],
                          ).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
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
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: _isHovering
                                    ? Colors.white.withOpacity(0.15)   // 👈 brighter on hover
                                    : Colors.white.withOpacity(0.06),

                                borderRadius: BorderRadius.circular(16),

                                border: Border.all(
                                  color: _isHovering
                                      ? Colors.blueAccent.withOpacity(0.5)  // 👈 highlight border
                                      : Colors.white.withOpacity(0.08),
                                ),

                                boxShadow: _isHovering
                                    ? [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 8),
                                  ),
                                ]
                                    : [],
                              ),

                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.6,
                                  color: _isHovering
                                      ? Colors.white       // 👈 full white on hover
                                      : Colors.white70,
                                ),
                                child: const Text(
                                  "I build beautiful mobile and web apps using Flutter.",
                                ),
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
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        MouseRegion(
                          onEnter: (_) => setState(() => _isButtonHovered = true),
                          onExit: (_) => setState(() => _isButtonHovered = false),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            transform: _isButtonHovered
                                ? Matrix4.translationValues(0, -5, 0)
                                : Matrix4.identity(),
                            child: ElevatedButton(
                              onPressed: () => launchUrl(Uri.parse(Strings.resumePDFLink)),
                              style: ElevatedButton.styleFrom(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                backgroundColor:
                                _isButtonHovered ? Colors.blue.shade700 : Colors.white,
                                foregroundColor:
                                _isButtonHovered ? Colors.white : Colors.blue.shade700,
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
                                children: const [
                                  Icon(Icons.download_rounded),
                                  SizedBox(width: 8),
                                  Text(
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

                        /// 👇 Social Links
                        _buildSocialLinks(),
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      0,
                      10 * math.sin(_controller.value * 2 * math.pi), // smoother float
                    ),
                    child: child,
                  );
                },
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovering1 = true),
                  onExit: (_) => setState(() => _isHovering1 = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    transform: _isHovering1
                        ? (Matrix4.identity()..scale(1.05)) // 👈 zoom on hover
                        : Matrix4.identity(),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: _isHovering1
                          ? [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ]
                          : [],
                    ),
                    child: Lottie.network(
                      "https://assets2.lottiefiles.com/packages/lf20_fcfjwiyb.json",
                      height: 300,
                      fit: BoxFit.contain,
                      repeat: true,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0F172A), // dark blue
            const Color(0xFF1E293B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Lottie.network(
              "https://assets2.lottiefiles.com/packages/lf20_fcfjwiyb.json",
              height: 350,
              fit: BoxFit.contain,
              repeat: true,
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
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Text(
                  "I build beautiful mobile and web apps using Flutter.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
              )
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
