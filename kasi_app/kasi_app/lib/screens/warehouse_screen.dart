import 'package:flutter/material.dart';
import 'package:kaski_app/contstants/data.dart';
import '../models/warehouse_model.dart';
import '../services/database_service.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class WarehouseScreen extends StatefulWidget {
  const WarehouseScreen({Key? key}) : super(key: key);

  @override
  State<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  TextEditingController _controller = TextEditingController();

  final DatabaseService _databaseService = DatabaseService();

  /*Future<void> _onSave() async {
    final name = _controller.text;
    await _databaseService.insertWarehouse(Warehouse(name: name));
  }*/

  late SwipeActionController controller;

  @override
  void initState() {
    super.initState();
    controller = SwipeActionController(selectedIndexPathsChangeCallback:
        (changedIndexPaths, selected, currentCount) {
      setState(() {});
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Depo Ekle'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Depo Adı',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            /*TextButton(
              child: const Text('Ekle'),
              onPressed: () {
                setState(() {
                  _onSave();
                  _controller.text = "";
                });
                Navigator.of(context).pop();
              },
            ),*/
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var isSelected = false;
    Color mycolor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 101, 135, 1),
        title: Text('Depolar'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showMyDialog();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Warehouse>>(
        future: _databaseService.warehouses(),
        // function where you call your api
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return SwipeActionCell(
                  controller: controller,
                  index: index,

                  // Required!
                  key: ValueKey(snapshot.data![index]),

                  /// Animation default value below
                  // normalAnimationDuration: 400,
                  // deleteAnimationDuration: 400,
                  selectedForegroundColor: Colors.black.withAlpha(30),
                  trailingActions: [
                    SwipeAction(
                        title: "Sil",
                        style: TextStyle(fontSize: 15),
                        performsFirstActionWithFullSwipe: true,
                        nestedAction: SwipeNestedAction(title: "Onayla"),

                        onTap: (handler) async {
                          await handler(true);
                          //list.removeAt(index);
                          setState(() {});
                          (() {});
                        }),
                    SwipeAction(
                        title: "Düzenle",
                        style: TextStyle(fontSize: 15),
                        color: Colors.grey,
                        onTap: (handler) {}),
                  ],
                  child: Container(
                    color: mycolor,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(snapshot.data![index].id.toString()),
                      ),
                      title: Text(snapshot.data![index].name),
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
