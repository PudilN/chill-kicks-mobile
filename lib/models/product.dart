// To parse this JSON data, do
//
//     final newsEntry = newsEntryFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String id;
  int? userId;
  String name;
  int price;
  String description;
  String thumbnail;
  String category;
  bool isFeatured;
  String brand;
  String size;
  String color;
  dynamic releaseDate;
  int reviews;

  Product({
    required this.id,
    required this.userId,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.brand,
    required this.size,
    required this.color,
    required this.releaseDate,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    thumbnail: json["thumbnail"],
    category: json["category"],
    isFeatured: json["is_featured"],
    brand: json["brand"],
    size: json["size"],
    color: json["color"],
    releaseDate: json["release_date"],
    reviews: json["reviews"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "price": price,
    "description": description,
    "thumbnail": thumbnail,
    "category": category,
    "is_featured": isFeatured,
    "brand": brand,
    "size": size,
    "color": color,
    "release_date": releaseDate,
    "reviews": reviews,
  };
}
