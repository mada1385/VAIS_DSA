import 'package:hive/hive.dart';

part 'session.g.dart';

@HiveType(typeId: 2)
class Session extends HiveObject {
  @HiveField(0)
  final String sessionid;
  @HiveField(1)
  final String stringsessiontime;
  @HiveField(2)
  List pricturesstamps = [];
  @HiveField(3)
  bool synced;

  Session(this.sessionid, this.stringsessiontime, this.pricturesstamps,
      this.synced);

  // factory Session.fromJson(Map<String, dynamic> json) {
  //   return Session(
  //     json["sessionname"],
  //     json["stringsessiontime"],
  //     json["pricturesstamps"],
  //   );
  // }
}

// @HiveType(typeId: 0)
// class Transaction extends HiveObject {
//   @HiveField(0)
//   late String name;

//   @HiveField(1)
//   late DateTime createdDate;

//   @HiveField(2)
//   late bool isExpense = true;

//   @HiveField(3)
//   late double amount;
// }
class Samplepicture {
  final String filepath, timestamp, lang, lat, tag;
  bool issynced;

  Samplepicture(
    this.filepath,
    this.timestamp,
    this.lang,
    this.lat,
    this.tag,
    this.issynced,
  );
  // factory Samplepicture.fromJson(Map<String, dynamic> json) {
  //   return Samplepicture(
  //     json["filepath"],
  //     json["timestamp"],
  //     json["lang"],
  //     json["lat"],
  //     json["tag"],
  //   );
  // }
}
