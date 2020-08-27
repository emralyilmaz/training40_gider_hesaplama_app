import 'package:flutter/material.dart';
import 'package:training40_gider_hesaplama_app/models/kategori.dart';
import 'package:training40_gider_hesaplama_app/tools/database_helper.dart';

class KategoriListesi extends StatefulWidget {
  @override
  _KategoriListesiState createState() => _KategoriListesiState();
}

class _KategoriListesiState extends State<KategoriListesi> {
  List<Kategori> kategoriler;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kategoriler == null) {
      kategoriler = List<Kategori>();
      // kategori listesini güncelleme işlemi yapılacak
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Kategoriler",
            style: TextStyle(color: Color.fromRGBO(3, 54, 73, 1))),
        actions: [
          FlatButton(
              onPressed: () {
                kategoriEkle();
              }, // kategori ekle
              child: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(kategoriler[index].kategoriAd),
            trailing: Icon(Icons.delete),
          );
        },
        itemCount: kategoriler.length,
      ),
    );
  }

  void kategoriListesiniGuncelle() {
    databaseHelper.kategoriListesiniGetir().then((katList) {
      setState(() {
        kategoriler = katList;
      });
    });
  }

  void kategoriEkle() {
    var formKey = GlobalKey<FormState>();
    String yeniKategoriAd;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "Kategori Ekle",
                    style: TextStyle(
                        color: Color.fromRGBO(3, 54, 73, 1), fontSize: 25),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      onSaved: (yeni) {
                        yeniKategoriAd = yeni;
                      },
                      decoration: InputDecoration(
                          labelText: "Kategori Ad",
                          border: OutlineInputBorder()),
                      validator: (girilen) {
                        if (girilen.length <= 0) {
                          return "Kategori Adını Giriniz";
                        } else
                          return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: ButtonBar(
                    children: [
                      RaisedButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              databaseHelper
                                  .kategoriEkle(
                                      Kategori(kategoriAd: yeniKategoriAd))
                                  .then((kategoriID) {
                                if (kategoriID > 0) {
                                  setState(() {
                                    kategoriListesiniGuncelle();
                                    Navigator.pop(context);
                                  });
                                }
                              });
                            }
                          },
                          child: Text(
                            "Ekle",
                          ),
                          color: Color.fromRGBO(3, 54, 73, 1)),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Vazgeç",
                        ),
                        color: Color.fromRGBO(3, 54, 73, 1),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
