import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training40_gider_hesaplama_app/screens/kategori_listesi/kategori_listesi.dart';
import 'package:training40_gider_hesaplama_app/screens/gider_ekle/gider_ekle.dart';
import 'package:training40_gider_hesaplama_app/tools/database_helper.dart';
import 'package:training40_gider_hesaplama_app/models/harcama.dart';
import 'package:training40_gider_hesaplama_app/screens/toplam_harcama/toplam_harcama.dart';

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
                  title: Text("Toplam Harcamalar"),
                  leading: Icon(
                    Icons.attach_money,
                    color: Color.fromRGBO(3, 54, 73, 1),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    toplamGidereGit(context);
                  },
                )),
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
                )),
              ];
            },
          )
        ],
      ),
      body: Center(
        child: HarcamaListesi(),
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

  void toplamGidereGit(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ToplamHarcama()));
  }
}

class HarcamaListesi extends StatefulWidget {
  @override
  _HarcamaListesiState createState() => _HarcamaListesiState();
}

class _HarcamaListesiState extends State<HarcamaListesi> {
  List<Harcama> tumHarcamalar;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    tumHarcamalar = List<Harcama>();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: databaseHelper.harcamaListesiniGetir(),
        builder: (context, AsyncSnapshot<List<Harcama>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            tumHarcamalar = snapshot.data;
            return tumHarcamalar.length <= 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(tumHarcamalar[index].harcamaAd),
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text("Kategori"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child:
                                          Text(tumHarcamalar[index].kategoriAd),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text("Tarih"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text(DateFormat.yMd().format(
                                          DateTime.parse(tumHarcamalar[index]
                                              .harcamaTarih))),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text("Tutar"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text(tumHarcamalar[index]
                                          .harcamaTutar
                                          .toString()),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: tumHarcamalar.length,
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
