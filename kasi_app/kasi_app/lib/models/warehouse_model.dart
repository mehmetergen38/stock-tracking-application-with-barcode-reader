// To parse this JSON data, do
//
//     final warehouse = warehouseFromJson(jsonString);

import 'dart:convert';

Warehouse warehouseFromJson(String str) => Warehouse.fromJson(json.decode(str));

String warehouseToJson(Warehouse data) => json.encode(data.toJson());

class Warehouse {
  Warehouse({
    required this.id,
    required this.name,
  });

  int? id;
  String name;

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
