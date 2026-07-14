import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyles {
  static TextStyle bold48 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 48.sp,
  );
  static const TextStyle regular14 = TextStyle(fontSize: 14);
  static TextStyle semiBold28 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w500,
  );
}
