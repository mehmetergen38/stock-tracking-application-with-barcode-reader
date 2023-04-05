import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:kaski_app/contstants/data.dart';
import 'package:kaski_app/models/employee_model.dart';
import 'package:kaski_app/models/product_model.dart';
import 'package:kaski_app/models/transaction_model.dart';
import 'package:kaski_app/models/warehouse_model.dart';
import 'package:kaski_app/models/department_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  /*static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();*/

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'stoktakip.db');

    final exist = await databaseExists(path);

    if (exist) {
      print("Veritabanı var");
      return await openDatabase(
        path,
      );
    } else {
      print("Veritabanı yok. Transfer yapılacak.");

      try {
        await Directory(dirname(path)).create(recursive: true);

        ByteData data =
        await rootBundle.load(join("assets", "stoktakip.db"));
        List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        await File(path).writeAsBytes(bytes, flush: true);

      } catch (_) {

      }
    }
    return await openDatabase(
      path,
    );

    /*return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );*/
  }

  /*Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE departments(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
    );
    await db.execute(
      'CREATE TABLE warehouses(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
    );
    await db.execute(
      'CREATE TABLE transactions(id INTEGER PRIMARY KEY AUTOINCREMENT, barcodeNumber text,amount float,transactionDate timestamp,departmentName text,warehouseName text,employeeName text)',
    );
  }*/

  Future<EmployeeModel> login(email,password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
    await db.query('employees', where: 'email = ? and password = ?', whereArgs: [email,password]);
    return EmployeeModel.fromJson(maps[0]);
  }

  Future<void> insertWarehouse(Warehouse warehouse) async {
    final db = await database;
    await db.insert(
      'warehouses',
      warehouse.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertDepartment(Department department) async {
    final db = await database;
    await db.insert(
      'departments',
      department.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertTransaction(TransactionModel transactionModel) async {
    final db = await database;
    await db.insert(
      'transactions',
      transactionModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProductModel>> products() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(
        maps.length, (index) => ProductModel.fromJson(maps[index]));
  }

  Future<List<EmployeeModel>> employees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('employees');
    return List.generate(
        maps.length, (index) => EmployeeModel.fromJson(maps[index]));
  }

  Future<List<TransactionModel>> transactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(
        maps.length, (index) => TransactionModel.fromJson(maps[index]));
  }

  Future<TransactionModel> transaction(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('transactions', where: 'id = ?', whereArgs: [id]);
    return TransactionModel.fromJson(maps[0]);
  }

  Future<List<Warehouse>> warehouses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('warehouses');
    return List.generate(
        maps.length, (index) => Warehouse.fromJson(maps[index]));
  }

  Future<Warehouse> warehouse(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('warehouses', where: 'id = ?', whereArgs: [id]);
    return Warehouse.fromJson(maps[0]);
  }

  Future<List<Department>> departments() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('departments');
    return List.generate(
        maps.length, (index) => Department.fromJson(maps[index]));
  }

  Future<void> updateWarehouse(Warehouse warehouse) async {
    final db = await database;

    await db.update(
      'warehouses',
      warehouse.toJson(),
      where: 'id = ?',
      whereArgs: [warehouse.id],
    );
  }

  Future<void> updateTransaction(TransactionModel transactionModel) async {
    final db = await database;

    await db.update(
      'transactions',
      transactionModel.toJson(),
      where: 'id = ?',
      whereArgs: [transactionModel.id],
    );
  }

  Future<void> updateDepartment(Department department) async {
    final db = await database;
    await db.update('departments', department.toJson(),
        where: 'id = ?', whereArgs: [department.id]);
  }

  Future<void> deleteTransaction(int id) async {
    final db = await database;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteWarehouse(int id) async {
    final db = await database;
    await db.delete(
      'warehouses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteDepartment(int id) async {
    final db = await database;
    await db.delete('departments', where: 'id = ?', whereArgs: [id]);
  }

  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE Customer ("
        "id INTEGER PRIMARY KEY,"
        "first_name TEXT,"
        "last_name TEXT,"
        "email TEXT"
        ")");
  }
}
