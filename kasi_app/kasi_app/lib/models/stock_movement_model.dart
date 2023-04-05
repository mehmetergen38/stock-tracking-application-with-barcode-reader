// To parse this JSON data, do
//
//     final stockMovementModel = stockMovementModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StockMovementModel stockMovementModelFromJson(String str) => StockMovementModel.fromJson(json.decode(str));

String stockMovementModelToJson(StockMovementModel data) => json.encode(data.toJson());

class StockMovementModel {
  StockMovementModel({
    required this.id,
    required this.productId,
    required this.amount,
    required this.plugId,
  });

  int id;
  int productId;
  int amount;
  int plugId;

  factory StockMovementModel.fromJson(Map<String, dynamic> json) => StockMovementModel(
    id: json["id"],
    productId: json["product_id"],
    amount: json["amount"],
    plugId: json["plug_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "amount": amount,
    "plug_id": plugId,
  };
}
