import 'dart:async';
import 'package:flutter/material.dart';
import 'package:irisproject/irishome.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> cameras;
Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Iris Recognition",
      theme: ThemeData(
        primaryColor: Colors.indigo.shade900,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xff37C4B9)),
      ),
      home: irishome(cameras),
    );
  }
}
