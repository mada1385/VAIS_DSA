import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/components/newscard.dart';
import 'package:vaisdsa/provider/camera_provider.dart';
import 'package:vaisdsa/screens/sessiondetail.dart';

class Browseoldannotaion extends StatefulWidget {
  @override
  _BrowseoldannotaionState createState() => _BrowseoldannotaionState();
}

class _BrowseoldannotaionState extends State<Browseoldannotaion> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CameraProvider>(context, listen: false).getoldsessions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF579955),
        centerTitle: true,
        title: Center(
          child: Container(
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
      ),
      body: ListView.builder(
          itemCount: Provider.of<CameraProvider>(context).oldsessions.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Sessiondetail(
                                session: Provider.of<CameraProvider>(context)
                                    .oldsessions[index],
                              )));
                },
                child: Newscard(
                  e: Provider.of<CameraProvider>(context).oldsessions[index],
                ),
              )),
    );
  }
}
