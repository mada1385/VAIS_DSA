import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/provider/camera_provider.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({@required this.imagePath});

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
                            image: FileImage(File(imagePath)),
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
                                // File tmpFile = File(imagePath);
                                // final appDir = await getExternalStorageDirectory();
                                // final fileName = basename(imagePath);
                                // final localFile =
                                //     await tmpFile.copy('${appDir.path}/$fileName');
                                // Provider.of<CameraProvider>(context, listen: false)
                                //     .addimagepath('${appDir.path}/$fileName', "tag", context);
                              },
                              child: Text(
                                "1",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .apply(color: Colors.white),
                              ),
                              color: Colors.white.withOpacity(.5),
                              shape: StadiumBorder(),
                              disabledColor: Colors.grey,
                            ),
                          ),
                          Card(
                            color: Colors.transparent,
                            elevation: 30,
                            child: FlatButton(
                              onPressed: () async {
                                // File tmpFile = File(imagePath);
                                // final appDir = await getExternalStorageDirectory();
                                // final fileName = basename(imagePath);
                                // final localFile =
                                //     await tmpFile.copy('${appDir.path}/$fileName');
                                // Provider.of<CameraProvider>(context, listen: false)
                                //     .addimagepath('${appDir.path}/$fileName', "tag", context);
                              },
                              child: Text(
                                "2",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .apply(color: Colors.white),
                              ),
                              color: Colors.white.withOpacity(.5),
                              shape: StadiumBorder(),
                              disabledColor: Colors.grey,
                            ),
                          ),
                          Card(
                            color: Colors.transparent,
                            elevation: 30,
                            child: FlatButton(
                              onPressed: () async {
                                // File tmpFile = File(imagePath);
                                // final appDir = await getExternalStorageDirectory();
                                // final fileName = basename(imagePath);
                                // final localFile =
                                //     await tmpFile.copy('${appDir.path}/$fileName');
                                // Provider.of<CameraProvider>(context, listen: false)
                                //     .addimagepath('${appDir.path}/$fileName', "tag", context);
                              },
                              child: Text(
                                "3",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .apply(color: Colors.white),
                              ),
                              color: Colors.white.withOpacity(.5),
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
                            image: FileImage(File(imagePath)),
                            fit: BoxFit.fill)),
                    child: Text("l"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.transparent,
                  elevation: 30,
                  child: FlatButton(
                    onPressed: () async {
                      File tmpFile = File(imagePath);
                      final appDir = await getExternalStorageDirectory();
                      final fileName = basename(imagePath);
                      final localFile =
                          await tmpFile.copy('${appDir.path}/$fileName');
                      Provider.of<CameraProvider>(context, listen: false)
                          .editTransaction(
                              '${appDir.path}/$fileName', "tag", context);
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
                      File tmpFile = File(imagePath);
                      final appDir = await getExternalStorageDirectory();
                      final fileName = basename(imagePath);
                      final localFile =
                          await tmpFile.copy('${appDir.path}/$fileName');
                      Provider.of<CameraProvider>(context, listen: false)
                          .editTransaction(
                              '${appDir.path}/$fileName', "tag", context);
                    },
                    child: Text(
                      "save image",
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
