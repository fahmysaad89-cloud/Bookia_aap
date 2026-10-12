import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBotton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? bgcolor;
  final Color? textcolor;
  final bool isLoading;
  const AppBotton({
    super.key,
    required this.label,
    this.onPressed,
    required this.bgcolor,
    required this.textcolor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    return InkWell(
      onTap: enabled ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: 56.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgcolor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          label,
          style: AppTextStyles.hintTextFont.copyWith(
            color: textcolor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
