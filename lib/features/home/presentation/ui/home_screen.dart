import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/banner_slider.dart';
import 'widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(
              onSearchTap: () {
                // TODO: navigate to search screen
              },
            ),
            25.verticalSpace,
            const BannerSlider(),
            52.verticalSpace,
            Align(
              alignment: AlignmentGeometry.topStart,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Text(
                  "Best Seller",
                  style: AppTextStyles.mainFont.copyWith(fontSize: 24),
                ),
              ),
            ),
            15.verticalSpace,
          ],
        ),
      ),
    );
  }
}
