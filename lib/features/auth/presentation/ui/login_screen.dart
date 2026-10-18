import 'package:bookiaa/core/routes/app_router.dart';
import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:bookiaa/core/widgets/app_back_button.dart';
import 'package:bookiaa/core/widgets/app_botton.dart';
import 'package:bookiaa/core/widgets/app_text_field.dart';
import 'package:bookiaa/features/Forgot%20Password/presentation/ui/forgot_password_screen.dart';
import 'package:bookiaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookiaa/features/auth/presentation/ui/register_screen.dart';
import 'package:bookiaa/features/auth/presentation/ui/wedgets/redirect_text.dart';
import 'package:bookiaa/features/auth/presentation/ui/wedgets/validators.dart';
import 'package:bookiaa/features/home/presentation/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
      );
    }
  }

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
                  child: BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is LoginLogingStste) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: Center(child: CircularProgressIndicator()),
                          ),
                        );
                      } else if (state is LoginSuccessStste) {
                        context.push(const HomeScreen());
                      } else {
                        Navigator.pop(context);

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            icon: const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 45,
                            ),
                            title: const Text('Login Failed'),
                            content: const Text(
                              'Please check your email and password.',
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Try Again'),
                              ),
                            ],
                          ),
                        );

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Center(
                        //       child: Text(
                        //         'Login failed',
                        //         style: TextStyle(
                        //           fontSize: 20,
                        //           fontWeight: .bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // );
                        // showDialog(
                        //   context: context,
                        //   builder: (context) =>
                        //       AlertDialog(content: Text("Error")),
                        // );
                      }
                    },
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
                            alignment: AlignmentDirectional.centerEnd,
                            child: InkWell(
                              onTap: () {
                                context.push(const ForgotPasswordScreen());
                              },
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
                          const Spacer(),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.h, bottom: 24.h),
                              child: AuthRedirectText(
                                text: "Don’t have an account?",
                                actionText: "Register Now",
                                onTap: () =>
                                    context.push(const RegisterScreen()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
