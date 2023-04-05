import '../models/department_model.dart';
import '../models/warehouse_model.dart';
import '../models/allProcess_model.dart';

class DummyData {
  List<Warehouse> items = [
    Warehouse(id: 1, name: 'İçmesuyu Dairesi'),
    Warehouse(id: 2, name: 'Kanalizasyon Dairesi'),
    Warehouse(id: 3, name: 'Abone Hizmetleri Dairesi'),
    Warehouse(id: 4, name: 'Bilgi İşlem Dairesi'),
  ];

  List<Department> departments = [
    Department(id: 1, name: 'Bilgi İşlem Departmanı'),
    Department(id: 2, name: 'Yapı Birimleri Departmanı'),
    Department(id: 3, name: 'Abone İşlemleri Departmanı'),
  ];

  /*List<Barcode> barcode = [
    Barcode(id: 1, name: '2135448512'),
    Barcode(id: 2, name: '154879465312')
  ];*/

  /*List<Tables> tables = [
    Tables(barcodeNo: 5613155131, productName: 'Macbook Air', amount: 20),
    Tables(barcodeNo: 5613155131, productName: 'Macbook Air', amount: 20),
    Tables(barcodeNo: 5613155131, productName: 'Macbook Air', amount: 20),
    Tables(barcodeNo: 5613155131, productName: 'Macbook Air', amount: 20),
  ];*/
/*List<AllProcess> allProcessesList = [
    AllProcess(id: 1, name: 'test', insertDate: new DateTime(1,1,2021),stokId: 1,departmentId: 1,warehouseId: 1,amount: 10)
  ];*/
}

class Barcode {
  final int id;
  final String name;

  Barcode({required this.id, required this.name});
}

class Tables {
  final int barcodeNo;
  final String productName;
  final int amount;
  final String product;
  final String amountValue;

  Tables(
      {required this.barcodeNo,
      required this.productName,
      required this.amount,
      required this.product,
      required this.amountValue});
}

class Product {
  String barcode;
  double amount;

  Product(this.amount, this.barcode);
}

class warehouse {
  double amount;

  warehouse(this.amount);
}
