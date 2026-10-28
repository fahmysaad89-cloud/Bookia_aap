class Bookdetails {
  Data? data;
  String? message;
  int? status;

  Bookdetails({this.data, this.message, this.status});

  Bookdetails.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    message = json["message"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (data != null) {
      result["data"] = data?.toJson();
    }
    result["message"] = message;
    result["status"] = status;
    return result;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  int? stock;
  int? bestSeller;
  String? price;
  int? discount;
  double? priceAfterDiscount;
  String? image;
  String? category;

  Data({
    this.id,
    this.name,
    this.description,
    this.stock,
    this.bestSeller,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.image,
    this.category,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    stock = json["stock"];
    bestSeller = json["best_seller"];
    price = json["price"];
    discount = json["discount"];
    priceAfterDiscount = json["price_after_discount"];
    image = json["image"];
    category = json["category"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result["id"] = id;
    result["name"] = name;
    result["description"] = description;
    result["stock"] = stock;
    result["best_seller"] = bestSeller;
    result["price"] = price;
    result["discount"] = discount;
    result["price_after_discount"] = priceAfterDiscount;
    result["image"] = image;
    result["category"] = category;
    return result;
  }
}
