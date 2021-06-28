import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/provider/auth_provider.dart';
import 'package:vaisdsa/provider/camera_provider.dart';
import 'package:vaisdsa/screens/homescreen.dart';
import 'package:vaisdsa/utils/app_theme_data.dart';
import 'package:vaisdsa/models/session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(SessionAdapter());
  await Hive.openBox<Session>('Session');

  // Hive.registerAdapter(TransactionAdapter());
  // await Hive.openBox<Session>('transactions');
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  final camera;

  const MyApp({Key key, this.camera}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (ctx) => Auth(),
        ),
        // ChangeNotifierProvider<Navigation>(
        //   create: (ctx) => Navigation(),
        // ),
        // ChangeNotifierProvider<Navigation>(
        //   create: (ctx) => Navigation(),
        // ),
        ChangeNotifierProvider<CameraProvider>(
          create: (ctx) => CameraProvider(),
        ),
        // ChangeNotifierProvider<MenuController>(
        //   create: (ctx) => menuController,
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appThemeData,
        home: Homescreen(
          camera: camera,
        ),
      ),
    );
  }
}
