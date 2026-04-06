import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio/strings.dart';

class SkillsSection extends StatelessWidget {
  final Key widgetKey;

  const SkillsSection({super.key, required this.widgetKey});

  @override
  Widget build(BuildContext context) {
    const skills = ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'GetX', 'BLoC', 'Provider'];

    return Container(
      key: widgetKey,
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Strings.skills,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),

          AnimationLimiter(
            child: Wrap(
              spacing: 16,
              runSpacing: 20,
              children: List.generate(
                skills.length,
                    (index) => AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  columnCount: 4,
                  child: SlideAnimation(
                    verticalOffset: 30,
                    child: FadeInAnimation(
                      child: _AnimatedSkillChip(skill: skills[index]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedSkillChip extends StatefulWidget {
  final String skill;

  const _AnimatedSkillChip({required this.skill});

  @override
  State<_AnimatedSkillChip> createState() => _AnimatedSkillChipState();
}

class _AnimatedSkillChipState extends State<_AnimatedSkillChip>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },

      child: ScaleTransition(
        scale: _scaleAnimation,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),

          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),

            /// 🔥 Dynamic Gradient
            gradient: _isHovered
                ? const LinearGradient(
              colors: [Colors.blueAccent, Colors.pinkAccent],
            )
                : LinearGradient(
              colors: [
                Colors.white.withOpacity(0.08),
                Colors.white.withOpacity(0.02),
              ],
            ),

            border: Border.all(
              color: _isHovered
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.1),
            ),

            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ]
                : [],
          ),

          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _isHovered ? Colors.white : Colors.white70,
            ),
            child: Text(widget.skill),
          ),
        ),
      ),
    );
  }
}