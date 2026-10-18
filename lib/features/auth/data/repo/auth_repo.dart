import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthRepo {
  static Dio dio = Dio();

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final Response = await dio.post(
        "https://codingarabic.eraapro.com/api/login",
        data: {"email": email, "password": password},
      );

      if (Response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String password_confirmation,
  }) async {
    try {
      final Response = await dio.post(
        "https://codingarabic.eraapro.com/api/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": password_confirmation,
        },
      );

      if (Response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
