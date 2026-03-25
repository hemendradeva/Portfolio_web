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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Strings.skills,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          AnimationLimiter(
            child: Wrap(
              spacing: 12,
              runSpacing: 16,
              children: List.generate(
                skills.length,
                (index) => AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  columnCount: 4, // Approximate number of chips in a row
                  child: SlideAnimation(
                    verticalOffset: 20.0,
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

class _AnimatedSkillChipState extends State<_AnimatedSkillChip> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.blue.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.blue.shade700,
              width: 1.5,
            ),
          ),
          child: Text(
            widget.skill,
            style: TextStyle(
              fontSize: 16,
              fontWeight: _isHovered ? FontWeight.bold : FontWeight.w500,
              color: _isHovered ? Colors.blue.shade700 : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
