import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key, this.onLogoutTap});

  final VoidCallback? onLogoutTap;

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF7F8FA),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        'Profile',
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.darkColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onLogoutTap,
          icon: Assets.icons.profileLogout.svg(height: 22, width: 22),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }
}
