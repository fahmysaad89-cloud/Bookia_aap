import 'package:bookiaa/core/routes/app_router.dart';
import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:bookiaa/core/widgets/app_back_button.dart';
import 'package:bookiaa/core/widgets/app_botton.dart';
import 'package:bookiaa/core/widgets/app_text_field.dart';
import 'package:bookiaa/features/auth/presentation/ui/login_screen.dart';
import 'package:bookiaa/features/auth/presentation/ui/wedgets/redirect_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBackButton(),
                      30.verticalSpace,
                      Text("Forgot Password?", style: AppTextStyles.mainFont),
                      10.verticalSpace,
                      Text(
                        "Don't worry! It occurs. Please enter the email address linked with your account.",
                        style: AppTextStyles.hintTextFont,
                      ),
                      30.verticalSpace,
                      AppTextField(hint: "Enter your email"),
                      38.verticalSpace,
                      AppBotton(
                        label: "Send Code",
                        bgcolor: null,
                        textcolor: null,
                      ),
                      const Spacer(),
                      Center(
                        child: AuthRedirectText(
                          text: "Remember Password?",
                          actionText: "Login",
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.loginScreen);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
