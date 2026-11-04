import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/services/local/local_helper.dart';
import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/utls/app_constans.dart';
import 'package:bookiaa/core/widgets/app_botton.dart';
import 'package:bookiaa/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

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
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Are you sure you want \nto logout?"),
                content: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: AppBotton(
                          onPressed: () {
                            LocalHelper.prefs?.remove(appconstans.UserToken);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.loginScreen,
                              (route) => false,
                            );
                          },
                          label: 'Confirm',
                          bgcolor: Colors.transparent,
                          textcolor: AppColors.darkColor,
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: AppBotton(
                          onPressed: () => Navigator.pop(context),
                          label: 'Cancel',
                          bgcolor: AppColors.primaryColor,
                          textcolor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          icon: Assets.icons.profileLogout.svg(height: 22, width: 22),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }
}
