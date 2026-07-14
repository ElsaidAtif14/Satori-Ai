import 'package:flutter/material.dart';
import 'package:test_ai/core/utils/app_colors.dart';

class BlueDot extends StatefulWidget {
  final double radius;
  final Color color;
  final Duration duration; // إضافة إمكانية التحكم في سرعة الطفي والنور

  const BlueDot({
    super.key, 
    this.radius = 5.0, 
    this.color = AppColors.primary,
    this.duration = const Duration(milliseconds: 800), // القيمة الافتراضية للسرعة
  });

  @override
  State<BlueDot> createState() => _BlueDotState();
}

class _BlueDotState extends State<BlueDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // الأنميشن هيغير الشافية من 0.2 (مطفية شبه اختفاء) إلى 1.0 (منورة بالكامل)
    _opacityAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // تشغيل الأنميشن بشكل مستمر رايح جاي (تطفي وتنور تلقائياً)
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    // استخدمنا FadeTransition لأنها خفيفة جداً في الـ Performance ومخصصة لتغيير الـ Opacity
    return FadeTransition(
      opacity: _opacityAnimation,
      child: CircleAvatar(
        radius: widget.radius,
        backgroundColor: widget.color,
      ),
    );
  }

  @override
  void dispose() {
    // مهم جداً نقفل الـ controller عشان نمنع أي Memory Leak
    _controller.dispose();
    super.dispose();
  }
}