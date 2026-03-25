import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Create particles
    for (int i = 0; i < 30; i++) {
      _particles.add(Particle(
        position: Offset(
          _random.nextDouble() * 1000,
          _random.nextDouble() * 1000,
        ),
        size: 5 + _random.nextDouble() * 10,
        speed: 0.2 + _random.nextDouble() * 0.5,
        angle: _random.nextDouble() * pi * 2,
        color: Colors.blue.withOpacity(0.1 + _random.nextDouble() * 0.1),
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.blue.shade50,
              ],
            ),
          ),
        ),

        // Animated particles
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: ParticlePainter(
                particles: _particles,
                progress: _controller.value,
              ),
              size: Size.infinite,
            );
          },
        ),

        // Content
        widget.child,
      ],
    );
  }
}

class Particle {
  Offset position;
  double size;
  double speed;
  double angle;
  Color color;

  Particle({
    required this.position,
    required this.size,
    required this.speed,
    required this.angle,
    required this.color,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      // Update position based on progress
      final dx = cos(particle.angle) * particle.speed * progress * size.width;
      final dy = sin(particle.angle) * particle.speed * progress * size.height;

      final position = Offset(
        (particle.position.dx + dx) % size.width,
        (particle.position.dy + dy) % size.height,
      );

      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
