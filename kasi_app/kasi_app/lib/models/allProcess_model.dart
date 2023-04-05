// To parse this JSON data, do
//
//     final department = departmentFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

AllProcess allProcessesFromJson(String str) => AllProcess.fromJson(json.decode(str));

String allProcessesToJson(AllProcess data) => json.encode(data.toJson());

class AllProcess {
  AllProcess({
    required this.id,
    required this.name,
    required this.insertDate,
    required this.stokId,
    required this.departmentId,
    required this.warehouseId,
    required this.amount,
  });

  int id;
  String name;
  DateTime insertDate;
  int stokId;
  int departmentId;
  int warehouseId;
  int amount;

  factory AllProcess.fromJson(Map<String, dynamic> json) => AllProcess(
      id: json["id"],
      name: json["name"],
      insertDate: json["insertDate"],
      stokId: json["stokId"],
      departmentId: json["departmentId"],
      warehouseId: json["warehouseId"],
      amount: json["amount"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "insertDate": insertDate,
    "stokId": stokId,
    "departmentId": departmentId,
    "warehouseId": warehouseId,
    "amount": amount
  };
}