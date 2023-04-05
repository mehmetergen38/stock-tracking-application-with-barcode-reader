import 'package:flutter/material.dart';
import 'package:kaski_app/models/product_model.dart';

import '../services/database_service.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 101, 135, 1),
        title: Text('Ürünler'),
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
                List<ProductModel>? data = snapshot.data;
                return ListView(
                  children: data!.map((e) =>
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(e.id.toString()),
                        ),
                        title: Text(e.productName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.productType),
                            Text(e.productCode),
                          ],
                        ),
                        trailing: Text(e.unit),
                      )).toList(),
                );
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },

          // Future that needs to be resolved
          // inorder to display something on the Canvas
          future: _databaseService.products(),
        ),
      ),
    );
  }
}
