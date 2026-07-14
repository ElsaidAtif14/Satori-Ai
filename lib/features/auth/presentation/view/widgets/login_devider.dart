import 'package:flutter/material.dart';
import 'package:test_ai/core/utils/app_colors.dart';
import 'package:test_ai/core/utils/text_styles.dart';

class LoginDevider extends StatelessWidget {
  final String text;

  const LoginDevider({super.key, this.text = 'or'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.divider, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              text,
              style: TextStyles.regular14.copyWith(color: AppColors.divider),
            ),
          ),
          const Expanded(
            child: Divider(color: AppColors.divider, thickness: 1),
          ),
        ],
      ),
    );
  }
}
