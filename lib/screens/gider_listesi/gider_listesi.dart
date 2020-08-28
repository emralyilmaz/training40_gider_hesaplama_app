import 'package:flutter/material.dart';
import 'package:training40_gider_hesaplama_app/screens/kategori_listesi/kategori_listesi.dart';
import 'package:training40_gider_hesaplama_app/screens/gider_ekle/gider_ekle.dart';

class GiderListesi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Harcamalarınız",
          style: TextStyle(color: Color.fromRGBO(3, 54, 73, 1)),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    child: ListTile(
                  title: Text("Kategoriler"),
                  leading: Icon(
                    Icons.category,
                    color: Color.fromRGBO(3, 54, 73, 1),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    kategoriListesineGit(context);
                  },
                ))
              ];
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(3, 54, 73, 1),
        tooltip: "Harcama Ekle",
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HarcamaEkle(baslik: "Harcama Ekle")));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void kategoriListesineGit(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => KategoriListesi()));
  }
}
