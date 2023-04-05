// To parse this JSON data, do
//
//     final plugModel = plugModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PlugModel plugModelFromJson(String str) => PlugModel.fromJson(json.decode(str));

String plugModelToJson(PlugModel data) => json.encode(data.toJson());

class PlugModel {
  PlugModel({
    required this.id,
    required this.plugNumber,
    required this.type,
    required this.inputOutputWarehouseId,
    required this.createdBy,
    required this.createdAt,
    required this.departmentId,
    required this.employeeId,
  });

  int id;
  String plugNumber;
  String type;
  String inputOutputWarehouseId;
  int createdBy;
  DateTime createdAt;
  int departmentId;
  int employeeId;

  factory PlugModel.fromJson(Map<String, dynamic> json) => PlugModel(
    id: json["id"],
    plugNumber: json["plug_number"],
    type: json["type"],
    inputOutputWarehouseId: json["input_output_warehouse_id"],
    createdBy: json["created_by"],
    createdAt: json["created_at"],
    departmentId: json["department_id"],
    employeeId: json["employee_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plug_number": plugNumber,
    "type": type,
    "input_output_warehouse_id": inputOutputWarehouseId,
    "created_by": createdBy,
    "created_at": createdAt,
    "department_id": departmentId,
    "employee_id": employeeId,
  };
}
