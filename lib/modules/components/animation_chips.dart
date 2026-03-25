import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedChip extends StatefulWidget {
  final String label;
  final Color baseColor;
  final Color textColor;
  final Color hoverColor;
  final Color hoverTextColor;
  final VoidCallback? onTap;
  final AnimationStyle animationStyle;

  const AnimatedChip({
    super.key,
    required this.label,
    this.baseColor = Colors.blueAccent,
    this.textColor = Colors.white,
    this.hoverColor = Colors.blueAccent,
    this.hoverTextColor = Colors.black,
    this.onTap,
    this.animationStyle = AnimationStyle.scale,
  });

  @override
  State<AnimatedChip> createState() => _AnimatedChipState();
}

enum AnimationStyle { scale, pulse, bounce, shimmer, rotate }

class _AnimatedChipState extends State<AnimatedChip> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // For pulse animation, start auto-animation
    if (widget.animationStyle == AnimationStyle.pulse) {
      _controller.repeat(reverse: true);
    }
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
        if (widget.animationStyle != AnimationStyle.pulse) {
          _controller.forward();
        }
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        if (widget.animationStyle != AnimationStyle.pulse) {
          _controller.reverse();
        }
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: _buildAnimatedChip(),
      ),
    );
  }

  Widget _buildAnimatedChip() {
    switch (widget.animationStyle) {
      case AnimationStyle.scale:
        return _buildScaleChip();
      case AnimationStyle.pulse:
        return _buildPulseChip();
      case AnimationStyle.bounce:
        return _buildBounceChip();
      case AnimationStyle.shimmer:
        return _buildShimmerChip();
      case AnimationStyle.rotate:
        return _buildRotateChip();
    }
  }

  Widget _buildScaleChip() => ScaleTransition(
        scale: _scaleAnimation,
        child: _buildChip(),
      );

  Widget _buildPulseChip() => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.scale(
          scale: 1.0 + (_controller.value * 0.05),
          child: _buildChip(),
        ),
      );

  Widget _buildBounceChip() => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, -_controller.value * 5),
          child: _buildChip(),
        ),
      );

  Widget _buildShimmerChip() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) => LinearGradient(
            colors: [
              widget.baseColor.withOpacity(0.3),
              widget.baseColor.withOpacity(0.8),
              widget.baseColor.withOpacity(0.3),
            ],
            stops: [
              0.0,
              _controller.value,
              1.0,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: _buildChip(),
        );
      },
    );
  }

  Widget _buildRotateChip() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.rotate(
        angle: _rotationAnimation.value * math.pi,
        child: _buildChip(),
      ),
    );
  }

  Widget _buildChip() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Chip(
        label: Text(
          widget.label,
          style: TextStyle(
            color: _isHovered ? widget.hoverTextColor : widget.textColor,
            fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: _isHovered ? widget.hoverColor.withOpacity(0.8) : widget.baseColor.withOpacity(0.2),
        elevation: _isHovered ? 4 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: _isHovered ? widget.hoverColor : Colors.transparent,
            width: 1,
          ),
        ),
      ),
    );
  }
}
