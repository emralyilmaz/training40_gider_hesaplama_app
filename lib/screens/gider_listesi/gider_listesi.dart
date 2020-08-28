import 'package:flutter/material.dart';
import 'package:training40_gider_hesaplama_app/screens/kategori_listesi/kategori_listesi.dart';

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
    );
  }

  void kategoriListesineGit(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => KategoriListesi()));
  }
}
