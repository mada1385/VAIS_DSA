import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/provider/camera_provider.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String localphoto;
  final String hsiphoto;

  const DisplayPictureScreen({@required this.localphoto, this.hsiphoto});

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  File photohsi;
  String hsifilepath;
  saveimage() async {
    String date = DateTime.now().toString();
    final appDir = await getExternalStorageDirectory();
    await get(Uri.parse(widget.hsiphoto)).then((value) async {
      setState(() {
        hsifilepath = '${appDir.path}/$date _hsi.JPG';
        photohsi = new File(hsifilepath);
        photohsi.writeAsBytesSync(value.bodyBytes);
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      saveimage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.black.withOpacity(.6),
              child: Row(
                children: [
                  Text(
                    "رقم النبتة : ",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white),
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.number,
                      controller: Provider.of<CameraProvider>(context).planetid,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(widget.localphoto)),
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
                                    .choosetag("التبقع البنى");
                              },
                              child: Text(
                                "التبقع البنى",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .apply(color: Colors.white),
                              ),
                              color: Provider.of<CameraProvider>(context).tag ==
                                      "التبقع البنى"
                                  ? Colors.green
                                  : Colors.black,
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
                                    .choosetag("اللفحة");
                              },
                              child: Text(
                                "اللفحة",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .apply(color: Colors.white),
                              ),
                              color: Provider.of<CameraProvider>(context).tag ==
                                      "اللفحة"
                                  ? Colors.green
                                  : Colors.black,
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
                                    .choosetag("صحى");
                              },
                              child: Text(
                                "صحى",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .apply(color: Colors.white),
                              ),
                              color: Provider.of<CameraProvider>(context).tag ==
                                      "صحى"
                                  ? Colors.green
                                  : Colors.black,
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
                                    .choosetag("غير معروف");
                              },
                              child: Text(
                                "غير معروف",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .apply(color: Colors.white),
                              ),
                              color: Provider.of<CameraProvider>(context).tag ==
                                      "غير معروف"
                                  ? Colors.green
                                  : Colors.black,
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
                      image: photohsi == null
                          ? AssetImage("assets/loading-icegif-1.gif")
                          : FileImage(photohsi))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Card(
                    color: Colors.transparent,
                    elevation: 30,
                    child: FlatButton(
                      onPressed: () async {
                        Provider.of<CameraProvider>(context, listen: false)
                            .choosestage("مبكر");
                      },
                      child: Text(
                        "مبكر",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .apply(color: Colors.white),
                      ),
                      color:
                          Provider.of<CameraProvider>(context).stage == "مبكر"
                              ? Colors.green
                              : Colors.black,
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
                            .choosestage("متوسط");
                      },
                      child: Text(
                        "متوسط",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .apply(color: Colors.white),
                      ),
                      color:
                          Provider.of<CameraProvider>(context).stage == "متوسط"
                              ? Colors.green
                              : Colors.black,
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
                            .choosestage("متاخر");
                      },
                      child: Text(
                        "متاخر",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .apply(color: Colors.white),
                      ),
                      color:
                          Provider.of<CameraProvider>(context).stage == "متاخر"
                              ? Colors.green
                              : Colors.black,
                      shape: StadiumBorder(),
                      disabledColor: Colors.grey,
                    ),
                  ),
                ],
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Snacksavebutton(
                  hsiphoto: hsifilepath,
                  localphoto: widget.localphoto,
                  save: true,
                ),
                Snacksavebutton(
                  hsiphoto: hsifilepath,
                  localphoto: widget.localphoto,
                  save: false,
                ),
                Card(
                  color: Colors.transparent,
                  elevation: 30,
                  child: FlatButton(
                    onPressed: () async {
                      photohsi.delete();
                      Provider.of<CameraProvider>(context, listen: false)
                          .cleartags();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "الغاء",
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

class Snacksavebutton extends StatelessWidget {
  const Snacksavebutton({
    Key key,
    @required this.hsiphoto,
    @required this.localphoto,
    @required this.save,
  }) : super(key: key);
  final bool save;
  final String hsiphoto;
  final String localphoto;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 30,
      child: FlatButton(
        onPressed: () async {
          String date = DateTime.now().toString();
          final appDir = await getExternalStorageDirectory();
          final localfilepath = '${appDir.path}/$date.JPG';
          File tmpFile = File(localphoto);
          await tmpFile.copy(localfilepath);
          Provider.of<CameraProvider>(context, listen: false)
              .editTransaction(localfilepath, hsiphoto, context, save);
        },
        child: Text(
          save ? "صورة تالية" : "صورة اخرى",
          style:
              Theme.of(context).textTheme.headline3.apply(color: Colors.white),
        ),
        color: Colors.black,
        shape: StadiumBorder(),
        disabledColor: Colors.grey,
      ),
    );
  }
}
