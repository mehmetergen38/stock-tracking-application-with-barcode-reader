import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:kaski_app/contstants/data.dart';

import '../contstants/data.dart';
import '../models/warehouse_model.dart';

class WarehouseCountingScreen extends StatefulWidget {
  const WarehouseCountingScreen({Key? key}) : super(key: key);

  @override
  State<WarehouseCountingScreen> createState() =>
      _WarehouseCountingScreenState();
}

class _WarehouseCountingScreenState extends State<WarehouseCountingScreen> {
  List<Warehouse> warehouseList = DummyData().items;
  TextEditingController intialdateval = TextEditingController();
  TextEditingController textEditingController = new TextEditingController();
  String _scanBarcode = '';

  List<Product> barcodeList = [];

  Warehouse? _selectedWarehouse;

  @override
  void initState() {
    super.initState();
    textEditingController.text = _scanBarcode;
    _scanBarcode = 'Unknown';
    intialdateval.text = DateFormat("dd-MM-yyyy").format(DateTime.now());
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

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Vazgeç', true, ScanMode.QR);
      //textEditingController.text = barcodeScanRes;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;

      if (barcodeScanRes != '-1') {
        final foundProduct =
            barcodeList.where((element) => element.barcode == barcodeScanRes);
        if (foundProduct.isNotEmpty) {
          foundProduct.first.amount++;
        } else {
          barcodeList.add(Product(1, barcodeScanRes));
        }

        scanBarcodeNormal();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 101, 135, 1),
        title: Text('Stok Sayım'),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "İşlem Tarihi",
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              autocorrect: false,
              controller: intialdateval,
              onSaved: (value) {},
              onTap: () {
                _selectDate();
              },
              maxLines: 1,
              validator: (value) {},
              decoration: InputDecoration(
                labelText: 'Tarih seçin.',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Depolar"),
            DropdownButton<Warehouse>(
              value: _selectedWarehouse,
              onChanged: (value) {
                setState(() {
                  _selectedWarehouse = value;
                });
              },
              hint: Text(
                "Depo Seçin",
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              isExpanded: true,
              items: warehouseList
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Container(
                        child: Text(
                          e.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => {scanBarcodeNormal()},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("Sayıma Başla"),
                ),
              ],
            ),
            Expanded(
                child: ListView(
              children: barcodeList
                  .map((e) => ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.do_not_disturb_on_total_silence),
                        ),
                        title: Text("Miktar : " + e.amount.toString()),
                        subtitle: Text("Barkod No : " + e.barcode),
                      ))
                  .toList(),
            ))
          ],
        ),
      ),
    );
  }
}
