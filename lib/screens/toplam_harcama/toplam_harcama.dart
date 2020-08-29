import 'package:flutter/material.dart';
import 'package:training40_gider_hesaplama_app/tools/database_helper.dart';

class ToplamHarcama extends StatefulWidget {
  @override
  _ToplamHarcamaState createState() => _ToplamHarcamaState();
}

class _ToplamHarcamaState extends State<ToplamHarcama> {
  int toplamHarcamalar;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    databaseHelper.toplamHarcamalarGetir().then((t) {
      toplamHarcamalar = t;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toplam Harcamalar"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Toplam Harcama Tutarı:",
              style:
                  TextStyle(color: Color.fromRGBO(3, 54, 73, 1), fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  toplamHarcamalar.toString(),
                  style: TextStyle(
                      color: Color.fromRGBO(3, 54, 73, 1), fontSize: 50),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.money_off)
              ],
            )
          ],
        ),
      ),
    );
  }
}
