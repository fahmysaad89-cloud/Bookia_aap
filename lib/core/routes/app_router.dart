import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/features/Forgot%20Password/presentation/ui/forgot_password_screen.dart';
import 'package:bookiaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookiaa/features/auth/presentation/ui/login_screen.dart';
import 'package:bookiaa/features/auth/presentation/ui/register_screen.dart';
import 'package:bookiaa/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookiaa/features/home/presentation/ui/home_screen.dart';
import 'package:bookiaa/features/welcome/presentation/ui/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.welcomeScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case AppRoutes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: LoginScreen(),
          ),
        );

      case AppRoutes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: RegisterScreen(),
          ),
        );
      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit()..getsellerbooks(),
            child: HomeScreen(),
          ),
        );

      case AppRoutes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());

      // case AppRoutes.searchScreen:
      //   return MaterialPageRoute(builder: (_) => searchScreen());
    }
  }
}

// extension NavigationExtension on BuildContext {
//   void push(Widget pages) {
//     Navigator.push(this, MaterialPageRoute(builder: (context) => pages));
//   }
// }
