import 'package:meta/meta.dart';
import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    this.id,
    required this.barcodeNumber,
    required this.amount,
    required this.transactionDate,
    required this.departmentName,
    required this.warehouseName,
    required this.employeeName,
  });

  int? id;
  String barcodeNumber;
  double amount;
  DateTime transactionDate;
  String departmentName;
  String warehouseName;
  String employeeName;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    id: json["id"],
    barcodeNumber: json["barcodeNumber"],
    amount: json["amount"].toDouble(),
    transactionDate: DateTime.parse(json["transactionDate"]),
    departmentName: json["departmentName"],
    warehouseName: json["warehouseName"],
    employeeName: json["employeeName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "barcodeNumber": barcodeNumber,
    "amount": amount,
    "transactionDate": transactionDate.toIso8601String(),
    "departmentName": departmentName,
    "warehouseName": warehouseName,
    "employeeName": employeeName,
  };
}
