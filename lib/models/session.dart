class Session {
  final String sessionid;
  final String stringsessiontime;
  List pricturesstamps = [];

  Session(this.sessionid, this.stringsessiontime, this.pricturesstamps);

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      json["sessionname"],
      json["stringsessiontime"],
      json["pricturesstamps"],
    );
  }
}

class Samplepicture {
  final String filepath, timestamp, lang, lat, tag;

  Samplepicture(this.filepath, this.timestamp, this.lang, this.lat, this.tag);
  factory Samplepicture.fromJson(Map<String, dynamic> json) {
    return Samplepicture(
      json["filepath"],
      json["timestamp"],
      json["lang"],
      json["lat"],
      json["tag"],
    );
  }
}
