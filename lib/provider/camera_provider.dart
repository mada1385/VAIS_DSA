import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/models/boxes.dart';
import 'package:vaisdsa/models/session.dart';
import 'package:vaisdsa/provider/auth_provider.dart';

class CameraProvider extends ChangeNotifier {
  String tag;
  List sessions = [];
  dynamic selectedcamera;
  initalcamera(camera) {
    selectedcamera = camera;
    notifyListeners();
  }

  List<Session> oldsessions;
  getoldsessions() async {
    final box = Boxes.getTransactions();

    print(box.values.toList().toString());
    oldsessions = box.values.toList();

    notifyListeners();
  }
  // List pics = [

  // ];
  Session session;
  DateTime now = DateTime.now();
  File jsonFile;
  Directory dir;
  String fileName;
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  cleartags() {
    tag = "";
    notifyListeners();
  }

  Future uploadImageToFirebase(File image) async {
    String imageref;
    String fileName = basename(image.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child(fileName ?? "image1" + DateTime.now().toString());
    await ref.putFile(image).then((res) async {
      imageref = await res.ref.getDownloadURL();
      print(imageref);
    });

    return imageref;
  }

  synctofirebase() async {
    final ref = FirebaseFirestore.instance.collection("Sessions");
    int i, j;
    final box = Boxes.getTransactions();

    print(box.values.toList().toString());
    final boxes = box.values.toList();
    for (i = 0; i < boxes.length; i++) {
      final e = boxes[i];

      if (!e.synced) {
        try {
          final sesionref = await ref.add({
            "sessionid": e.sessionid,
            "sessiontime": e.stringsessiontime,
            "issynced": false,
            "picturestamps": [],
          });
          print(sesionref.id);
          print(e.pricturesstamps.length);
          for (j = 0; j < e.pricturesstamps.length; j++) {
            if (!e.pricturesstamps[j]["issyncd"]) {
              if (!e.pricturesstamps.isEmpty) {
                // final ref = await uploadImageToFirebase(
                //     File(e.pricturesstamps[j]["imagepath"]));

                await ref.doc(sesionref.id).update({
                  "picturestamps": FieldValue.arrayUnion([
                    {
                      "issyncd": true,
                      "imagepath": await uploadImageToFirebase(
                          File(e.pricturesstamps[j]["imagepath"])),
                      "hsiimage": await uploadImageToFirebase(
                          File(e.pricturesstamps[j]["hsiimagepath"])),
                      "timestamp": e.pricturesstamps[j]["timestamp"],
                      "lang": e.pricturesstamps[j]["lang"],
                      "lat": e.pricturesstamps[j]["lat"],
                      "tag": e.pricturesstamps[j]["tag"],
                    }
                  ])
                });

                e.pricturesstamps[j]["issyncd"] = true;
                e.save();
              }
            }
          }
          await ref.doc(sesionref.id).update({
            "issynced": true,
          });
          e.synced = true;
          e.save();
        } on Exception catch (e) {
          //  if (onError.osError.errorCode == 110)
          //   Scaffold.of(context).showSnackBar(SnackBar(
          //       backgroundColor: Colors.white,
          //       content: Container(
          //         child: Text(
          //           "برجاء توصيل الهاتف بشبكة الكاميرا",
          //           style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 25,
          //               color: Colors.red),
          //         ),
          //       )));
          // print("================>" + e.toString());
        }
      }
    }
  }

//==================================================================================================
  Future addTransaction(BuildContext context) async {
    session = new Session(
        Provider.of<Auth>(context).loogeduser.username +
            "-" +
            DateTime.now().toString(),
        DateTime.now().toString(),
        [],
        false);
    final box = Boxes.getTransactions();
    box.add(session);

    print(box.values.toList().toString());

    final boxes = box.values.toList();
    boxes.forEach((element) {
      print(
          "====================================================================================================");
      print(element.sessionid);
      print(session.stringsessiontime);
      print(element.pricturesstamps);
      print(
          "====================================================================================================");
    });
    //box.put('mykey', transaction);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  Future<void> editTransaction(
      String imagepath, String hisimage, BuildContext context) async {
    Position lanlat = await _determinePosition();
    Samplepicture x = Samplepicture(imagepath, DateTime.now().toString(),
        lanlat.longitude.toString(), lanlat.latitude.toString(), tag, false);
    session.pricturesstamps.add({
      "issyncd": x.issynced,
      "imagepath": x.filepath,
      "hsiimagepath": hisimage,
      "timestamp": x.timestamp,
      "lang": x.lang,
      "lat": x.lat,
      "tag": tag,
    });
    session.save();
    final box = Boxes.getTransactions();

    print(box.values.toList().toString());
    final boxes = box.values.toList();
    boxes.forEach((element) {
      print(
          "====================================================================================================");
      print(element.sessionid);
      print(session.stringsessiontime);
      print(element.pricturesstamps);
      print(
          "====================================================================================================");
    });
    tag = "";
    notifyListeners();
    Navigator.pop(context);
  }

// ======================================================================================================================

  void jsonfilebackup() async {
    final box = Boxes.getTransactions();
    final boxes = box.values.toList();
    sessions = boxes
        .map((e) => {
              "sessionid": e.sessionid,
              "sessiontime": e.stringsessiontime,
              "picturestamps": e.pricturesstamps,
              "issynced": e.synced
            })
        .toList();

    getExternalStorageDirectory().then((Directory directory) async {
      dir = directory;
      String path = dir.path + "/${DateTime.now().toString()}.json";
      print("Creating file!");
      jsonFile = new File(path);

      jsonFile.writeAsStringSync(json.encode(sessions));
    });
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

  void choosetag(String x) {
    tag = x;
    notifyListeners();
  }

//=============================================================================================================
  // getfile() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String file = pref.getString("sessionfile");
  //   if (file != null) {
  //     jsonFile = File(file);
  //     print("getfile====>$file");
  //     Map<String, dynamic> jsonFileContent =
  //         json.decode(jsonFile.readAsStringSync() ?? {});
  //     sessions = jsonFileContent["sessions"];
  //   } else {
  //     print("getfile====>no file");

  //     startsession();
  //   }
  // }

  // void addsession() {
  //   session = Session("sessionid", "stringsessiontime", [], false);
  //   Map<String, dynamic> content = {
  //     "sessionid": session.sessionid,
  //     "stringsessiontime": session.stringsessiontime,
  //     "pricturesstamps": session.pricturesstamps
  //   };
  //   sessions.add(content);
  //   writeToFile();
  // }

  // void writeToFile() {
  //   print("Writing to file!");
  //   Map<String, dynamic> content = {"sessions": sessions};

  //   print("File exists");
  //   Map<String, dynamic> jsonFileContent =
  //       json.decode(jsonFile.readAsStringSync() ?? {});

  //   jsonFileContent.addAll(content);
  //   jsonFile.writeAsStringSync(json.encode(jsonFileContent));

  //   fileContent = json.decode(jsonFile.readAsStringSync());
  //   print(fileContent);
  // }

  // addimagepath(String imagepath, String tag, BuildContext context) async {
  //   Position lanlat = await _determinePosition();
  //   Samplepicture x = Samplepicture(imagepath, DateTime.now().toString(),
  //       lanlat.longitude.toString(), lanlat.latitude.toString(), tag);
  //   session.pricturesstamps.add({
  //     "imagepath": x.filepath,
  //     "timestamp": x.timestamp,
  //     "lang": x.lang,
  //     "lat": x.lat,
  //     "tag": x.tag
  //   });
  //   writeToFile();
  //   tag = null;
  //   Navigator.pop(context);
  // }
}
