import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// Source : https://gitlab.bewizyu.com/learn/flutter/flutter_app/-/blob/feature/11-Dialog/lib/app/screens/history/dialog/camera_dialog.dart
// Bouton de capture adapté
class CameraDialog extends StatefulWidget {
  @override
  _CameraDialogState createState() => _CameraDialogState();
}

class _CameraDialogState extends State<CameraDialog> {
  // déclaration des variables
  List<CameraDescription>? cameras;
  CameraController? controller;
  XFile? imageFile;

  //charger les cameras
  Future initCameras() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.length > 0) {
      controller = CameraController(cameras![0], ResolutionPreset.medium);
      controller?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
      print(cameras);
    }
  }

  //methode qui va etre appelé à l'initlisation du widget
  @override
  void initState() {
    super.initState();
    initCameras();
  }

  //à la destruction du widget
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // fonction pour prendre une photo

  Future<XFile> takePicture() async {
    if (!controller!.value.isInitialized) {
      throw 'error';
    }

    if (controller!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      throw 'error';
    }

    try {
      XFile file = await controller!.takePicture();
      return file;
    } on CameraException catch (e) {
      throw e;
    }
  }

//fonction appelé à l'appui du bouton
  void onTakePictureButtonPressed(context) async {
    if (imageFile == null) {
      takePicture().then((XFile file) {
        print('take a picture');
        print(file);
        setState(() {
          imageFile = file;
          Navigator.of(context).pop(imageFile);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedOpacity(
          duration: Duration(seconds: 1),
          opacity: controller == null ? 0 : 1,
          curve: Curves.easeInCubic,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 20,
            child: Stack(
              children: [
                //Partie Camera

                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: AspectRatio(
                        aspectRatio: 0.7,
                        child: controller == null
                            ? Container()
                            : CameraPreview(controller!)),
                  ),
                ),

                //Bouton de la caméra
                Positioned(
                  bottom: 30,
                  right: 30,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: BeveledRectangleBorder(),
                      backgroundColor: Colors.grey.shade800,
                    ),
                    onPressed: () {
                      onTakePictureButtonPressed(context);
                    },
                    child: Text(
                      'CAPTURER UNE IMAGE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
