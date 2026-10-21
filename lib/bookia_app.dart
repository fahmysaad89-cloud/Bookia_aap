import 'package:bookiaa/core/routes/app_router.dart';
import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/services/local/local_helper.dart';
import 'package:bookiaa/core/utls/app_constans.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookiaApp extends StatelessWidget {
  const BookiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(fontFamily: "DM"),
        initialRoute: initpage(),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }

  String initpage() {
    if (LocalHelper.prefs?.getString(appconstans.UserToken) != null) {
      return AppRoutes.homeScreen;
    } else {
      return AppRoutes.welcomeScreen;
    }
  }
}
