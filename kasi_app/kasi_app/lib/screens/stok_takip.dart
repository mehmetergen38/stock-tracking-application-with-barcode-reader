import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaski_app/contstants/data.dart';
import 'package:intl/intl.dart';

import '../models/department_model.dart';
import '../models/employee_model.dart';
import '../models/warehouse_model.dart';
import '../services/database_service.dart';

class StokTakipScreen extends StatefulWidget {
  const StokTakipScreen({Key? key}) : super(key: key);

  @override
  State<StokTakipScreen> createState() => _StokTakipScreenState();
}

class _StokTakipScreenState extends State<StokTakipScreen> {
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController intialdateval = TextEditingController();
  TextEditingController productAmountController = TextEditingController();
  TextEditingController warehouseAmountController = TextEditingController();

  List<Product> barcodeList = [];

  String _scanBarcode = '';

  String? _selectedWarehouse;
  String? _selectedDepartment;
  String? _selectedEmployee;

  int wareHouseIndex = 0;
  int departmentIndex = 0;
  int employeeIndex = 0;


  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    textEditingController.text = _scanBarcode;
    _scanBarcode = 'Unknown';
    intialdateval.text = DateFormat("dd-MM-yyyy").format(DateTime.now());
  }

  Future<void> productAddDialog(String barcode) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ürün ekle'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Çıkış miktarını girin'),
                  TextField(
                    controller: productAmountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Miktar girin..",
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Onayla'),
                onPressed: () {
                  setState(() {
                    barcodeList.add(
                      Product(
                          double.parse(productAmountController.text), barcode),
                    );
                    productAmountController.text = "";
                  });
                  Navigator.of(context).pop();
                  scanBarcodeNormal();
                },
              ),
            ],
          );
        });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', false, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      barcodeList.add(Product(1, barcodeScanRes));
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Vazgeç', true, ScanMode.QR);
      textEditingController.text = barcodeScanRes;

      setState(() {
        if (barcodeScanRes != "-1") {
          productAddDialog(barcodeScanRes);
        }
        _scanBarcode = barcodeScanRes;
      });
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'vazgeç', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale("tr", "TR"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(
          () => {intialdateval.text = DateFormat('dd-MM-yyyy').format(picked)});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromRGBO(15, 101, 135, 1),
        title: Text("Stok Takip"),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint(intialdateval.text);
              debugPrint(wareHouseIndex.toString());
              debugPrint(employeeIndex.toString());
              debugPrint(departmentIndex.toString());
              debugPrint(GetStorage().read("user_id").toString());
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "İşlem Tarihi",
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                autocorrect: false,
                controller: intialdateval,
                onSaved: (value) {},
                onTap: () {
                  _selectDate();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                maxLines: 1,
                validator: (value) {},
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    size: 26,
                    color: (Color.fromRGBO(15, 101, 135, 1)),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text("Teslim alan departman"),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder(
                future: Future.delayed(Duration(seconds: 1))
                    .then((value) => _databaseService.departments()),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final List<Department> _department = snapshot.data;

                    return DropdownButton(
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          _selectedDepartment = value;
                        });
                      },
                      value: _selectedDepartment,
                      items: _department.map((map) {
                        return DropdownMenuItem(
                          child: Text(map.name),
                          value: map.name,
                          onTap: () {
                            departmentIndex = map.id;
                          },
                        );
                      }).toList(),
                      hint: Text('Daire Seçin'),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text('Veri Bulunamadı'),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Text("Teslim alan personel"),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder(
                future: Future.delayed(Duration(seconds: 1))
                    .then((value) => _databaseService.employees()),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final List<EmployeeModel> _employees = snapshot.data;

                    return DropdownButton(
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          debugPrint(value);
                          _selectedEmployee = value;
                        });
                      },
                      value: _selectedEmployee,
                      items: _employees
                          .where((i) => i.departmentId == departmentIndex)
                          .map((map) {
                        return DropdownMenuItem(
                          child: Text(map.name + " " + map.surname),
                          value: map.name + " " + map.surname,
                          onTap: () {
                            employeeIndex = map.id;
                          },
                        );
                      }).toList(),
                      hint: Text('Personel Seçin'),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text('Veri Bulunamadı'),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Text("Ambarlar"),
              FutureBuilder(
                future: Future.delayed(Duration(seconds: 1))
                    .then((value) => _databaseService.warehouses()),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final List<Warehouse> _warehouses = snapshot.data;

                    return DropdownButton(
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          _selectedWarehouse = value;
                        });
                      },
                      value: _selectedWarehouse,
                      items: _warehouses.map((map) {
                        return DropdownMenuItem(
                          child: Text(map.name),
                          value: map.name,
                          onTap: () {
                            wareHouseIndex = map.id!;
                          },
                        );
                      }).toList(),
                      hint: Text('Ambar Seçin'),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text('Veri Bulunamadı'),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => {scanBarcodeNormal()},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(360, 55),
                  backgroundColor: Colors.deepOrange,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(30),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TableWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget TableWidget() {
    if (barcodeList.length > 0) {
      return Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
            2: FixedColumnWidth(64),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: barcodeList
              .map((e) => TableRow(
                    children: [
                      /*TableRow(children :[
                        Text('Year'),
                        Text('Lang'),
                        Text('Author'),
                      ]),*/
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(e.barcode),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(e.amount.toString()),
                        ),
                      ),
                    ],
                  ))
              .toList());
    } else {
      return Container();
    }
  }
}
