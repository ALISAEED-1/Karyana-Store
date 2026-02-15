// To parse this JSON data, do
//
//     final ProductModel = ProductModelFromJson(jsonString);

import 'dart:convert';


class ProductModel {
  final String? docId;
  final String? name;
  final String? image;
  final double? prize;
  final double? discountprize;
  final String? categoryId;
  List<dynamic>? favorite;
  final int? stock;
  final String? userId;
  final int? createdAt;

  ProductModel({
    this.docId,
    this.name,
    this.image,
    this.prize,
    this.discountprize,
    this.categoryId,
    this.favorite,
    this.stock,
    this.userId,
    this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    docId: json["docId"],
    name: json["name"],
    image: json["image"],
    prize: json["prize"],
    discountprize: json["discountprize"],
    categoryId: json["categoryId"],
    favorite: json["favorite"] == null ? [] : List<dynamic>.from(json["favorite"]!.map((x) => x)),
    stock: json["stock"],
    userId: json["userId"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String docId) => {
    "docId": docId,
    "name": name,
    "image": image,
    "prize": prize,
    "discountprize": discountprize,
    "categoryId": categoryId,
    "favorite": favorite == null ? [] : List<dynamic>.from(favorite!.map((x) => x)),
    "stock": stock,
    "userId": userId,
    "createdAt": createdAt,
  };
}
