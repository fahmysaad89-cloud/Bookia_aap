class CartResponse {
  final CartData? data;
  final String? message;
  final int? status;

  const CartResponse({this.data, this.message, this.status});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      data: json['data'] == null
          ? null
          : CartData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      status: json['status'] as int?,
    );
  }
}

class CartData {
  final int? id;
  final CartUser? user;
  final String? total;
  final List<CartItem> cartItems;

  const CartData({this.id, this.user, this.total, this.cartItems = const []});

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'] as int?,
      user: json['user'] == null
          ? null
          : CartUser.fromJson(json['user'] as Map<String, dynamic>),
      total: json['total']?.toString(),
      cartItems: (json['cart_items'] as List<dynamic>? ?? [])
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CartUser {
  final int? userId;
  final String? userName;

  const CartUser({this.userId, this.userName});

  factory CartUser.fromJson(Map<String, dynamic> json) {
    return CartUser(
      userId: json['user_id'] as int?,
      userName: json['user_name'] as String?,
    );
  }
}

class CartItem {
  final int? itemId;
  final int? itemProductId;
  final String? itemProductName;
  final String? itemProductImage;
  final String? itemProductPrice;
  final int? itemProductDiscount;
  final double? itemProductPriceAfterDiscount;
  final int? itemProductStock;
  final int itemQuantity;
  final double? itemTotal;

  const CartItem({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductImage,
    this.itemProductPrice,
    this.itemProductDiscount,
    this.itemProductPriceAfterDiscount,
    this.itemProductStock,
    this.itemQuantity = 1,
    this.itemTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemId: json['item_id'] as int?,
      itemProductId: json['item_product_id'] as int?,
      itemProductName: json['item_product_name'] as String?,
      itemProductImage: json['item_product_image'] as String?,
      itemProductPrice: json['item_product_price']?.toString(),
      itemProductDiscount: json['item_product_discount'] as int?,
      itemProductPriceAfterDiscount:
          (json['item_product_price_after_discount'] as num?)?.toDouble(),
      itemProductStock: json['item_product_stock'] as int?,
      itemQuantity: (json['item_quantity'] as int?) ?? 1,
      itemTotal: (json['item_total'] as num?)?.toDouble(),
    );
  }
}
