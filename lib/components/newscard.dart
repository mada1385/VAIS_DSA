import 'package:flutter/material.dart';

class Newscard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
          height: 130,
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
                Container(
                  child: Text(
                    "first image",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
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
                          image: new AssetImage("assets/damaged_leaves.jpeg"),
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
                        Text("Time : "),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Location : "),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Tag : ")
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
