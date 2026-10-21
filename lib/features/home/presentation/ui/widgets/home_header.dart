import 'package:bookiaa/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.onSearchTap});

  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Assets.images.splash.image(width: 99.w, height: 30.h),
        SizedBox(width: 6.w),
        const Spacer(),
        IconButton(
          onPressed: onSearchTap,
          icon: Assets.icons.searchNormal.svg(),
        ),
      ],
    );
  }
}
