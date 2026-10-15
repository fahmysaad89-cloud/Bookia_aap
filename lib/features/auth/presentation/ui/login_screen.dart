import 'package:bookiaa/core/routes/app_router.dart';
import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:bookiaa/core/widgets/app_back_button.dart';
import 'package:bookiaa/core/widgets/app_botton.dart';
import 'package:bookiaa/core/widgets/app_text_field.dart';
import 'package:bookiaa/features/auth/presentation/ui/register_screen.dart';
import 'package:bookiaa/features/auth/presentation/ui/wedgets/redirect_text.dart';
import 'package:bookiaa/features/auth/presentation/ui/wedgets/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailCtrl.text.trim();
      final password = _passCtrl.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBackButton(),
                  29.verticalSpace,
                  Text(
                    "Welcome back! Glad\nto see you, Again!",
                    style: AppTextStyles.mainFont,
                  ),
                  32.verticalSpace,
                  AppTextField(
                    hint: "Enter your email",
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: Validators.email,
                  ),

                  15.verticalSpace,
                  AppTextField(
                    hint: "Enter your password",
                    controller: _passCtrl,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    validator: Validators.password,
                  ),
                  13.verticalSpace,
                  Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Forgot Password?",
                        style: AppTextStyles.hintTextFont.copyWith(
                          color: AppColors.darkGrayColor,
                        ),
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  AppBotton(
                    label: "Login",
                    bgcolor: null,
                    textcolor: null,
                    onPressed: _login,
                  ),
                  285.verticalSpace,
                  Center(
                    child: AuthRedirectText(
                      text: "Don’t have an account?",
                      actionText: "Register Now",
                      onTap: () => context.push(const RegisterScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
