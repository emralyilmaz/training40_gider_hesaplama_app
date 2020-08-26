import 'package:flutter/material.dart';
import 'screens/gider_listesi.dart';
import 'screens/kategori_gider_listesi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gider Hesaplama Uygulaması",
      theme: ThemeData(
        primaryColor: Color.fromRGBO(3, 54, 73, 1),
        // accentColor: Color.fromRGBO(255, 184, 140, 1),
        // scaffoldBackgroundColor: Color.fromRGBO(222, 98, 98, 1),
      ),
      home: BottomBar(),
    );
  }
}

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    GiderListesi(),
    KategoriGiderListesi()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Aylık Harcamalar")),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text("Kategori Harcamalar")),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Color.fromRGBO(3, 54, 73, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
