// To parse this JSON data, do
//
//     final UsersModel = UsersModelFromJson(jsonString);

import 'dart:convert';


class UsersModel {
  final String? docId;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final int? createdAt;

  UsersModel({
    this.docId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.createdAt,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
    docId: json["docId"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String docId) => {
    "docId": docId,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "createdAt": createdAt,
  };
}
