import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? leadingIcon;  // للـ Google Logo مثلاً
  final Widget? trailingIcon; // للـ Arrow السهم مثلاً
  final double? width;
  final bool hasShadow;

  const CustomActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.hasShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    // حسابات الـ Responsiveness بناءً على حجم الشاشة
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    
    // تحديد قيم افتراضية متجاوبة لو متبعتش قيم مخصصة
    final defaultWidth = width ?? screenWidth * 0.95; // %85 من عرض الشاشة
    final defaultHeight = screenWidth * 0.13;        // ارتفاع نسبي مرن (حوالي 48-56 بكسل)
    final borderRadius = screenWidth * 0.035;         // حواف دائرية متناسقة (حوالي 14-16 بكسل)

    return Container(
      width: defaultWidth,
      height: defaultHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: (backgroundColor ?? const Color(0xFF1E75EC)).withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 12,
                  offset: const Offset(0, 6), // اتجاه الـ Shadow لتحت زي الصورة
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF1E75EC), // اللون الأزرق الافتراضي
          foregroundColor: textColor ?? Colors.white,
          elevation: 0, // بنعتمد على boxShadow اللي في الـ Container للتحكم الأدق
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: backgroundColor == Colors.white 
                ? const BorderSide(color: Color(0xE0E0E0E0), width: 1) // حدود خفيفة لزرار جوجل لو الخلفية بيضاء
                : BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingIcon != null) ...[
              leadingIcon!,
              SizedBox(width: screenWidth * 0.03), // مسافة متجاوبة بين الأيقونة والنص
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            if (trailingIcon != null) ...[
              SizedBox(width: screenWidth * 0.02),
              trailingIcon!,
            ],
          ],
        ),
      ),
    );
  }
}