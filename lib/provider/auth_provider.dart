import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaisdsa/models/boxes.dart';
import 'package:vaisdsa/models/user.dart';
import 'package:vaisdsa/screens/auth_screen.dart';
import 'package:vaisdsa/screens/homescreen.dart'; // For File Upload To Firestore

enum AuthMode { login, signup }

class Auth with ChangeNotifier {
  User loogeduser;
  checkforuser(BuildContext context, camera) async {
    print(camera.name);
    final sp = await SharedPreferences.getInstance();
    String user = sp.get("user");
    if (user == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AuthScreen(
                    login: true,
                  )));
    } else {
      loogeduser = User.fromJson(jsonDecode(user));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Homescreen(
                    camera: camera,
                  )));
    }
  }

  checkforsuperuser() async {
    final sp = await SharedPreferences.getInstance();
    final box = Boxes.getUsers();
    final user = sp.get("superuser");

    if (user == null) {
      User user = User("admin", "DSAP@\$\$w0rd", true);
      box.add(user);
      sp.setBool("superuser", true);
    }
    final boxes = box.values.toList();

    boxes.forEach((element) {
      print(
          "====================================================================================================");
      print(element.username);
      print(element.password);
      print(element.superuser);
      print(
          "====================================================================================================");
    });
  }

  logout() async {
    final sp = await SharedPreferences.getInstance();
    sp.remove("user");
  }

  login(String username, String password, BuildContext context) async {
    final sp = await SharedPreferences.getInstance();

    bool flag = false;
    final userbox = Boxes.getUsers();
    List<User> users = userbox.values.toList();
    users.forEach((element) {
      print(
          "====================================================================================================");
      print(element.username);
      print(element.password);
      print(element.superuser);
      print(
          "====================================================================================================");
    });
    for (User user in users) {
      if (username == user.username && password == user.password) {
        print("logged");
        flag = true;
        sp.setString("user", json.encode(user.toJson()));

        break;
      }
    }
    if (flag) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Container(
            child: Text(
              "اسم المستخدم او كلمه السر غير صحيحة",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            ),
          )));
    }
  }

  adduser(String username, String password, BuildContext context) {
    User x = User(username, password, false);
    final box = Boxes.getUsers();
    box.add(x);
    final boxes = box.values.toList();

    boxes.forEach((element) {
      print(
          "====================================================================================================");
      print(element.username);
      print(element.password);
      print(element.superuser);
      print(
          "====================================================================================================");
    });
    Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Container(
          child: Text(
            "تم تسجيل المستخدم بنجاح",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
          ),
        )));
  }
}
