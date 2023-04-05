// To parse this JSON data, do
//
//     final department = departmentFromJson(jsonString);

import 'dart:convert';

Stok stokFromJson(String str) => Stok.fromJson(json.decode(str));

String stokToJson(Stok data) => json.encode(data.toJson());

class Stok {
  Stok({
    required this.islem_tarihi,
    required this.teslim_alan_departman,
  });

  int islem_tarihi;
  String teslim_alan_departman;

  factory Stok.fromJson(Map<String, dynamic> json) => Stok(
    islem_tarihi: json["işlem tarihi"],
    teslim_alan_departman: json["teslim alan departman"],
  );

  Map<String, dynamic> toJson() => {
    "işlem tarihi": islem_tarihi,
    "teslim alan departman": teslim_alan_departman,
  };
}