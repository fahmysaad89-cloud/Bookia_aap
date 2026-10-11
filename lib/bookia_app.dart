import 'package:bookiaa/core/routes/app_router.dart';
import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

class BookiaApp extends StatelessWidget {
  const BookiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.loginScreen,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
