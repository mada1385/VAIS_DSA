import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaisdsa/provider/auth_provider.dart';
import 'package:vaisdsa/provider/camera_provider.dart';
import 'package:vaisdsa/screens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  final camera;

  const SplashScreen({Key key, this.camera}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage(context);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage(BuildContext context) async {
    // 5s over, navigate to a new page

    // Provider.of<Auth>(context, listen: false).checkforsuperuser();
    Provider.of<Auth>(context, listen: false)
        .checkforuser(context, widget.camera);
    Provider.of<CameraProvider>(context, listen: false)
        .initalcamera(widget.camera);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        backgroundColor: Color(0xffF2FBF9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Hero(
                      tag: "logo",
                      child: new Image.asset(
                        'assets/logo.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Text(
                      "DSA",
                      style: TextStyle(
                          color: Color(0xFF579955),
                          fontFamily: "Signatra",
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
