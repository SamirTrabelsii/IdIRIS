import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:irisproject/interfaces/welcomepage.dart';
import 'package:irisproject/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:irisproject/irishome.dart';

class camerapage extends StatefulWidget {
  List<CameraDescription> cameras;
  camerapage(this.cameras);
  @override
  camerapageState createState() {
    return camerapageState();
  }
}

class camerapageState extends State<camerapage> {
  late CameraController controller;
  late Future<void> _initializeControllerFuture;
  final _textController = TextEditingController();

  XFile? rawImage;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.high,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    // Default Radio Button Selected Item When App Starts.
    String? radioButtonItem = 'L';
    // Group Value for Radio Button.
    int id = 1;
    int ready = 0;
    return Container(
      child: Stack(children: [
        Container(child: controller.buildPreview()),
        Container(
          child: Center(
            child: Image.asset(
              'images/overlayaim.png',
              color: Color(0xff37C4B9),
              width: 562.5,
              height: 675,
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            InkWell(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (BuildContext context, setState) {
                        return AlertDialog(
                          title: null,
                          content: Container(
                            height: 310,
                            margin: EdgeInsets.zero,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage("images/splash.png"),
                                    width: 125,
                                    height: 125,
                                  ),
                                  TextField(
                                      textAlign: TextAlign.center,
                                      controller: _textController,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                        decimal: true,
                                        signed: false,
                                      ),
                                      maxLength: 4,
                                      decoration: const InputDecoration(
                                        hintText: 'ID : exemple 1234',
                                        labelText: 'Pick ID',
                                        alignLabelWithHint: true,
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        border: UnderlineInputBorder(),
                                      )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Left eye ',
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                          Radio<String>(
                                            value: 'L',
                                            groupValue: radioButtonItem,
                                            onChanged: (val) {
                                              setState(() {
                                                radioButtonItem = 'L';
                                                id = 1;
                                              });
                                            },
                                          ),
                                          Radio<String>(
                                            value: 'R',
                                            groupValue: radioButtonItem,
                                            onChanged: (val) {
                                              setState(() {
                                                radioButtonItem = val;
                                                id = 2;
                                              });
                                            },
                                          ),
                                          Text(
                                            'Right eye ',
                                            style: new TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                _dismissDialog();
                              },
                              child: Text('Submit'),
                            )
                          ],
                        );
                        ;
                      },
                    ),
                  );
                },
                child: const Icon(
                  Icons.add_circle_outlined,
                  size: 50,
                  color: Colors.white,
                )),
            InkWell(
              splashColor: Colors.blue,
              onTap: () async {
                rawImage = await controller.takePicture();
                setState(() {});
                File imageFile = File(rawImage!.path);
                _showMaterialDialog();
                String currentUnix = '${_textController.text}_$radioButtonItem';
                String current = '${_textController.text}';
                String Unix = '$radioButtonItem';
                final directory = await getExternalStorageDirectory();
                print(directory);
                String fileFormat = imageFile.path.split('.').last;
                print(currentUnix);
                final myImagePath = '${directory?.path}/$current';

                if ((await Directory(myImagePath).exists())) {
                  // TODO:
                  print("exist");
                } else {
                  // TODO:
                  print("not exist");
                  final myImagePath2 = '${directory?.path}/$current/$Unix';
                  final myImgDir = await new Directory(myImagePath).create();
                  if ((await Directory(myImagePath2).exists())) {
                    // TODO:
                    print("exist");
                  } else {
                    // TODO:
                    print("not exist");
                    final myImgDir2 =
                        await new Directory(myImagePath2).create();
                    await imageFile.copy(
                      '$myImagePath2/$currentUnix.$fileFormat',
                    );
                  }
                }
                // final myImgDir = await new Directory(myImagePath).create();
              },
              child: const Icon(
                Icons.camera,
                size: 100,
                color: Colors.white,
              ),
            ),
            InkWell(
              splashColor: Colors.blue,
              child: const Icon(
                Icons.check_circle,
                size: 50,
                color: Colors.white,
              ),
            ),
          ]),
        )
      ]),
    );
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('IRIS App '),
            content: Text('Iris scanned successfully'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('Close')),
              TextButton(
                onPressed: () {
                  print('jawek behy ');
                  _dismissDialog();
                },
                child: Text('Okay!'),
              )
            ],
          );
        });
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }
}
