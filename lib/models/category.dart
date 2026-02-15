// To parse this JSON data, do
//
//     final CategoryModel = CategoryModelFromJson(jsonString);

import 'dart:convert';


class CategoryModel {
  final String? docId;
  final String? categoryname;
  final String? image;
  final int? createdAt;

  CategoryModel({
    this.docId,
    this.categoryname,
    this.image,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    docId: json["docId"],
    categoryname: json["categoryname"],
    image: json["text"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String docId) => {
    "docId": docId,
    "categoryname": categoryname,
    "image": image,
    "createdAt": createdAt,
  };
}
