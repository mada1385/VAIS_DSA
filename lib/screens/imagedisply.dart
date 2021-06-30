import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/provider/camera_provider.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String localphoto;
  final String hsiphoto;

  const DisplayPictureScreen({@required this.localphoto, this.hsiphoto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(localphoto)),
                            fit: BoxFit.fill)),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            color: Colors.transparent,
                            elevation: 30,
                            child: FlatButton(
                              onPressed: () async {
                                Provider.of<CameraProvider>(context,
                                        listen: false)
                                    .choosetag("1");
                              },
                              child: Text(
                                "1",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .apply(color: Colors.white),
                              ),
                              color: Provider.of<CameraProvider>(context).tag ==
                                      "1"
                                  ? Colors.green
                                  : Colors.white.withOpacity(.5),
                              shape: StadiumBorder(),
                              disabledColor: Colors.grey,
                            ),
                          ),
                          Card(
                            color: Colors.transparent,
                            elevation: 30,
                            child: FlatButton(
                              onPressed: () async {
                                Provider.of<CameraProvider>(context,
                                        listen: false)
                                    .choosetag("2");
                              },
                              child: Text(
                                "2",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .apply(color: Colors.white),
                              ),
                              color: Provider.of<CameraProvider>(context).tag ==
                                      "2"
                                  ? Colors.green
                                  : Colors.white.withOpacity(.5),
                              shape: StadiumBorder(),
                              disabledColor: Colors.grey,
                            ),
                          ),
                          Card(
                            color: Colors.transparent,
                            elevation: 30,
                            child: FlatButton(
                              onPressed: () async {
                                Provider.of<CameraProvider>(context,
                                        listen: false)
                                    .choosetag("3");
                              },
                              child: Text(
                                "3",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .apply(color: Colors.white),
                              ),
                              color: Provider.of<CameraProvider>(context).tag ==
                                      "3"
                                  ? Colors.green
                                  : Colors.white.withOpacity(.5),
                              shape: StadiumBorder(),
                              disabledColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ))),
            Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(hsiphoto), fit: BoxFit.fill)),
                    child: Text("l"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.transparent,
                  elevation: 30,
                  child: FlatButton(
                    onPressed: () async {
                      String date = DateTime.now().toString();
                      final appDir = await getExternalStorageDirectory();
                      final localfilepath = '${appDir.path}/$date.JPG';
                      final hsifilepath = '${appDir.path}/$date _hsi.JPG';
                      await get(hsiphoto).then((value) async {
                        File file = new File(join(hsifilepath));
                        file.writeAsBytesSync(value.bodyBytes);
                      });
                      File tmpFile = File(localphoto);
                      await tmpFile.copy(localfilepath);
                      Provider.of<CameraProvider>(context, listen: false)
                          .editTransaction(localfilepath, hsifilepath, context);
                    },
                    child: Text(
                      "save image",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .apply(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    shape: StadiumBorder(),
                    disabledColor: Colors.grey,
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  elevation: 30,
                  child: FlatButton(
                    onPressed: () async {
                      Provider.of<CameraProvider>(context, listen: false)
                          .cleartags();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "discrard image",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .apply(color: Colors.white),
                    ),
                    color: Colors.red,
                    shape: StadiumBorder(),
                    disabledColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
