import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import '../services/database_service.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {

  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 101, 135, 1),
        title: Text('İşlemler'),
      ),
      body: Container(
        child: FutureBuilder(
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );

              } else if (snapshot.hasData) {

                List<TransactionModel>? data = snapshot.data;
                return Padding(padding: EdgeInsets.all(12),child: ListView(
                  children: data!.map((e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Barkod No : "+e.barcodeNumber),
                      Text("Departman : "+e.departmentName),
                      Text("Personel : "+e.employeeName),
                      Text("Ambar : "+e.warehouseName),
                      Text("Miktar : "+e.amount.toString()),
                    ],)).toList(),
                ),);
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },

          // Future that needs to be resolved
          // inorder to display something on the Canvas
          future: _databaseService.transactions(),
        ),
      ),
    );
  }
}
