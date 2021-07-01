import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/provider/camera_provider.dart';
import 'package:xml/xml.dart' as xml;

import 'package:vaisdsa/screens/imagedisply.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    @required this.camera,
  });

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      Provider.of<CameraProvider>(context, listen: false).selectedcamera,

      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // print(widget.camera.name);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
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
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Column(
              children: [
                Container(
                  // width: double.infinity,
                  child: CameraPreview(
                    _controller,
                    // child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(20),
                    //       child: Snackbutton(
                    //           initializeControllerFuture:
                    //               _initializeControllerFuture,
                    //           controller: _controller),
                    //     )
                    //   ],
                    // ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Snackbutton(
                            initializeControllerFuture:
                                _initializeControllerFuture,
                            controller: _controller),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   // Provide an onPressed callback.
      //   onPressed: () async {
      //     // Take the Picture in a try / catch block. If anything goes wrong,
      //     // catch the error.
      //     try {
      //       // Ensure that the camera is initialized.
      //       await _initializeControllerFuture;

      //       // Attempt to take a picture and get the file `image`
      //       // where it was saved.
      //       final image = await _controller.takePicture();

      //       // If the picture was taken, display it on a new screen.
      //       await Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (context) => DisplayPictureScreen(
      //             // Pass the automatically generated path to
      //             // the DisplayPictureScreen widget.
      //             imagePath: image.path,
      //           ),
      //         ),
      //       );
      //     } catch (e) {
      //       // If an error occurs, log the error to the console.
      //       print(e);
      //     }
      //   },
      //   child: const Icon(Icons.camera_alt),
      // ),
    );
  }
}

class Snackbutton extends StatelessWidget {
  const Snackbutton({
    Key key,
    @required Future<void> initializeControllerFuture,
    @required CameraController controller,
  })  : _initializeControllerFuture = initializeControllerFuture,
        _controller = controller,
        super(key: key);

  final Future<void> _initializeControllerFuture;
  final CameraController _controller;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      onPressed: () async {
        String hsiimagepath;

        try {
          await _initializeControllerFuture;

          final phoneimage = await _controller.takePicture();
          await get("http://192.168.1.254/?custom=1&cmd=1001").then((value) {
            final document = xml.XmlDocument.parse(value.body)
                .getElement("Function")
                .getElement("File")
                .getElement("FPATH")
                .firstChild
                .text
                .replaceAll(r"\", r"/")
                .replaceAll("A:", "");
            print(document);
            hsiimagepath = "http://192.168.1.254" + document;
            print(phoneimage.path);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                    localphoto: phoneimage.path, hsiphoto: hsiimagepath),
              ),
            );
          }).catchError((onError) {
            if (onError.osError.errorCode == 110)
              Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.white,
                  content: Container(
                    child: Text(
                      "برجاء توصيل الهاتف بشبكة الكاميرا",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red),
                    ),
                  )));
            print("================>" + onError.toString());
          });
        } catch (e) {}
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.camera,
          size: 40,
        ),
      ),
      shape: CircleBorder(),
    );
  }
}

// A widget that displays the picture taken by the user.
