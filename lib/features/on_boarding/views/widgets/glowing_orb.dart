import 'package:flutter/material.dart';

class GlowingOrb extends StatefulWidget {
  final double size;
  final Color color;

  const GlowingOrb({
    super.key, 
    this.size = 120.0, 
    this.color = const Color(0xFF00FFFF), // نفس اللون اللبني اللي في الصورة
  });

  @override
  State<GlowingOrb> createState() => _GlowingOrbState();
}

class _GlowingOrbState extends State<GlowingOrb> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // تحكم في سرعة الأنميشن من الـ duration (هنا ثانيتين)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // التكرار رايح جاي عشان يدي إيحاء النبض

    // الأنيميشن هيغير الحجم أو قيمة التوهج من 0.4 إلى 1.0
    _animation = Tween<double>(begin: 0.9, end: 1.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // الـ RadialGradient هو السر اللي بيعمل الضوء المتدرج للخارج
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.5,
              colors: [
                widget.color, // النقطة القوية اللي في المركز
                widget.color.withOpacity(0.6 * _animation.value), // التوهج الوسيط
                widget.color.withOpacity(0.2 * _animation.value), // التوهج الضعيف الخارجي
                Colors.transparent, // نهاية التوهج عشان يختفي تماماً
              ],
              // توزيع نسب الألوان بناءً على قيمة الأنيميشن الحالية
              stops: [0.0, 0.2, 0.7 * _animation.value, 1.0],
            ),
          ),
          child: Center(
            // النقطة الصغيرة الثابتة أو القوية اللي في السنتر بالظبط
            child: Container(
              width: widget.size * 0.08,
              height: widget.size * 0.08,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.color,
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}