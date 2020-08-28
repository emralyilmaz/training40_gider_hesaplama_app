import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training40_gider_hesaplama_app/tools/database_helper.dart';
import 'package:training40_gider_hesaplama_app/models/kategori.dart';
import 'package:intl/intl.dart';
import 'package:training40_gider_hesaplama_app/models/harcama.dart';

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
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    tumKategoriler = List<Kategori>();
    databaseHelper.kategoriListesiniGetir().then((katList) {
      tumKategoriler = katList;
      setState(() {});
    });
  }

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
                onChanged: (ad) {
                  harcamaAd = ad;
                },
                decoration: InputDecoration(
                    hintText: "Harcamanız için başlık giriniz.",
                    labelText: "Başlık",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                onChanged: (aciklama) {
                  harcamaAciklama = aciklama;
                },
                maxLines: 3, // 3 satırlık açıklama alanı oluşturuldu
                decoration: InputDecoration(
                    hintText: "Harcamanız için başlık giriniz.",
                    labelText: "Açıklama",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                onChanged: (tutar) {
                  harcamaTutar = int.parse(tutar);
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ], // klavyeden de sadece rakamların kullanılması zorlanmıs oluyor.
                decoration: InputDecoration(
                    hintText: "Harcamanız için başlık giriniz.",
                    labelText: "Tutar",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2025))
                      .then((t) {
                    setState(() {
                      harcamaTarih = t;
                    });
                  });
                },
                child: Container(
                  child: Center(
                    child: Text(harcamaTarih == null
                        ? "Harcama Tarihini Giriniz."
                        : DateFormat.yMd().format(harcamaTarih)),
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromRGBO(205, 179, 128, 1))),
                ),
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
                          onChanged: (kategoriId) {
                            setState(() {
                              kategoriID = kategoriId;
                            });
                          })),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly, // butonlar arası boşluk
              children: [
                RaisedButton(
                    child: Text("Kaydet"),
                    color: Color.fromRGBO(3, 54, 73, 1),
                    onPressed: () {
                      databaseHelper.harcamaEkle(Harcama(
                          harcamaAd: harcamaAd,
                          harcamaAciklama: harcamaAciklama,
                          harcamaTutar: harcamaTutar,
                          harcamaTarih: harcamaTarih.toString(),
                          kategoriID: kategoriID));
                      Navigator.pop(context);
                    }),
                RaisedButton(
                    child: Text("Vazgeç"),
                    color: Color.fromRGBO(3, 54, 73, 1),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> kategoriItemOlustur() {
    return tumKategoriler
        .map((kategori) => DropdownMenuItem<int>(
            value: kategori.kategoriID,
            child: Center(
              child: Text(
                kategori.kategoriAd,
                style: TextStyle(fontSize: 15),
              ),
            )))
        .toList();
  }
}
