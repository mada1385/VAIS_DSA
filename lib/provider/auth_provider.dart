import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaisdsa/models/boxes.dart';
import 'package:vaisdsa/models/user.dart'; // For File Upload To Firestore

enum AuthMode { login, signup }

class Auth with ChangeNotifier {
  User loogeduser;
  checkforsuperuser() async {
    final sp = await SharedPreferences.getInstance();

    final superuser = sp.getBool("superuser");

    if (superuser == null) {
      User user = User("admin", "DSAP@\$\$w0rd", true);
      user.save();
      sp.setBool("superuser", true);
    }
  }

  login(String username, String password, BuildContext context) {
    final userbox = Boxes.getUsers();
    List<User> users = userbox.values.toList();
    for (User user in users) {
      if (user.username == username && user.password == password) {
        loogeduser = user;
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.white,
            content: Container(
              child: Text(
                "اسم المستخدم او كلمه السر غير صحيحة",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red),
              ),
            )));
      }
    }
  }

  adduser(String username, String password, BuildContext context) {
    User x = User(username, password, false);
    x.save();
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
