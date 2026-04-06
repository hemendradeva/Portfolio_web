import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/strings.dart';

class AboutSection extends StatefulWidget {
  final Key widgetKey;

  const AboutSection({super.key, required this.widgetKey});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  double _avatarScale = 1.0;
  bool _isDescHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Fade animation for text
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Scale animation for avatar
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.9, curve: Curves.elasticOut),
      ),
    );

    // Slide animation for text column
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the screen is mobile (width < 600)
    final isMobile = MediaQuery.of(context).size.width < 600;

    // Adjust padding, avatar size, and font sizes based on screen size
    final padding = isMobile ? 16.0 : 24.0;
    final avatarRadius = isMobile ? 45.0 : 60.0;
    final titleFontSize = isMobile ? 22.0 : 28.0;
    final descriptionFontSize = isMobile ? 15.0 : 17.0;

    return Container(
      key: widget.widgetKey,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.symmetric(
        vertical: padding * 1.5,
        horizontal: padding,
      ),
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
      child: isMobile
          ? Column(
              children: [
                _buildAvatar(avatarRadius),
                const SizedBox(height: 24),
                _buildTextContent(titleFontSize, descriptionFontSize, isMobile),
              ],
            )
          : Row(
              children: [
                _buildAvatar(avatarRadius),
                const SizedBox(width: 40),
                Expanded(
                  child: _buildTextContent(
                      titleFontSize, descriptionFontSize, isMobile),
                ),
              ],
            ),
    );
  }

  Widget _buildAvatar(double radius) {
    return MouseRegion(
      onEnter: (_) => setState(() => _avatarScale = 1.1),
      onExit: (_) => setState(() => _avatarScale = 1.0),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedScale(
          scale: _avatarScale,
          duration: const Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.4),
                  blurRadius: 25,
                  spreadRadius: 3,
                )
              ],
            ),
            child: CircleAvatar(
              radius: radius,
              backgroundImage: const AssetImage('assets/images/hemendra.png'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent(
    double titleFontSize,
    double descriptionFontSize,
    bool isMobile,
  ) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            /// 🔥 Gradient Title
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.blueAccent, Colors.pinkAccent],
              ).createShader(bounds),
              child: Text(
                Strings.about_me,
                style: GoogleFonts.poppins(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// 🔥 Description Card
            MouseRegion(
              onEnter: (_) => setState(() => _isDescHovering = true),
              onExit: (_) => setState(() => _isDescHovering = false),
              child: Column(
                crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [

                  /// 🔥 DESCRIPTION CARD
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(16),

                    transform: _isDescHovering
                        ? (Matrix4.identity()..scale(1.02)) // 👈 slight zoom
                        : Matrix4.identity(),

                    decoration: BoxDecoration(
                      color: _isDescHovering
                          ? Colors.white.withOpacity(0.12)   // brighter
                          : Colors.white.withOpacity(0.05),

                      borderRadius: BorderRadius.circular(16),

                      border: Border.all(
                        color: _isDescHovering
                            ? Colors.blueAccent.withOpacity(0.5)
                            : Colors.white.withOpacity(0.08),
                      ),

                      boxShadow: _isDescHovering
                          ? [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.25),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ]
                          : [],
                    ),

                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: GoogleFonts.poppins(
                        fontSize: descriptionFontSize,
                        height: 1.6,
                        color: _isDescHovering
                            ? Colors.white
                            : Colors.white70,
                      ),
                      child: Text(
                        "I’m ${Strings.name}, a passionate Flutter developer with ${Strings.no_experience}+ years of experience building beautiful mobile and web apps using Flutter, Dart, and Firebase.",
                        textAlign:
                        isMobile ? TextAlign.center : TextAlign.left,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 🔥 BOTTOM LINE ANIMATION
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _isDescHovering ? 120 : 50,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isDescHovering
                            ? [Colors.blueAccent, Colors.pinkAccent]
                            : [
                          Colors.blueAccent.withOpacity(0.4),
                          Colors.pinkAccent.withOpacity(0.4)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
