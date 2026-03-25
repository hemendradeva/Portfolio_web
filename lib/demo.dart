// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:portfolio/components/animated_chip.dart'; // Import the AnimatedChip component
//
// void main() => runApp(const PortfolioApp());
//
// class PortfolioApp extends StatelessWidget {
//   const PortfolioApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Hemendra Kumar Devatwal Portfolio',
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color(0xFF0E0E2C),
//         textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
//       ),
//       home: const PortfolioHomePage(),
//     );
//   }
// }
//
// class PortfolioHomePage extends StatefulWidget {
//   const PortfolioHomePage({super.key});
//
//   @override
//   State<PortfolioHomePage> createState() => _PortfolioHomePageState();
// }
//
// class _PortfolioHomePageState extends State<PortfolioHomePage> {
//   final ScrollController _scrollController = ScrollController();
//   bool _showScrollToTop = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _scrollController.addListener(() {
//       setState(() {
//         _showScrollToTop = _scrollController.offset > 300;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       floatingActionButton: _showScrollToTop
//           ? FloatingActionButton(
//         onPressed: () {
//           _scrollController.animateTo(
//             0,
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.easeOut,
//           );
//         },
//         backgroundColor: Colors.blueAccent,
//         child: const Icon(Icons.arrow_upward, color: Colors.black),
//       )
//           : null,
//       body: Stack(
//         children: [
//           // Background animated gradient
//           _AnimatedBackground(),
//
//           // Main content
//           SingleChildScrollView(
//             controller: _scrollController,
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
//             child: AnimationLimiter(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: AnimationConfiguration.toStaggeredList(
//                   duration: const Duration(milliseconds: 600),
//                   childAnimationBuilder: (widget) => SlideAnimation(
//                     verticalOffset: 50.0,
//                     child: FadeInAnimation(child: widget),
//                   ),
//                   children: [
//                     const _Header(),
//                     const SizedBox(height: 60),
//                     _HeroSection(size: size),
//                     const SizedBox(height: 20),
//                     const Center(child: _ScrollIndicator()),
//                     const _AnimatedDivider(),
//                     const _SkillsSection(),
//                     const _AnimatedDivider(),
//                     const _StatsSection(),
//                     const _AnimatedDivider(),
//                     const _ProjectsSection(),
//                     const _AnimatedDivider(),
//                     const _AboutSection(),
//                     const _AnimatedDivider(),
//                     const _ContactSection(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Background animation
// class _AnimatedBackground extends StatefulWidget {
//   @override
//   State<_AnimatedBackground> createState() => _AnimatedBackgroundState();
// }
//
// class _AnimatedBackgroundState extends State<_AnimatedBackground> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 10),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Container(
//           decoration: BoxDecoration(
//             gradient: RadialGradient(
//               center: Alignment(_controller.value * 0.2, _controller.value * 0.2),
//               radius: 1.0 + (_controller.value * 0.5),
//               colors: const [
//                 Color(0xFF1a1a40),
//                 Color(0xFF0E0E2C),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// // Header with animated menu items
// class _Header extends StatelessWidget {
//   const _Header();
//
//   @override
//   Widget build(BuildContext context) {
//     final menuItems = ['About', 'Skills', 'Projects', 'Contact'];
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // Logo with animation
//         TweenAnimationBuilder<double>(
//           tween: Tween(begin: 0.8, end: 1.0),
//           duration: const Duration(seconds: 1),
//           curve: Curves.elasticOut,
//           builder: (context, value, child) {
//             return Transform.scale(
//               scale: value,
//               child: child,
//             );
//           },
//           child: const Text(
//               "Hemendra Kumar Devatwal",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
//           ),
//         ),
//
//         // Menu items with hover animation
//         Row(
//           children: List.generate(
//             menuItems.length,
//                 (index) => Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: _AnimatedNavItem(title: menuItems[index]),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // Animated Nav Item
// class _AnimatedNavItem extends StatefulWidget {
//   final String title;
//   const _AnimatedNavItem({required this.title});
//
//   @override
//   State<_AnimatedNavItem> createState() => _AnimatedNavItemState();
// }
//
// class _AnimatedNavItemState extends State<_AnimatedNavItem> with SingleTickerProviderStateMixin {
//   bool _isHovered = false;
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200),
//     );
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//         onEnter: (_) {
//       setState(() {
//         _isHovered = true;
//       });
//       _controller.forward();
//     },
//     onExit: (_) {
//     setState(() {
//     _isHovered = false;
//     });
//     _controller.reverse();
//     },
//     cursor: SystemMouseCursors.click,
//     child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//     Text(
//     widget.title,
//     style: TextStyle(
//     fontSize: 16,
//     color: _isHovered ? Colors.blueAccent : Colors.white,
//     ),
//     ),
//     AnimatedBuilder(
//     animation: _animation,
//     builder: (context, child) {
//     return ClipRect(
//     child: SizedBox(
//     height: 2,
//     width: 40 * _animation.value,
//     child: Container(
//     color: Colors.blueAccent,
//     ),
//     ),
//     );
//     },
