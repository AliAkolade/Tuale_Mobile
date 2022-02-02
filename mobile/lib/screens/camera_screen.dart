import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:mobile/main.dart';
import 'package:mobile/screens/gallery_app.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/nav_bar.dart';
import 'package:mobile/utils/constants.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

Future<void> getHey() async {
  print("hey");
}

class _CameraAppState extends State<CameraApp> {
  CameraController? controller;
  Future? initalizedController;
  Size? mediaSize;
  double? scale;

  @override
  void initState() {
    // cameras = await availableCameras();
    print(camera.cameras);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

//  controller = CameraController(camera.cameras![0],ResolutionPreset.ultraHigh);

//  initalizedController = controller!.initialize();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<camera>(context, listen: false).changeNav();
    });

    //  controller!.initialize().then((_) {
    //    if (!mounted) {
    //      return;
    //   }
    //    setState((

    //    ) {
    //    });
    //  });
    super.initState();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // App state changed before we got the chance to initialize.
  //   if (controller == null || !controller!.value.isInitialized) {
  //     return;
  //   }
  //   if (state == AppLifecycleState.inactive) {
  //     controller?.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     if (controller != null) {
  //       // onNewCameraSelected(controller.description);
  //     }
  //   }
  // }
@override
void deactivate() {

  print("deactivate");
super.deactivate();
}

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
    // Provider.of<camera>(context, listen: false).changeNav();
    print("heyyyyy");

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack,
        overlays: []);

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: (){
           Provider.of<camera>(context, listen: false).changeNav();
      },
      child: Scaffold(
        body: FutureBuilder(
          future: getHey(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //    final mediaSize = MediaQuery.of(context).size;
              // final scale = 1 / (controller!.value.aspectRatio * mediaSize.aspectRatio);
              // If the Future is complete, display the preview.
              return SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    //   ClipRect(
                    //     clipper: _MediaSizeClipper(mediaSize),
                    //     child: Transform.scale(
                    //       scale: scale,
                    //       alignment: Alignment.topCenter,
                    //       child: Container(
                    //         color: Colors.black,
                    //       ),     // CameraPreview(
                    //     //     controller!,
                
                    //     //     ),
                    //      ),
                    //  ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                           const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                              size: 25,
                            ),
                            Spacer(flex: 6),
                            Icon(
                              Icons.flash_on_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                            Spacer(flex: 6),
                            Icon(
                              Icons.flip_camera_android_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                //                         Navigator.push(
                                // context,
                                // PageTransition(
                                //     type: PageTransitionType.topToBottom, child: gallery()));
                              },
                              child: const Icon(
                                Icons.radio_button_off_rounded,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size? mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize!.width, mediaSize!.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
