import 'package:flutter/material.dart';
import 'package:training40_gider_hesaplama_app/tools/database_helper.dart';
import 'package:training40_gider_hesaplama_app/models/kategori.dart';

class HarcamaEkle extends StatefulWidget {
  final String baslik;
  HarcamaEkle({this.baslik});

  @override
  _HarcamaEkleState createState() => _HarcamaEkleState();
}

class _HarcamaEkleState extends State<HarcamaEkle> {
  var formKey = GlobalKey<FormState>();

  List<Kategori> tumKategoriler;
  DatabaseHelper databaseHelper;
  int kategoriID = 1;
  String harcamaAd;
  String harcamaAciklama;
  int harcamaTutar;
  DateTime harcamaTarih;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding:
          false, // oluşma ihitmali olan taşmaları yok eder.
      appBar: AppBar(
        title: Text(widget.baslik),
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Harcamanız için başlık giriniz.",
                    labelText: "Başlık",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                maxLines: 3, // 3 satırlık açıklama alanı oluşturuldu
                decoration: InputDecoration(
                    hintText: "Açıklama giriniz giriniz.",
                    labelText: "Başlık",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Harcamanız için başlık giriniz.",
                    labelText: "Tutar",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Harcamanız için başlık giriniz.",
                    labelText: "Tarih",
                    border: OutlineInputBorder()),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Color.fromRGBO(3, 54, 73, 1), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: DropdownButtonHideUnderline(
                  child: tumKategoriler.length <= 0
                      ? CircularProgressIndicator()
                      : DropdownButton<int>(
                          items: kategoriItemOlustur(),
                          value: kategoriID,
                          onChanged: null)),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly, // butonlar arası boşluk
              children: [
                RaisedButton(
                    child: Text("Kaydet"),
                    color: Color.fromRGBO(3, 54, 73, 1),
                    onPressed: () {}),
                RaisedButton(
                    child: Text("Vazgeç"),
                    color: Color.fromRGBO(3, 54, 73, 1),
                    onPressed: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
