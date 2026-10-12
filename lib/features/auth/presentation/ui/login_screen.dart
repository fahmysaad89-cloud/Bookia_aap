import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome back! Glad to see you, Again!",
                style: AppTextStyles.mainFont,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
