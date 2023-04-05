import 'package:flutter/material.dart';
import 'package:kaski_app/models/share_screen.dart';
import 'package:kaski_app/screens/account_screen.dart';
import 'package:kaski_app/screens/dashboard_screen.dart';
import 'package:kaski_app/screens/login_screen.dart';
import 'package:kaski_app/screens/product_screen.dart';
import 'package:kaski_app/screens/stok_takip.dart';
import 'package:kaski_app/screens/transaction_screen.dart';
import 'package:kaski_app/screens/warehouse_counting_screen.dart';
import 'package:kaski_app/screens/warehouse_screen.dart';
import '../widgets/ana_menu_parametrik.dart';
import '../models/share_screen.dart';
import '../models/setting_screen.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController( //controller for TabBar
        length: 2, //lenght of tabs in TabBar
        child: MaterialApp(
          home: HomeScreen(),
        )
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 101, 135, 1),
        title: Text("Stok Takip Uygulaması"),
      ),
      body: SafeArea(
        child: GridView.count(

          primary: false,
          padding: const EdgeInsets.all(8),
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          crossAxisCount: 2,
          children: <Widget>[
            /*GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dashboard()),
                );
              },
              child: MenuCustomListItem(
                Color.fromRGBO(228, 237, 146, 1.0),
                const Icon(
                  Icons.insert_chart_outlined,
                  size: 42,
                  color: Color.fromRGBO(34, 111, 142, 1),
                ),
                const Text(
                  "GÖSTERGE PANELİ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(34, 111, 142, 1),
                  ),
                ),
              ),
            ),*/
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StokTakipScreen()),
                );
              },
              child: MenuCustomListItem(
                Color.fromRGBO(135, 176, 217, 1.0),
                const Icon(
                  Icons.input_sharp,
                  size: 42,
                  color: Color.fromRGBO(15, 101, 135, 1),
                ),
                const Text(
                  "ÇIKIŞ",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(15, 101, 135, 1)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransactionScreen()),
                );
              },
              child: MenuCustomListItem(
                Color.fromRGBO(109, 175, 167, 1.0),
                const Icon(
                  Icons.list_alt,
                  size: 42,
                  color: Color.fromRGBO(18, 90, 118, 1),
                ),
                const Text(
                  "TÜM İŞLEMLER",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(18, 90, 118, 1)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WarehouseCountingScreen()),
                );
              },
              child: MenuCustomListItem(
                Color.fromRGBO(109, 175, 112, 1.0),
                Icon(
                  Icons.inventory_outlined,
                  size: 42,
                  color: Color.fromRGBO(12, 81, 106, 1),
                ),
                Text(
                  "STOK SAYIM",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(12, 81, 106, 1)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WarehouseScreen()),
                );
              },
              child: MenuCustomListItem(
                Color.fromRGBO(139, 210, 142, 1.0),
                Icon(
                  Icons.account_balance_outlined,
                  size: 42,
                  color: Color.fromRGBO(12, 81, 106, 1),
                ),
                Text(
                  "DEPOLAR",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(12, 81, 106, 1)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductScreen()),
                );
              },
              child: MenuCustomListItem(
                Color.fromRGBO(228, 237, 146, 1.0),
                const Icon(
                  Icons.insert_chart_outlined,
                  size: 42,
                  color: Color.fromRGBO(34, 111, 142, 1),
                ),
                Text(
                  "Ürünler",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(12, 81, 106, 1)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountScreen()),
                );
              },
              child: MenuCustomListItem(
                  Color.fromRGBO(197, 197, 113, 1.0),
                Icon(
                  Icons.account_box,
                  size: 42,
                  color: Color.fromRGBO(12, 81, 106, 1),
                ),
                Text(
                  "HESABIM",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(12, 81, 106, 1)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShareScreen()),
                );
              },
              child: MenuCustomListItem(
                Color.fromRGBO(224, 175, 154, 1.0),
                Icon(
                  Icons.calculate,
                  size: 42,
                  color: Color.fromRGBO(12, 81, 106, 1),
                ),
                Text(
                  "HESAP MAKİNESİ",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(12, 81, 106, 1)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingScreen()),
                );
              },
              child: MenuCustomListItem(
                Color.fromRGBO(168, 106, 95, 1.0),
                Icon(
                  Icons.settings_sharp,
                  size: 42,
                  color: Color.fromRGBO(12, 81, 106, 1),
                ),
                Text(
                  "AYARLAR",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(12, 81, 106, 1)),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
