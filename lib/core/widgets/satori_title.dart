import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:test_ai/core/utils/text_styles.dart';
import 'package:test_ai/core/widgets/blue_dot.dart';

class SatoriTitle extends StatefulWidget {
  const SatoriTitle({super.key});

  @override
  State<SatoriTitle> createState() => _SatoriTitleState();
}

class _SatoriTitleState extends State<SatoriTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SATORI AI',
              style: TextStyles.bold48,
            ),
            const Gap(8),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: BlueDot(radius: 6),
            ),
          ],
        ),
      ),
    );
  }
}