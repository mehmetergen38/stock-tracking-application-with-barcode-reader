import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}


class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 101, 135, 1),
        title: Text('Hesabım'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Align(alignment:Alignment.center),
            Padding(padding: EdgeInsetsDirectional.all(30)),
            const SizedBox(
              width: 50,
            ),
            const CircleAvatar(
              backgroundImage:
                  AssetImage("assets/images/profile-picture.jpg"),
              radius: 75,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              GetStorage().read('username'),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 54,
              width: 327,
              decoration: BoxDecoration(
                color: Color.fromRGBO(15, 101, 135, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                  GetStorage().read("email"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400)),
            ),
            /*const SizedBox(
              height: 40,
            ),
            Container(
              height: 54,
              width: 327,
              decoration: BoxDecoration(
                color: Color.fromRGBO(15, 101, 135, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: const Text(
                  textAlign: TextAlign.center,
                  "Sicil No: 549856",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400)),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 54,
              width: 327,
              decoration: BoxDecoration(
                color: Color.fromRGBO(15, 101, 135, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                  textAlign: TextAlign.center,
                  "Telefon No: 5362364895",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400)),
            ),*/

          ],
        ),
      ),
    );
  }
}
