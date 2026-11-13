import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/widgets/app_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteEmptyState extends StatelessWidget {
  final VoidCallback onExplore;

  const FavouriteEmptyState({
    super.key,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96.w,
              height: 96.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bookmark_outline_rounded,
                size: 46.sp,
                color: AppColors.primaryColor,
              ),
            ),
            20.verticalSpace,
            Text(
              'No Favorites Yet',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.darkColor,
              ),
            ),
            8.verticalSpace,
            Text(
              'You haven\'t saved any books to your favorites yet.\nDiscover books and bookmark your favorites!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.grayColor,
                height: 1.4,
              ),
            ),
            24.verticalSpace,
            SizedBox(
              width: 180.w,
              child: AppBotton(
                label: 'Explore Books',
                bgcolor: AppColors.primaryColor,
                textcolor: Colors.white,
                onPressed: onExplore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

