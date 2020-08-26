import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'dart:io'; // file için
import 'package:flutter/services.dart'; // rootBundle için
import 'package:path/path.dart'; // join için
import 'package:training40_gider_hesaplama_app/models/kategori.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await initDB();
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database> initDB() async {
    var lock = Lock();
    Database _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, "app.db"); // giderlerin olduğu
          var file = new File(path);

          // check if file exists
          if (!await file.exists()) {
            // Copy from asset
            ByteData data = await rootBundle.load(join("assets", "harcama.db"));
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          // open the database
          _db = await openDatabase(path);
        }
      });
    }
    return _db;
  }

  Future<List<Map<String, dynamic>>> kategorileriGetir() async {
    var db = await getDatabase();
    var sonuc = await db.query("kategoriler");
    return sonuc;
  }

  Future<List<Kategori>> kategoriListesiniGetir() async {
    var map = await kategorileriGetir();
    var kategoriListesi = List<Kategori>();

    for (Map m in map) {
      kategoriListesi.add(Kategori.fromMap(m));
      return kategoriListesi;
    }
  }

  Future<int> kategoriEkle(Kategori kat) async {
    var db = await getDatabase();
    var sonuc = await db.insert("kategoriler", kat.toMap());
    return sonuc;
  }

  Future<int> kategoriGuncelle(Kategori kat) async {
    var db = await getDatabase();
    var sonuc = await db.update("kategoriler", kat.toMap(),
        where: "kategoriID = ?", whereArgs: [kat.kategoriID]);
    return sonuc;
  }

  Future<int> kategoriSil(int katID) async {
    var db = await getDatabase();
    var sonuc = await db
        .delete("kategoriler", where: "kategoriID=?", whereArgs: [katID]);
    return sonuc;
  }
}
