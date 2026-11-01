import 'package:bookiaa/features/profile/presentation/ui/wedget/profile_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [ProfileAppBar(onLogoutTap: () {})]);
  }
}
