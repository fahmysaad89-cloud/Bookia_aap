import 'package:bookiaa/core/routes/app_router.dart';
import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/widgets/app_botton.dart';
import 'package:bookiaa/features/auth/presentation/ui/login_screen.dart';
import 'package:bookiaa/features/auth/presentation/ui/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        width: double.infinity.w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset("assets/images/welcome.png").image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            135.verticalSpace,
            Image.asset("assets/images/splash.png"),
            28.verticalSpace,
            Text(
              "Order Your Book Now!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: .w400,
                color: AppColors.darkColor,
              ),
            ),
            Spacer(),
            AppBotton(
              label: "login",
              bgcolor: null,
              textcolor: null,
              onPressed: () {
                context.push(const LoginScreen());
              },
            ),
            15.verticalSpace,
            AppBotton(
              label: "Register",
              bgcolor: Colors.white,
              textcolor: AppColors.darkColor,
              onPressed: () {
                context.push(const RegisterScreen());
              },
            ),
            94.verticalSpace,
          ],
        ),
      ),
    );
  }
}
