import 'dart:math';

import 'package:get/get.dart';
import 'package:mobile/screens/Home/controllers/getVibedPost.dart';
import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/screens/Home/video_player_screen.dart';
import 'package:mobile/screens/imports.dart';

import 'controllers/getCuratedPost.dart';

class VibingZoom extends StatefulWidget {
  int? index;
  List? post;
  GetxController? control;

  VibingZoom({this.index, this.post, this.control});
  @override
  _VibingZoomState createState() => _VibingZoomState();
}

class _VibingZoomState extends State<VibingZoom> {
  var alreadyGiveTuale = false;

  @override
  void initState() {
    getAlreadyGiveTuale();
    super.initState();
  }

  getAlreadyGiveTuale() {
    setState(() {
      // alreadyGiveTuale = Api().checkGivingTuale(widget.post?.tuales);
    });
    print("alreadyGiveTuale : $alreadyGiveTuale");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          child: widget.post?[widget.index!].mediaType != "image"
              ? Stack(
                  children: [
                    VideoPlayerScreen(
                      videoUrl: widget.post![widget.index!].postMedia,
                      enablePlayBtn: true,
                    ),
                    // Back button
                    Align(
                      // heightFactor: 1.0,
                      // widthFactor: 12.0,
                      alignment: Alignment(0.9, -0.95),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Colors.white70,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const Home()),
                              // );
                            },
                            child: Icon(
                              Icons.fullscreen_exit_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Add this CustomPaint widget to the Widget Tre                                //Add this CustomPaint widget to the Widget Tree
                   Align(
                        widthFactor: 5,
                        alignment: const Alignment(1.08, 0.6),
                        child: actionBar(
                            index: widget.index,
                            posts: widget.post ,
                          ),
                        ),
                    Obx(() => userInfoWidget(
                        context,
                        widget.index!,
                       !Get.isRegistered<CuratedPostController>() ? Get.find<VibedPostController>().vibePost.value : Get.find<CuratedPostController>().curatedPost.value,)) //Add this CustomPaint widget to the Widget Tree
                  ],
                )
              : Stack(
                  children: [
                    Align(
                      // heightFactor: 1.0,
                      // widthFactor: 12.0,
                      alignment: Alignment(0.9, -0.95),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Colors.white70,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.fullscreen_exit_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Align(
                        widthFactor: 5,
                        alignment: const Alignment(1.08, 0.6),
                        child: actionBar(
                            index: widget.index,
                            posts: widget.post ,
                          ),
                        ),
                    Obx(() => userInfoWidget(
                        context,
                        widget.index!,
                       !Get.isRegistered<CuratedPostController>() ? Get.find<VibedPostController>().vibePost.value : Get.find<CuratedPostController>().curatedPost.value,)) //Add this CustomPaint widget to the Widget Tree
                    //user post info
                  ],
                ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.post![widget.index!].postMedia))),
        ),
      ),
    );
  }
}
