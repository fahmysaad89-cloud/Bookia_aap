import 'package:bookiaa/bookia_app.dart';
import 'package:bookiaa/core/networking/dio_factory.dart';
import 'package:bookiaa/core/services/local/local_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocalHelper.init();
  DioFactory.init();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: BookiaApp(),
    ),
  );
}
