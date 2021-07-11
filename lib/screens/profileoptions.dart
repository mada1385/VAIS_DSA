import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/components/profileoptioncard.dart';
import 'package:vaisdsa/provider/auth_provider.dart';
import 'package:vaisdsa/provider/camera_provider.dart';
import 'package:vaisdsa/screens/auth_screen.dart';

class Profileoptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Provider.of<Auth>(context).loogeduser.superuser == true
                ? <Widget>[
                    Profileoptioncard(
                        ontap: () async {
                          await get("https://reqres.in/api/products/3")
                              .then((value) {
                            Provider.of<CameraProvider>(context, listen: false)
                                .synctofirebase(context);
                          }).catchError((onError) {
                            if (onError.osError.errorCode == 7)
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.white,
                                  content: Container(
                                    child: Text(
                                      "برجاء توصيل الهاتف بشبكة ال واي فاي",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.red),
                                    ),
                                  )));
                            print("================>" + onError.toString());
                          });
                        },
                        icon: Icon(Icons.sync),
                        title: "مزامنة الجلسات"),
                    Profileoptioncard(
                      icon: Icon(Icons.backup),
                      title: "إجراء نسخة احتياطية",
                      ontap: () async {
                        Provider.of<CameraProvider>(context, listen: false)
                            .jsonfilebackup();
                      },
                    ),
                    Profileoptioncard(
                      icon: Icon(
                        Icons.person,
                      ),
                      title: "إضافة مستخدم",
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthScreen(
                                      login: false,
                                    )));
                      },
                    ),
                    Profileoptioncard(
                      icon: Icon(Icons.logout),
                      title: "تسجيل خروج",
                      ontap: () {
                        Provider.of<Auth>(context, listen: false).logout();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthScreen(
                                      login: true,
                                    )));
                      },
                    ),
                  ]
                : <Widget>[
                    Profileoptioncard(
                        ontap: () async {
                          await get("https://reqres.in/api/products/3")
                              .then((value) {
                            Provider.of<CameraProvider>(context, listen: false)
                                .synctofirebase(context);
                          }).catchError((onError) {
                            if (onError.osError.errorCode == 7)
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.white,
                                  content: Container(
                                    child: Text(
                                      "برجاء توصيل الهاتف بشبكة ال واي فاي",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.red),
                                    ),
                                  )));
                            print("================>" + onError.toString());
                          });
                        },
                        icon: Icon(Icons.sync),
                        title: "مزامنة الجلسات"),
                    Profileoptioncard(
                      icon: Icon(Icons.logout),
                      title: "تسجيل خروج",
                      ontap: () {
                        Provider.of<Auth>(context, listen: false).logout();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthScreen(
                                      login: true,
                                    )));
                      },
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
