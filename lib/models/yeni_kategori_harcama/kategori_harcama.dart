class KategoriHarcama {
  int tutar;
  String tip;

  KategoriHarcama({this.tip, this.tutar});

  KategoriHarcama.fromMap(Map<String, dynamic> map) {
    this.tutar = map["harcamaTutar"];
    this.tip = map["kategoriAd"];
  }
}
