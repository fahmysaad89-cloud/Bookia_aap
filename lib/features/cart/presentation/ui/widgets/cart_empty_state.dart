import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/widgets/app_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartEmptyState extends StatelessWidget {
  final VoidCallback onStartShopping;

  const CartEmptyState({super.key, required this.onStartShopping});

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
                Icons.shopping_bag_outlined,
                size: 46.sp,
                color: AppColors.primaryColor,
              ),
            ),
            20.verticalSpace,
            Text(
              'Your Cart is Empty',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.darkColor,
              ),
            ),
            8.verticalSpace,
            Text(
              'Looks like you haven\'t added any books yet.\nExplore our store and find your next read!',
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
                onPressed: onStartShopping,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

