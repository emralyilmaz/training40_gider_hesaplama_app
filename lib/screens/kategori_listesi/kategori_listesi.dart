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
      kategoriListesiniGuncelle();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Kategoriler",
            style: TextStyle(color: Color.fromRGBO(3, 54, 73, 1))),
        actions: [
          FlatButton(
              onPressed: () {
                kategoriEkle();
              },
              child: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(kategoriler[index].kategoriAd),
            trailing: InkWell(
                child: Icon(Icons.delete),
                onTap: () {
                  kategoriSil(kategoriler[index].kategoriID);
                }),
            onTap: () {
              return kategoriGuncelle(kategoriler[index]);
            },
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

  void kategoriGuncelle(Kategori kat) {
    var formKey = GlobalKey<FormState>();
    String guncellenecekKategoriAd;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "Kategori Güncelle",
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
                        guncellenecekKategoriAd = yeni;
                      },
                      decoration: InputDecoration(
                          labelText: kat.kategoriAd,
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
                                  .kategoriGuncelle(Kategori.withID(
                                      kategoriID: kat.kategoriID,
                                      kategoriAd: guncellenecekKategoriAd))
                                  .then((kategoriID) {
                                if (kategoriID != 0) {
                                  setState(() {
                                    kategoriListesiniGuncelle();
                                    Navigator.pop(context);
                                  });
                                }
                              });
                            }
                          },
                          child: Text(
                            "Güncelle",
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

  void kategoriSil(int katId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Kategori Sil"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                      "Sildiğiniz kategoriye ait harcamalarda silinecektir. Silmek istediğinize emin misiniz?"),
                ),
                ButtonBar(
                  children: [
                    RaisedButton(
                        child: Text("Sil"),
                        color: Color.fromRGBO(3, 54, 73, 1),
                        onPressed: () {
                          databaseHelper.kategoriSil(katId).then((silinecek) {
                            if (silinecek != 0) {
                              setState(() {
                                kategoriListesiniGuncelle();
                              });
                            }
                          });
                          Navigator.pop(context);
                        }),
                    RaisedButton(
                        child: Text("Vazgeç"),
                        color: Color.fromRGBO(3, 54, 73, 1),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                )
              ],
            ),
          );
        });
  }
}
