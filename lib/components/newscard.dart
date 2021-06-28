import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vaisdsa/models/session.dart';

class Newscard extends StatelessWidget {
  final Session e;

  const Newscard({Key key, this.e}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.black26,
                  offset: Offset(0, 5),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        child: new Image(
                          image: e.pricturesstamps[0]["imagepath"] != null
                              ? new FileImage(
                                  File(e.pricturesstamps[0]["imagepath"]))
                              : AssetImage("assets/damaged_leaves.jpeg"),
                          fit: BoxFit.cover,
                          height: 79,
                          width: 137,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("id : ${e.sessionid} "),
                        Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Text("Time :  ${e.stringsessiontime} ")),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
