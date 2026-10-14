import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? size;

  const AppBackButton({super.key, this.onPressed, this.size});

  @override
  Widget build(BuildContext context) {
    final boxSize = size ?? 41.w;

    return Material(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onPressed ?? () => Navigator.of(context).maybePop(),
        child: Container(
          width: boxSize,
          height: boxSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22.sp,
            color: AppColors.darkColor,
          ),
        ),
      ),
    );
  }
}
