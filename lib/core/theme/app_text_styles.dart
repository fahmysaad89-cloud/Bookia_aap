import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  TextStyle mainFont = TextStyle(
    fontSize: 30, //.sp,
    fontWeight: .w400,
    color: AppColors.darkColor,
  );
  TextStyle tittelScreenFont = TextStyle(
    fontSize: 24, //.sp,
    color: AppColors.darkColor,
    fontWeight: .w400,
  );
  TextStyle hintTextFont = TextStyle(
    fontSize: 16, //.sp,
    color: AppColors.grayColor,
    fontWeight: .w400,
  );
}
