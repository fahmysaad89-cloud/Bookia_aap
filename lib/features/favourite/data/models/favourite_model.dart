import 'package:bookiaa/features/home/data/models/books_models.dart';

class FavouriteModel {
  final FavouriteData? data;
  final String? message;
  final int? status;

  const FavouriteModel({
    this.data,
    this.message,
    this.status,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      data: json['data'] == null
          ? null
          : FavouriteData.fromJson(json['data']),
      message: json['message'] as String?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
      'status': status,
    };
  }
}

class FavouriteData {
  final List<Products> products;

  const FavouriteData({
    this.products = const [],
  });

  factory FavouriteData.fromJson(dynamic json) {
    if (json is List) {
      return FavouriteData(
        products: json
            .map((e) => Products.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }
    if (json is Map<String, dynamic>) {
      final list = json['data'] ?? json['products'] ?? json['wishlist'];
      if (list is List) {
        return FavouriteData(
          products: list
              .map((e) => Products.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      }
    }
    return const FavouriteData(products: []);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': products.map((e) => e.toJson()).toList(),
    };
  }
}

