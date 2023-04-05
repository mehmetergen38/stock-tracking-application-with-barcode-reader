import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaski_app/screens/home.dart';

import '../models/employee_model.dart';
import '../services/database_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final box = GetStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = "ergenm11@gmail.com";
    passwordController.text = "1234";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 101, 135, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 101, 135, 1),
        title: Text("Stok Takip Uygulaması"),
      ),
      body: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsetsDirectional.all(50)),
              const SizedBox(
                width: 50,
                height: 20,
              ),
              Image.asset(
                "assets/images/logo.jpg",
                cacheHeight: 350,
                cacheWidth: 400,
              ),
              const SizedBox(
                height: 50,
              ),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "E-Posta:",
                    contentPadding: EdgeInsets.only(left: 12),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  // true ise girilen yazıyı gizler. şifre gizlemede kullanılır.
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Parola:",
                    contentPadding: EdgeInsets.only(left: 12),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(160, 55),
                  backgroundColor: Color.fromRGBO(146, 211, 237, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  "Giriş Yap",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login()  async {
    String email = emailController.text;
    int password = int.parse(passwordController.text);

    EmployeeModel employee =  await _databaseService.login(email, password);

    if (employee.id != null) {

      box.write("username", employee.name + " " + employee.surname);
      box.write("department_id", employee.departmentId);
      box.write("user_id", employee.id);
      box.write("email", employee.email);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      debugPrint("Kullanıcı Bulunamadı!");
    }
  }
}
