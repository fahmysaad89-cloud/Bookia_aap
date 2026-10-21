import 'package:bookiaa/core/networking/api_endpoint.dart';
import 'package:bookiaa/core/networking/dio_factory.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  static getBestSellerBooks() async {
    try {
      final Response = await DioFactory.dio?.get(ApiEndpoint.bestseller);

      if (Response?.statusCode == 200) {
        booksmodels books = booksmodels.fromJson(Response?.data);
        return books;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
