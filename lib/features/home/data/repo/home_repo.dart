import 'package:bookiaa/core/networking/api_endpoint.dart';
import 'package:bookiaa/core/networking/dio_factory.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  static Future<booksmodels?>? getBestSellerBooks() async {
    try {
      final response = await DioFactory.dio?.get(ApiEndpoint.bestseller);

      if (response?.statusCode == 200) {
        booksmodels books = booksmodels.fromJson(response?.data);
        return books;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Products?>?> search(String text) async {
    try {
      final response = await DioFactory.dio?.get(
        ApiEndpoint.search,
        queryParameters: {"name": text},
      );
      if (response?.statusCode == 200) {
        booksmodels booksModel = booksmodels.fromJson(response?.data);
        return booksModel.data?.products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
