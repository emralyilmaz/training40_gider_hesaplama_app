import 'package:flutter/material.dart';
import 'package:training40_gider_hesaplama_app/models/yeni_kategori_harcama/kategori_harcama.dart';
import 'package:training40_gider_hesaplama_app/tools/database_helper.dart';

class KategoriGiderListesi extends StatefulWidget {
  @override
  _KategoriGiderListesiState createState() => _KategoriGiderListesiState();
}

class _KategoriGiderListesiState extends State<KategoriGiderListesi> {
  List<KategoriHarcama> tumKategoriHarcama;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    tumKategoriHarcama = List<KategoriHarcama>();
    databaseHelper = DatabaseHelper();

    databaseHelper.kategoriyeGoreHarcamaListesiniGetir().then((harList) {
      tumKategoriHarcama = harList;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategoriye göre harcamalar"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tumKategoriHarcama[index].tip),
            trailing: Text(tumKategoriHarcama[index].tutar.toString()),
          );
        },
        itemCount: tumKategoriHarcama.length,
      ),
    );
  }
}
