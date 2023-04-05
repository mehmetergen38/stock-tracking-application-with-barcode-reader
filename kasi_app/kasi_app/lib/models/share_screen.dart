import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ShareScreen extends StatefulWidget {
  @override
  State createState() => new ShareScreenState();
}

class ShareScreenState extends State<ShareScreen> {
  var num1 = 0,
      num2 = 0,
      sum = 0;

  //kullanıcıdan verileri text fortmatında almamız için bunu kullanıyoruz..
  TextEditingController t1 = new TextEditingController(text: "0");
  TextEditingController t2 = new TextEditingController(text: "0");

  //toplama yapan fonksiyon
  void toplama() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      sum = num1 + num2;
    });
  }

  //çıkarma yapan fonksiyon
  void cikarma() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      sum = num1 - num2;
    });
  }

  //çarpma yapan fonksiyon
  void carpma() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      sum = num1 * num2;
    });
  }

  //bölme yapan fonksiyon
  void bolme() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      //eger 2.sayı 0 'sa bu işlemi alarm vererek uyarıyoruz ve yapmıyoruz..
      if (num2 == 0) {
        Alert(context: context,
            title: "O'A BÖLME HATASI",
            desc: "BİR SAYIYI 0'A BÖLEMEZSİNİZ").show();
      }
      else
        sum = num1 ~/ num2;
    });
  }

  //verileri silen fonksiyon
  void sil() {
    setState(() {
      t1.text = "0";
      t2.text = "0";
      sum = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(15, 101, 135, 1),
        title: new Text("Hesap Makinesi"),
      ),
      body: new Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Text(
              "Sonuç : $sum",
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            new TextField(
              //kullanıcıdan birinci sayıyı alıyoruz.
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(hintText: "Birinci sayıyı girin"),
              controller: t1,
            ),
            new TextField(
              //kullanıcıdan 2.sayıyı alıyoruz.
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(hintText: "İkinci sayıyı girin"),
              controller: t2,
            ),
            //girilen degerlerle butonlar arasına boşluk ekliyoruz.
            new Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            new Row(
              //buraya satır koyarak toplama ve çıkarma işlemlerinin oldugu butonları koyuyoruz.
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new MaterialButton(
                  child: new Text("+"),highlightColor: Color.fromRGBO(15, 101, 135, 1),
                  color: Colors.blue,
                  //basıldıgında toplama fonksiyonuna gidip orada işlemleri yapıyor.
                  onPressed: toplama,
                ),
                new MaterialButton(
                  child: new Text("-"),
                  color: Colors.blue,
                  //basıldıgında cikarma fonksiyonuna gidip orada işlemleri yapıyor.
                  onPressed: cikarma,
                ),
              ],
            ),
            new Row(
              //yeni bir satır açarak silme butonunu yerleştirdim.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new MaterialButton(
                  child: new Text("Temizle"),
                  color: Colors.blue,
                  //basıldıgında sil fonksiyonuna gidip orada işlemleri yapıyor.
                  onPressed: sil,
                ),
              ],
            ),
            new Row(
              //yeni bir satır oluştururarak çarpma ve bölme işlemlerinin butonlarını yerleştiriyoruz.
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new MaterialButton(
                  child: new Text("*"),
                  color: Colors.blue,
                  //basıldıgında carpma fonksiyonuna gidip orada işlemleri yapıyor.
                  onPressed: carpma,
                ),
                new MaterialButton(
                  child: new Text("/"),
                  color: Colors.blue,
                  //basıldıgında bolme fonksiyonuna gidip orada işlemleri yapıyor.
                  onPressed: bolme,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}