import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaisdsa/models/session.dart';

class CameraProvider extends ChangeNotifier {
  String tag;
  List sessions = [];
  Session session;
  DateTime now = DateTime.now();
  File jsonFile;
  Directory dir;
  String fileName;
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  getfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String file = pref.getString("sessionfile");
    if (file != null) {
      jsonFile = File(file);
      print("getfile====>$file");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync() ?? {});
      sessions = jsonFileContent["sessions"];
    } else {
      print("getfile====>no file");

      startsession();
    }
  }

  void startsession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    getExternalStorageDirectory().then((Directory directory) async {
      dir = directory;
      String path = dir.path + "/sessions.json";
      print("Creating file!");
      jsonFile = new File(path);
      pref.setString("sessionfile", path);
      print("startsession====>${pref.getString("sessionfile")}");

      fileName = path;
      print(path);
      fileExists = true;
      jsonFile.writeAsStringSync(json.encode({"hi": "hi"}));
    });
  }

  void choosetag(String x) {
    tag = x;
    notifyListeners();
  }

  void addsession() {
    session = Session("sessionid", "stringsessiontime", []);
    Map<String, dynamic> content = {
      "sessionid": session.sessionid,
      "stringsessiontime": session.stringsessiontime,
      "pricturesstamps": session.pricturesstamps
    };
    sessions.add(content);
    writeToFile();
  }

  void writeToFile() {
    print("Writing to file!");
    Map<String, dynamic> content = {"sessions": sessions};

    print("File exists");
    Map<String, dynamic> jsonFileContent =
        json.decode(jsonFile.readAsStringSync() ?? {});

    jsonFileContent.addAll(content);
    jsonFile.writeAsStringSync(json.encode(jsonFileContent));

    fileContent = json.decode(jsonFile.readAsStringSync());
    print(fileContent);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  addimagepath(String imagepath, String tag, BuildContext context) async {
    Position lanlat = await _determinePosition();
    Samplepicture x = Samplepicture(imagepath, DateTime.now().toString(),
        lanlat.longitude.toString(), lanlat.latitude.toString(), tag);
    session.pricturesstamps.add({
      "imagepath": x.filepath,
      "timestamp": x.timestamp,
      "lang": x.lang,
      "lat": x.lat,
      "tag": x.tag
    });
    writeToFile();
    tag = null;
    Navigator.pop(context);
  }
}
