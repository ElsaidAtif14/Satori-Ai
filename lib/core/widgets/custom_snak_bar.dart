import 'package:flutter/material.dart';
import 'package:test_ai/core/utils/app_colors.dart';
import 'package:test_ai/core/utils/text_styles.dart';

void showCustomSnackBar(BuildContext context, {required String message, Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message, 
        style: TextStyles.regular14.copyWith(color: Colors.white), // لضمان وضوح النص
      ),
      backgroundColor: backgroundColor ?? AppColors.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}