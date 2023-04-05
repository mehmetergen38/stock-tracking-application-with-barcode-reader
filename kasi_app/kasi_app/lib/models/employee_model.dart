// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  EmployeeModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.departmentId,
  });

  int id;
  String name;
  String surname;
  String email;
  int password;
  int departmentId;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    id: json["id"],
    name: json["name"],
    surname: json["surname"],
    email: json["email"],
    password: json["password"],
    departmentId: json["department_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "email": email,
    "password": password,
    "department_id": departmentId,
  };
}
