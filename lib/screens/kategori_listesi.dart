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
              onPressed: () {}, // kategori ekle
              child: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(kategoriler[index].kategoriAd),
            trailing: Icon(Icons.delete_forever),
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
}
