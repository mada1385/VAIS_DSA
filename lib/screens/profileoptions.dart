import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/components/profileoptioncard.dart';
import 'package:vaisdsa/provider/camera_provider.dart';

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
            children: [
              Profileoptioncard(
                ontap: () {
                  Provider.of<CameraProvider>(context, listen: false)
                      .synctofirebase();
                },
                icon: Icon(Icons.sync),
                title: "Sync the data",
              ),
              Profileoptioncard(
                icon: Icon(Icons.backup),
                title: "make a backup",
                ontap: () async {
                  Provider.of<CameraProvider>(context, listen: false)
                      .jsonfilebackup();
                },
              ),
              Profileoptioncard(
                icon: Icon(Icons.logout),
                title: "logout",
                ontap: () async {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
