import 'package:bookiaa/core/routes/app_router.dart';
import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:bookiaa/core/widgets/app_back_button.dart';
import 'package:bookiaa/core/widgets/app_botton.dart';
import 'package:bookiaa/core/widgets/app_text_field.dart';
import 'package:bookiaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookiaa/features/auth/presentation/ui/login_screen.dart';
import 'package:bookiaa/features/auth/presentation/ui/wedgets/redirect_text.dart';
import 'package:bookiaa/features/auth/presentation/ui/wedgets/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _register() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        name: _usernameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
        password_confirmation: _confirmCtrl.text.trim(),
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
                      if (state is RegisterLodingState) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const AlertDialog(
                            content: Row(
                              children: [
                                CircularProgressIndicator(
                                  color: Color(0xFF6C4DDA),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  'Loading...',
                                  style: TextStyle(fontWeight: .bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state is RegisterSuccessState) {
                        Navigator.pushNamed(context, AppRoutes.loginScreen);
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
                            title: const Text('register Failed'),
                            content: const Text(
                              'Please check your data.',
                              style: TextStyle(fontWeight: .bold),
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
                      }
                    },
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppBackButton(),
                          28.verticalSpace,
                          Text(
                            "Hello! Register to get started",
                            style: AppTextStyles.mainFont,
                          ),
                          32.verticalSpace,
                          AppTextField(
                            hint: "Username",
                            controller: _usernameCtrl,
                            textInputAction: TextInputAction.next,
                            validator: Validators.username,
                          ),
                          12.verticalSpace,
                          AppTextField(
                            hint: "Email",
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: Validators.email,
                          ),
                          12.verticalSpace,
                          AppTextField(
                            hint: "Password",
                            controller: _passCtrl,
                            isPassword: true,
                            textInputAction: TextInputAction.next,
                            validator: Validators.password,
                          ),
                          12.verticalSpace,
                          AppTextField(
                            hint: "Confirm password",
                            controller: _confirmCtrl,
                            isPassword: true,
                            textInputAction: TextInputAction.done,
                            validator: (v) =>
                                Validators.confirmPassword(v, _passCtrl.text),
                          ),
                          30.verticalSpace,
                          AppBotton(
                            label: "Register",
                            bgcolor: null,
                            textcolor: null,
                            onPressed: _register,
                          ),
                          const Spacer(),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 27.h),
                              child: AuthRedirectText(
                                text: "Already have an account?",
                                actionText: "Login Now",
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.loginScreen,
                                  );
                                },
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
