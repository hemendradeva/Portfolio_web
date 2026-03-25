import 'package:flutter/material.dart';
import 'package:portfolio/strings.dart';

class Header extends StatefulWidget {
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey projectsKey;
  final ScrollController scrollController;
  const Header({
    super.key,
    required this.aboutKey,
    required this.skillsKey,
    required this.projectsKey,
    required this.scrollController,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late List<Animation<Offset>> _slideAnimations;
  bool _isOpen = false;
  int _hoveredIndex = -1;
  void scrollToSection(GlobalKey key, scrollController) {
    final RenderObject? renderObject = key.currentContext?.findRenderObject();
    if (renderObject is RenderBox) {
      final position = renderObject.localToGlobal(Offset.zero);
      scrollController.animateTo(
        position.dy - 100, // Offset to account for app bar height
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    if (_isOpen) {
      toggleMenu();
    }
  }

  void toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Create slide animations for each nav item
    _slideAnimations = List.generate(
      4,
      (index) => Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.2 + (index * 0.1),
            0.6 + (index * 0.1),
            curve: Curves.easeOutCubic,
          ),
        ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeTransition(
            opacity: _fadeInAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-0.5, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
                ),
              ),
              child: Row(
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * 3.14159,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          "HD",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  LayoutBuilder(
                      builder: (context, constraints) {
                        double fontSize;
                        if (MediaQuery.of(context).size.width < 240) {
                          fontSize = 6; // small phone
                        }else if (MediaQuery.of(context).size.width < 360) {
                          fontSize = 8; // small phone
                        }if (MediaQuery.of(context).size.width < 390) {
                          fontSize = 9; // small phone
                        }else if (MediaQuery.of(context).size.width < 480) {
                          fontSize = 10; // small phone
                        } else if (MediaQuery.of(context).size.width < 720) {
                          fontSize = 12; // small phone
                        }else if (MediaQuery.of(context).size.width < 768) {
                          fontSize = 14; // large phone / small tablet
                        } else if (MediaQuery.of(context).size.width < 810) {
                          fontSize = 16; // large phone / small tablet
                        } else if (MediaQuery.of(context).size.width < 900) {
                          fontSize = 18; // large phone / small tablet
                        } else if (MediaQuery.of(context).size.width < 1024) {
                          fontSize = 20; // tablet
                        } else {
                          fontSize = 22; // desktop
                        }
                       return Text(
                          Strings.name,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black87,
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          ),
          // Responsive navigation
          LayoutBuilder(
            builder: (context, constraints) {
              // For mobile, show a menu icon
              if (MediaQuery.of(context).size.width < 768) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        insetPadding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 250, // Adjust as needed
                          child: AppDrawer(
                            aboutKey: widget.aboutKey,
                            skillsKey: widget.skillsKey,
                            projectsKey: widget.projectsKey,
                            scrollController: widget.scrollController,
                          ),
                        ),
                      ),
                    );
                    // Show drawer or dialog with menu items
                  },
                );
              }
                // For desktop, show the full navigation
                return Row(
                  children: [
                    GestureDetector(
                        onTap: () =>
                            scrollToSection(
                                widget.aboutKey, widget.scrollController),
                        child: _buildNavItem('About', 0)),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () =>
                          scrollToSection(
                              widget.skillsKey, widget.scrollController),
                      child: _buildNavItem('Skills', 1),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () =>
                          scrollToSection(
                              widget.projectsKey, widget.scrollController),
                      child: _buildNavItem('Projects', 2),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () =>
                          scrollToSection(
                              widget.aboutKey, widget.scrollController),
                      child: _buildNavItem('Contact', 3),
                    ),
                  ],
                );
            },
          ),
        ],
      ),
    );

    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Side: Name + Logo
                FadeTransition(
                  opacity: _fadeInAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-0.5, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
                      ),
                    ),
                    child: Row(
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _controller.value * 2 * 3.14159,
                              child: child,
                            );
                          },
                          child: Container(
                            width: isMobile ? 28 : 35,
                            height: isMobile ? 28 : 35,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade700,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Center(
                              child: Text(
                                "HD",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 180),
                          child: const Text(
                            "Hemendra Kumar Devatwal",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Right side: Navigation or Menu Icon
                if (isMobile)
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          insetPadding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 250,
                            child: AppDrawer(
                              aboutKey: widget.aboutKey,
                              skillsKey: widget.skillsKey,
                              projectsKey: widget.projectsKey,
                              scrollController: widget.scrollController,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                else
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => scrollToSection(widget.aboutKey, widget.scrollController),
                        child: _buildNavItem('About', 0),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () => scrollToSection(widget.skillsKey, widget.scrollController),
                        child: _buildNavItem('Skills', 1),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () => scrollToSection(widget.projectsKey, widget.scrollController),
                        child: _buildNavItem('Projects', 2),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () => scrollToSection(widget.aboutKey, widget.scrollController),
                        child: _buildNavItem('Contact', 3),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );

  }

  Widget _buildNavItem(String title, int index) {
    return SlideTransition(
      position: _slideAnimations[index],
      child: FadeTransition(
        opacity: _fadeInAnimation,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hoveredIndex = index),
          onExit: (_) => setState(() => _hoveredIndex = -1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _hoveredIndex == index ? Colors.blue.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _hoveredIndex == index ? Colors.blue.shade700 : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: _hoveredIndex == index ? FontWeight.bold : FontWeight.w500,
                    color: _hoveredIndex == index ? Colors.blue.shade700 : Colors.black87,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2,
                  width: _hoveredIndex == index ? 20 : 0,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double responsiveFontSize(BuildContext context, double baseFontSize) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Scale based on device width (375 = iPhone 11 base width)
    double scale = screenWidth / 375;

    // Prevent text from becoming too small or too big
    return (baseFontSize * scale).clamp(baseFontSize * 0.8, baseFontSize * 1.6);
  }
}

class AppDrawer extends StatelessWidget {
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey projectsKey;
  final ScrollController scrollController;

  const AppDrawer({
    super.key,
    required this.aboutKey,
    required this.skillsKey,
    required this.projectsKey,
    required this.scrollController,
  });

  void scrollToSection(GlobalKey key, ScrollController scrollController) {
    final RenderObject? renderObject = key.currentContext?.findRenderObject();
    if (renderObject is RenderBox) {
      final position = renderObject.localToGlobal(Offset.zero);
      scrollController.animateTo(
        position.dy,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              color: Colors.blue.shade700,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "HD",
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    Strings.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _buildDrawerItem(
              context,
              'About',
              Icons.person,
              () {
                Navigator.pop(context); // Close drawer first
                scrollToSection(aboutKey, scrollController);
              },
            ),
            _buildDrawerItem(
              context,
              'Skills',
              Icons.code,
              () {
                Navigator.pop(context);
                scrollToSection(skillsKey, scrollController);
              },
            ),
            _buildDrawerItem(
              context,
              'Projects',
              Icons.work,
              () {
                Navigator.pop(context);
                scrollToSection(projectsKey, scrollController);
              },
            ),
            _buildDrawerItem(
              context,
              'Contact',
              Icons.mail_outline,
              () {
                Navigator.pop(context);
                scrollToSection(aboutKey, scrollController);
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '© ${DateTime.now().year} ${Strings.name}}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade700),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }
}
