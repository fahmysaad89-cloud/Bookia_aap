import 'package:bookiaa/core/networking/api_endpoint.dart';
import 'package:dio/dio.dart';

class DioFactory {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(baseUrl: ApiEndpoint.baseurl));
  }
}
