import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;

class AppTextStyles {
  static TextStyle mainFont = TextStyle(
    fontSize: 30.sp,
    fontWeight: .w400,
    color: AppColors.darkColor,
  );
  static TextStyle tittelScreenFont = TextStyle(
    fontSize: 24.sp,
    color: AppColors.darkColor,
    fontWeight: .w400,
  );
  static TextStyle hintTextFont = TextStyle(
    fontSize: 16.sp,
    color: AppColors.grayColor,
    fontWeight: .w400,
  );
}
