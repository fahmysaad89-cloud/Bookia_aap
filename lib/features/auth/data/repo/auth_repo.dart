import 'package:bookiaa/core/networking/api_endpoint.dart';
import 'package:bookiaa/core/networking/dio_factory.dart';
import 'package:bookiaa/core/services/local/local_helper.dart';
import 'package:bookiaa/core/utls/app_constans.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthRepo {
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final Response = await DioFactory.dio?.post(
        ApiEndpoint.login,
        data: {"email": email, "password": password},
      );

      if (Response?.statusCode == 200) {
        String? token = Response?.data["data"]["token"];
        saveToken(token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static saveToken(String? token) async {
    await LocalHelper.prefs?.setString(appconstans.UserToken, token ?? "");
  }

  static Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String password_confirmation,
  }) async {
    try {
      final Response = await DioFactory.dio?.post(
        ApiEndpoint.register,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": password_confirmation,
        },
      );

      if (Response?.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
