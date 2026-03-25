import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/strings.dart';

class AboutSection extends StatefulWidget {
  final Key widgetKey;

  const AboutSection({super.key, required this.widgetKey});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  double _avatarScale = 1.0;

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
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.symmetric(vertical: padding * 1.5, horizontal: padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50.withOpacity(0.8),
            Colors.purple.shade50.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAvatar(avatarRadius),
                const SizedBox(height: 20),
                _buildTextContent(titleFontSize, descriptionFontSize, isMobile),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatar(avatarRadius),
                const SizedBox(width: 30),
                Expanded(
                  child: _buildTextContent(titleFontSize, descriptionFontSize, isMobile),
                ),
              ],
            ),
    );
  }

  Widget _buildAvatar(double radius) {
    return InkWell(
      onTap: () {
        setState(() {
          _avatarScale = 1.1;
        });
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            _avatarScale = 1.0;
          });
        });
      },
      borderRadius: BorderRadius.circular(radius),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedScale(
          scale: _avatarScale,
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue.shade300,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
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

  Widget _buildTextContent(double titleFontSize, double descriptionFontSize, bool isMobile) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Text(
              Strings.about_me,
              style: GoogleFonts.poppins(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            const SizedBox(height: 12),
            Text(
              "I’m ${Strings.name}, a passionate Flutter developer with ${Strings.no_experience}+ years of experience building beautiful mobile and web apps using Flutter, Dart, and Firebase.",
              style: GoogleFonts.poppins(
                fontSize: descriptionFontSize,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800],
                height: 1.5,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
