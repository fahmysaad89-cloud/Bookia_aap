import 'package:bookiaa/core/networking/api_endpoint.dart';
import 'package:bookiaa/core/networking/dio_factory.dart';
import 'package:bookiaa/features/favourite/data/models/favourite_model.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:dio/dio.dart';

class FavouriteRepo {
  static Future<List<Products>?> getFavourites() async {
    try {
      final response = await DioFactory.dio?.get(ApiEndpoint.wishlist);

      if (response?.statusCode == 200 && response?.data != null) {
        final favouriteModel = FavouriteModel.fromJson(response!.data);
        return favouriteModel.data?.products ?? [];
      } else {
        return null;
      }
    } on DioException {
      rethrow;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> removeFromFavourite(int productId) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoint.removeFromWishlist,
        data: {'product_id': productId},
      );

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException {
      rethrow;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addToFavourite(int productId) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoint.addToWishlist,
        data: {'product_id': productId},
      );

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException {
      rethrow;
    } catch (e) {
      return false;
    }
  }
}

