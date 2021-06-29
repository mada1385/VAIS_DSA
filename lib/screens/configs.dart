import 'package:flutter/material.dart';

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF579955),
        centerTitle: true,
        title: Container(
          child: Text(
            "DSA",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Signatra",
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(),
    );
  }
}
