import 'dart:math';

import 'package:get/get.dart';
import 'package:mobile/screens/Home/controllers/getVibedPost.dart';
import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/screens/Home/video_player_screen.dart';
import 'package:mobile/screens/imports.dart';
import 'package:mobile/screens/widgets/verifiedTag.dart';

import 'controllers/getCuratedPost.dart';

class VibingZoom extends StatefulWidget {
  int? index;
  List? post;
  String parentName;
  GetxController? control;

  VibingZoom({this.index, this.post, this.control, this.parentName="curated"});
  @override
  _VibingZoomState createState() => _VibingZoomState();
}

late VideoPlayerController currentVPZoom;

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
                        cbController: (VideoPlayerController vc){
                          debugPrint("-here vc-");
                          currentVPZoom = vc;
                        }
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
                              // 200 -> mean user go back successufly so home can continue  play video
                              Navigator.pop(context,200);
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
                    Obx(() => userInfoWidgetZoom(
                        context,
                        widget.index!,
                        !Get.isRegistered<CuratedPostController>() ? Get.find<VibedPostController>().vibePost.value
                            : Get.find<CuratedPostController>().curatedPost.value,)) //Add this CustomPaint widget to the Widget Tree
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
                    Obx(() => userInfoWidgetZoom(
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

Widget userInfoWidgetZoom(BuildContext context, int index, List posts) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      // SizedBox(
      //   height: 20.h,
      // ),
      Container(
        //color: Colors.black,
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  // Get.put(ProfileController(
                  //   controllerusername: posts[index].username.toString()
                  // ))
                  //     .getProfileInfo(posts[index].username.toString());
                  if(Get.isRegistered<CuratedPostController>()){
                    print("--CuratedPostController--");
                    final res = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          if (Get.find<CuratedPostController>()
                              .curatedPost
                              .value[index]
                              .mediaType ==
                              'video') {
                            currentVPZoom.pause();
                          }
                          return userProfile(
                            isUser: false,
                            username: posts[index].username.toString(),
                            //tag: "yourprofile",
                          );
                        }));
                    //Get.isRegistered<CuratedPostController>()
                    if (res == 200 ) {
                      if (Get.find<CuratedPostController>()
                          .curatedPost
                          .value[index]
                          .mediaType ==
                          'video') {
                        currentVPZoom.play();
                      }
                    }
                  }
                  else if(Get.isRegistered<VibedPostController>()){
                    print("--VibedPostController--");
                    final res = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          if (Get.find<VibedPostController>()
                              .vibePost
                              .value[index]
                              .mediaType ==
                              'video') {
                            currentVPZoom.pause();
                          }
                          return userProfile(
                            isUser: false,
                            username: posts[index].username.toString(),
                            //tag: "yourprofile",
                          );
                        }));
                    //Get.isRegistered<CuratedPostController>()
                    if (res == 200 ) {
                      if (Get.find<VibedPostController>()
                          .vibePost
                          .value[index]
                          .mediaType ==
                          'video') {
                        currentVPZoom.play();
                      }
                    }
                  }

                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 48.h,
                      width: 48.h,
                      child: CircleAvatar(
                        backgroundImage: Image.network(
                          posts[index].userProfilePic,
                          fit: BoxFit.fitHeight,
                        ).image,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    SizedBox(
                      height: 25.h,
                      //width: 200.w,
                      child: Text(
                        posts[index].username.length > 20
                            ? '${posts[index].username.substring(0, 19)}......'
                            : "@" + posts[index].username,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    posts[index].isVerified ? verifiedTag() : Container(),
                    const Spacer(
                      flex: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60.h,
                    width: 230.w,
                    child: Text(
                      posts[index].postText.toString(),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          // fontFamily: 'Poppins',
                          fontSize: 14,
                          height: 1),
                    ),
                  ),
                  /*Icon(
                      Icons.volume_down_rounded,
                      size: 35,
                      color: Colors.white,
                    )*/
                ],
              ),
            ],
          ))
    ],
  );
}

