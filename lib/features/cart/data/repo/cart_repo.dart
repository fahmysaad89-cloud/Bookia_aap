import 'package:bookiaa/core/networking/api_endpoint.dart';
import 'package:bookiaa/core/networking/dio_factory.dart';
import 'package:bookiaa/features/cart/data/models/cart_response.dart';

class CartRepo {
  static Future<CartData?> getCartData() async {
    try {
      final response = await DioFactory.dio?.get(ApiEndpoint.cart);
      if ((response?.statusCode == 200 || response?.statusCode == 201) &&
          response?.data != null) {
        CartResponse cart = CartResponse.fromJson(response!.data);
        return cart.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Backward compatible alias
  // ignore: non_constant_identifier_names
  static Future<CartData?>? GetCartData() => getCartData();

  static Future<CartData?> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoint.updateCart,
        data: {
          "cart_item_id": cartItemId,
          "quantity": quantity,
        },
      );
      if ((response?.statusCode == 200 || response?.statusCode == 201) &&
          response?.data != null) {
        CartResponse cart = CartResponse.fromJson(response!.data);
        return cart.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<CartData?> removeFromCart(int cartItemId) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoint.removeFromCart,
        data: {
          "cart_item_id": cartItemId,
        },
      );
      if ((response?.statusCode == 200 || response?.statusCode == 201) &&
          response?.data != null) {
        CartResponse cart = CartResponse.fromJson(response!.data);
        return cart.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
