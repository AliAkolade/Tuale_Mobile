import 'dart:math';

import 'package:get/get.dart';
import 'package:mobile/screens/Home/controllers/getVibedPost.dart';
import 'package:mobile/screens/Home/video_player_screen.dart';
import 'package:mobile/screens/imports.dart';
import 'package:mobile/utils/Api.dart';

class Vibing extends StatefulWidget {
  Vibing({Key? key}) : super(key: key);

  @override
  _VibingState createState() => _VibingState();
}

bool tualed = false;
int tualCount = 0;
int starCount = 0;
bool starred = false;

class _VibingState extends State<Vibing> {
  VibedPostController control = VibedPostController();

  @override
  void initState() {
    super.initState();
    //  Api().getVibingPost();
    Api().getUserProfile("demilade211");
    control = Get.put(VibedPostController());
    print(Api.currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: control.getVibedPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List posts = control.vibePost.value;
          if (snapshot.connectionState == ConnectionState.done) {
            print(control.vibePost.value.length);

            if (control.vibePost.value.length == 0) {
              return Center(
                  child: Text("You haven't vibed with anyone yet :) "));
            }
            return ListView.builder(
              itemCount: control.vibePost.value.length,
              itemBuilder: (BuildContext context, int index) {
                bool tualed = false;
                int tualCount = 0;
                int starCount = 0;
                bool starred = false;

                return Obx(

                  () => Get.find<VibedPostController>()
                              .vibePost
                              .value[index]
                              .mediaType !=
                          "image"
                      ? Container(
                          height: 645.h,
                          width: 400.w,
                          margin: EdgeInsets.only(
                              bottom: 10, left: 15, right: 15, top: 15.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: double.infinity,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SizedBox(
                                        height: 645.h,
                                        width: 400.w,
                                        child: VideoPlayerScreen(
                                          videoUrl:
                                              Get.find<VibedPostController>()
                                                  .vibePost
                                                  .value[index]
                                                  .postMedia,
                                        ))),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return VibingZoom(
                                          post: Get.find<VibedPostController>()
                                              .vibePost
                                              .value[index],
                                        );
                                      }));
                                    },
                                    child: Hero(
                                      tag: "hero$index",
                                      child: Container(
                                        //Container for bottom gradient on image
                                        child: Stack(
                                          children: [
                                            Align(
                                              widthFactor: 5,
                                              alignment:
                                                  const Alignment(1.08, 0.6),
                                              child: Obx(
                                                () => sideBar(
                                                    tualed,
                                                    tualCount,
                                                    index,
                                                    starred,
                                                    starCount,
                                                    context,
                                                    Get.find<
                                                            VibedPostController>()
                                                        .vibePost
                                                        .value),
                                              ),
                                            ),

                                            //user post info
                                            Obx(() => userInfo(
                                                context,
                                                index,
                                                Get.find<VibedPostController>()
                                                    .vibePost
                                                    .value))
                                          ],
                                        ),
                                        height: 645.h,
                                        width: 400.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            gradient: const LinearGradient(
                                              begin: AlignmentDirectional(
                                                  0.5, 0.5),
                                              end: AlignmentDirectional(
                                                  0.5, 1.4),
                                              colors: [
                                                Colors.transparent,
                                                Colors.black87
                                              ],
                                            )),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      : Container(
                          height: 645.h,
                          width: 400.w,
                          margin: EdgeInsets.only(
                              bottom: 10, left: 15, right: 15, top: 15.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: double.infinity,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    Get.find<VibedPostController>()
                                        .vibePost
                                        .value[index]
                                        .postMedia,
                                    fit: BoxFit.cover,

                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return VibingZoom(
                                          post: Get.find<VibedPostController>()
                                              .vibePost
                                              .value[index],
                                        );
                                      }));
                                    },
                                    child: Hero(
                                      tag: "hero$index",
                                      child: Container(
                                        //Container for bottom gradient on image
                                        child: Stack(
                                          children: [
                                            Align(
                                              widthFactor: 5,
                                              alignment:
                                                  const Alignment(1.08, 0.6),
                                              child: Obx(
                                                () => sideBar(
                                                    tualed,
                                                    tualCount,
                                                    index,
                                                    starred,
                                                    starCount,
                                                    context,
                                                    Get.find<
                                                            VibedPostController>()
                                                        .vibePost
                                                        .value),
                                              ),
                                            ),

                                            //user post info
                                            Obx(() => userInfo(
                                                context,
                                                index,
                                                Get.find<VibedPostController>()
                                                    .vibePost
                                                    .value))
                                          ],
                                        ),
                                        height: 645.h,
                                        width: 400.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            gradient: const LinearGradient(
                                              begin: AlignmentDirectional(
                                                  0.5, 0.5),
                                              end: AlignmentDirectional(
                                                  0.5, 1.4),
                                              colors: [
                                                Colors.transparent,
                                                Colors.black87
                                              ],
                                            )),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                );
              },
            );
          } else {
            return Center(
                child:
                    SpinKitFadingCircle(color: tualeOrange.withOpacity(0.75)));
          }
        });
  }

  SizedBox sideBar(bool tualed, int tualCount, int index, bool starred,
      int starCount, BuildContext context, List posts) {
    return SizedBox(
      height: 400.h,
      width: 100.w,
      // color: Colors.white,
      child: CustomPaint(
        size: Size(100, (100 * 3.536842105263158).toDouble()),
        painter: CuratedLikeWidget(),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,

              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // decoration: const BoxDecoration(boxShadow:  [BoxShadow(color: Colors.grey, blurRadius: 50)]),
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Column(
                    children: [
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 1),
                        crossFadeState: posts[index].isTualed
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        secondChild: GestureDetector(
                          onTap: () async {
                            // debugPrint("tuales : ${widget.post?.tuales}");
                            // debugPrint("testme : $alreadyGiveTuale");

                            if (posts[index].isTualed) {
                              //"61e327db86dcaee74311fa14"
                              debugPrint("User already give a tuale");
                            } else {
                              var result =
                                  await Api().addTuale(posts[index].id ?? " ");
                              if (result[0]) {
                                control.getVibedPosts();
                              } else {
                                // TODO : display message
                                debugPrint(result[1]);
                              }
                            }
                          },
                          child: Icon(
                            TualeIcons.tualeactive,
                            color: tualeOrange,
                            size: 40.sp,
                          ),
                        ),
                        firstChild: GestureDetector(
                          onTap: () async {
                            if (posts[index].isTualed) {
                              //"61e327db86dcaee74311fa14"
                              debugPrint("User already give a tuale");
                            } else {
                              var result =
                                  await Api().addTuale(posts[index].id ?? " ");
                              if (result[0]) {
                                control.getVibedPosts();
                              } else {
                                // TODO : display message
                                debugPrint(result[1]);
                              }
                            }
                          },
                          child: Icon(
                            TualeIcons.tuale,
                            color: Colors.white,
                            size: 43.sp,
                          ),
                        ),
                      ),
                      Text(posts[index].noTuale.toString(),
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 40)
                  ]),
                  margin: const EdgeInsets.only(top: 8, bottom: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 1),
                        crossFadeState: posts[index].isStared
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        secondChild: GestureDetector(
                          onTap: () async {
                            if (posts[index].isStared) {
                              var result = await Api()
                                  .unStartPost(posts[index].id ?? " ");
                              if (result[0]) {
                                control.getVibedPosts();
                                debugPrint(result[1]);
                              } else {
                                // TODO : display message
                                debugPrint(result[1]);
                              }
                            } else {
                              debugPrint("User already unstar a post");
                            }
                          },
                          child: Icon(
                            TualeIcons.star,
                            color: tualeOrange,
                            size: 33.sp,
                          ),
                        ),
                        firstChild: GestureDetector(
                          onTap: () async {
                            if (posts[index].isStared) {
                              debugPrint("User already star a post");
                            } else {
                              var result =
                                  await Api().startPost(posts[index].id ?? " ");
                              if (result[0]) {
                                debugPrint(result[1]);
                                control.getVibedPosts();
                              } else {
                                // TODO : display message
                                debugPrint(result[1]);
                              }
                            }
                          },
                          child: Icon(
                            TualeIcons.star,
                            color: Colors.white,
                            size: 37.sp,
                          ),
                        ),
                      ),
                      Text(posts[index].noStar.toString(),
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                commentSectionModal(context),
                Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 25)
                  ]),
                  margin: const EdgeInsets.only(top: 0, bottom: 12, right: 13),
                  child: GestureDetector(
                    onTap: () {
                      more(context);
                    },
                    child: Icon(
                      TualeIcons.elipsis,
                      color: Colors.white,
                      size: 25.sp,
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

Column userInfo(BuildContext context, int index, List posts) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Get.put(ProfileController(
                  //   controllerusername: posts[index].username.toString()
                  // ))
                  //     .getProfileInfo(posts[index].username.toString());
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return userProfile(
                      isUser: false,
                      username: posts[index].username.toString(),
                      tag: "yourprofile",
                    );
                  }));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 52.h,
                      width: 52.h,
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
                    Text(
                      "@" + posts[index].username.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Text(
                      "1 day ago",
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,

                        //height: 1
                      ),
                    ),
                    const Spacer(
                      flex: 10,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    posts[index].postText.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white70,
                        // fontFamily: 'Poppins',
                        fontSize: 15.sp,
                        height: 1),
                  ),
                  Icon(
                    Icons.volume_down_rounded,
                    size: 35,
                    color: Colors.white,
                  )
                ],
              ),
            ],
          ))
    ],
  );
}

GestureDetector commentSectionModal(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              side: BorderSide(),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          useRootNavigator: true,
          isScrollControlled: true,
          enableDrag: true,
          context: context,
          builder: (context) => Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 15,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Comments"),
                      SizedBox(
                        height: 370.h,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              //  color: Colors.blue,
                              margin: EdgeInsetsDirectional.only(top: 5),
                              // color: Colors.black,
                              height: 85.h,
                              width: ScreenUtil().screenWidth,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 35.h,
                                    width: 35.h,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/demo_profile.png'),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "siphie_z0",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      FittedBox(
                                        child: SizedBox(
                                          height: 58.h,
                                          width: 250.w,
                                          child: Text(
                                            "Was I high when I said this? Lol. I do not even remember writing this hfhfhhfhfhfhfhfhfhfhfhfhfhfhfhfhf.",
                                            maxLines: 6,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 15.sp),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 45.h,
                              width: 45.h,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/demo_profile.png'),
                              ),
                            ),
                            SizedBox(
                                width: 280.w,
                                height: 50.h,
                                child: TextField(
                                  maxLines: 7,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 2),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          style: BorderStyle.solid,
                                          color: Colors.grey),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 43.h,
                              width: 43.h,
                              child: CircleAvatar(
                                  backgroundColor: tualeBlueDark,
                                  child: Transform.rotate(
                                    angle: -pi / 7,
                                    child: const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
    },
    child: Container(
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 25)]),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Icon(
            TualeIcons.comment,
            color: Colors.white,
            size: 29.sp,
          ),
          const Text(
            "0",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ),
  );
}

//Custom painter for nice curvy  widget
//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1157895, size.height * 0.2124283);
    path_0.cubicTo(
        size.width * 0.1157895,
        size.height * 0.1663890,
        size.width * 0.2632705,
        size.height * 0.1312932,
        size.width * 0.4260137,
        size.height * 0.1297571);
    path_0.cubicTo(
        size.width * 0.6470853,
        size.height * 0.1276705,
        size.width * 0.9052632,
        size.height * 0.1104774,
        size.width * 0.9052632,
        size.height * 0.04154315);
    path_0.cubicTo(
        size.width * 0.9052632,
        size.height * -0.07900000,
        size.width * 0.9052632,
        size.height * 1.079943,
        size.width * 0.9052632,
        size.height * 0.9652113);
    path_0.cubicTo(
        size.width * 0.9052632,
        size.height * 0.8969643,
        size.width * 0.6259158,
        size.height * 0.8753720,
        size.width * 0.3995568,
        size.height * 0.8690804);
    path_0.cubicTo(
        size.width * 0.2470221,
        size.height * 0.8648393,
        size.width * 0.1157895,
        size.height * 0.8306071,
        size.width * 0.1157895,
        size.height * 0.7872738);
    path_0.lineTo(size.width * 0.1157895, size.height * 0.2124283);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffDBDBDB).withOpacity(0.5);
//Colors.transparent;
    canvas.drawPath(path_0, paint_0_fill);
    canvas.drawShadow(path_0, Colors.black87.withOpacity(0.2), 1, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

more(context) {
  print("heyy");
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
