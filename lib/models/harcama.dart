class Harcama {
  int harcamaID;
  String harcamaAd;
  String harcamaAciklama;
  int harcamaTutar;
  String harcamaTarih;
  int kategoriID;
  String kategoriAd;

  Harcama(
      {this.harcamaAd,
      this.harcamaAciklama,
      this.harcamaTutar,
      this.harcamaTarih,
      this.kategoriID});
  Harcama.withID(
      {this.harcamaID,
      this.harcamaAd,
      this.harcamaAciklama,
      this.harcamaTarih,
      this.harcamaTutar,
      this.kategoriID});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["harcamaID"] = harcamaID;
    map["harcamaAd"] = harcamaAd;
    map["harcamaAciklama"] = harcamaAciklama;
    map["harcamaTarih"] = harcamaTarih;
    map["harcamaTutar"] = harcamaTutar;
    map["kategoriID"] = kategoriID;
    return map;
  }

  Harcama.fromMap(Map<String, dynamic> map) {
    this.harcamaID = map["harcamaID"];
    this.harcamaAd = map["harcamaAd"];
    this.harcamaAciklama = map["harcamaAciklama"];
    this.harcamaTarih = map["harcamaTarih"];
    this.harcamaTutar = int.parse(map["harcamaTutar"] ?? "0");
    this.kategoriID = map["kategoriID"];
    this.kategoriAd = map["kategoriAd"];
  }
}
