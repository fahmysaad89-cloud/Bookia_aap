import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.onSearchTap});

  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 13),
      child: Row(
        children: [
          Image.asset('assets/images/bookicon.png', width: 24.w, height: 24.w),
          SizedBox(width: 6.w),
          Text(
            'Bookia',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onSearchTap,
            icon: Icon(Icons.search, size: 26.sp),
          ),
        ],
      ),
    );
  }
}
