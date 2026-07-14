import 'package:flutter/material.dart';
import 'package:test_ai/core/utils/app_colors.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account?',
          style: TextStyle(fontSize: 12, color: Color(0xff8B909F)),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            ' Create Account',
            style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}