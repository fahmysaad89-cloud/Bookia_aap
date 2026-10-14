import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthRedirectText extends StatefulWidget {
  final String text; // Don't have an account?
  final String actionText; // Register Now
  final VoidCallback onTap;

  const AuthRedirectText({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  State<AuthRedirectText> createState() => _AuthRedirectTextState();
}

class _AuthRedirectTextState extends State<AuthRedirectText> {
  late final TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = widget.onTap;
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '${widget.text} ',
        style: AppTextStyles.mainFont.copyWith(fontSize: 15),

        children: [
          TextSpan(
            text: widget.actionText,
            style: const TextStyle(color: AppColors.primaryColor),
            recognizer: _recognizer,
          ),
        ],
      ),
    );
  }
}
