// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.account,
    required this.unit,
    required this.productType,
  });

  int id;
  String productName;
  String productCode;
  String account;
  String unit;
  String productType;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    productName: json["product_name"],
    productCode: json["product_code"],
    account: json["account"],
    unit: json["unit"],
    productType: json["product_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "product_code": productCode,
    "account": account,
    "unit": unit,
    "product_type": productType,
  };
}
