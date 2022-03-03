import 'dart:math';

import 'package:get/get.dart';
import 'package:mobile/screens/Home/controllers/getVibedPost.dart';
import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/screens/imports.dart';

import 'controllers/getCuratedPost.dart';

class VibingZoom extends StatefulWidget {
  int? index;
  List? post;

  VibingZoom({this.index, this.post});
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
          child: Stack(
            children: [
              Align(
                // heightFactor: 1.0,
                // widthFactor: 12.0,
                alignment: Alignment(1.2, -1.05),
                child: SizedBox(
                  height: 100,
                  width: 130,
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
              //Add this CustomPaint widget to the Widget Tre                                //Add this CustomPaint widget to the Widget Tree
              Align(
                heightFactor: 1.9,
                alignment: Alignment(1.06, 0.78),
                child: Container(
                  height: 350,
                  width: 100,
                  // color: Colors.white,
                  child: CustomPaint(
                    size: Size(
                        100,
                        (100 * 3.536842105263158)
                            .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainter(),
                    child: Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,

                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // decoration: const BoxDecoration(boxShadow:  [BoxShadow(color: Colors.grey, blurRadius: 50)]),
                              margin:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              child: Column(
                                children: [
                                  AnimatedCrossFade(
                                    duration: const Duration(seconds: 1),
                                    crossFadeState:
                                        widget.post![widget.index!].isTualed
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                    secondChild: GestureDetector(
                                      onTap: () async {
                                        // debugPrint("tuales : ${widget.post?.tuales}");
                                        // debugPrint("testme : $alreadyGiveTuale");

                                        if (widget
                                            .post![widget.index!].isTualed) {
                                          //"61e327db86dcaee74311fa14"
                                          debugPrint(
                                              "User already give a tuale");
                                        } else {
                                          var result = await Api().addTuale(
                                              widget.post![widget.index!].id);
                                          if (result[0]) {
                                            Get.find<CuratedPostController>()
                                                .getCuratedPosts();
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
                                        if (widget
                                            .post![widget.index!].isTualed) {
                                          //"61e327db86dcaee74311fa14"
                                          debugPrint(
                                              "User already give a tuale");
                                        } else {
                                          var result = await Api().addTuale(
                                              widget.post![widget.index!].id);
                                          if (result[0]) {
                                            debugPrint(result[1]);
                                            Get.find<CuratedPostController>()
                                                .getCuratedPosts();
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
                                  Text(
                                      widget.post![widget.index!].noTuale
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ))
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
                                    crossFadeState:
                                        widget.post![widget.index!].isStared
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                    secondChild: GestureDetector(
                                      onTap: () async {
                                        if (widget
                                            .post![widget.index!].isStared) {
                                          var result = await Api().unStartPost(
                                              widget.post![widget.index!].id ??
                                                  " ");
                                          if (result[0]) {
                                           Get.isRegistered<
                                                    CuratedPostController>()
                                                ? Get.find<
                                                        CuratedPostController>()
                                                    .getCuratedPosts()
                                                : Get.find<
                                                    VibedPostController>();
                                            debugPrint(result[1]);
                                          } else {
                                            // TODO : display message
                                            debugPrint(result[1]);
                                          }
                                        } else {
                                          debugPrint(
                                              "User already unstar a post");
                                        }
                                      },
                                      child: const Icon(
                                        TualeIcons.star,
                                        color: tualeOrange,
                                        size: 33,
                                      ),
                                    ),
                                    firstChild: GestureDetector(
                                      onTap: () async {
                                        if (widget
                                            .post![widget.index!].isStared) {
                                          debugPrint(
                                              "User already star a post");
                                        } else {
                                          var result = await Api().startPost(
                                              widget.post![widget.index!].id ??
                                                  " ");
                                          if (result[0]) {
                                            debugPrint(result[1]);
                                            Get.isRegistered<
                                                    CuratedPostController>()
                                                ? Get.find<
                                                        CuratedPostController>()
                                                    .getCuratedPosts()
                                                : Get.find<
                                                    VibedPostController>();
                                          } else {
                                            // TODO : display message
                                            debugPrint(result[1]);
                                          }
                                        }
                                      },
                                      child: const Icon(
                                        TualeIcons.star,
                                        color: Colors.white,
                                        size: 33,
                                      ),
                                    ),
                                  ),
                                  Text(
                                      widget.post![widget.index!].noStar
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ))
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        side: BorderSide(),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    useRootNavigator: true,
                                    enableDrag: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.55,
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 15,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text("Comments"),
                                                SizedBox(
                                                  height: 300,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: 3,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Container(
                                                        //color: Colors.blue,
                                                        margin:
                                                            EdgeInsetsDirectional
                                                                .only(top: 15),
                                                        // color: Colors.black,
                                                        height: 100,
                                                        width: 100,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              height: 35,
                                                              width: 35,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        'assets/images/demo_profile.png'),
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: const [
                                                                Text(
                                                                  "siphie_z0",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                FittedBox(
                                                                    child:
                                                                        SizedBox(
                                                                  height: 30,
                                                                  width: 230,
                                                                  child: Text(
                                                                    "Was I high when I said this? Lol. I do not even remember writing this.",
                                                                    maxLines: 3,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                )),
                                                                Text(
                                                                  "Reply",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                )
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const SizedBox(
                                                        height: 45,
                                                        width: 45,
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/demo_profile.png'),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: 200,
                                                          height: 50,
                                                          child: TextField(
                                                            maxLines: 7,
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey
                                                                  .shade100,
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      5,
                                                                      5,
                                                                      5,
                                                                      2),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    style: BorderStyle
                                                                        .solid,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    style: BorderStyle
                                                                        .solid,
                                                                    color: Colors
                                                                        .grey),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                              ),
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 40,
                                                        child: CircleAvatar(
                                                            backgroundColor:
                                                                tualeBlueDark,
                                                            child: Transform
                                                                .rotate(
                                                              angle: -pi / 7,
                                                              child: const Icon(
                                                                Icons.send,
                                                                color: Colors
                                                                    .white,
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
                                decoration: const BoxDecoration(boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 25)
                                ]),
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Column(
                                  children: const [
                                    Icon(
                                      TualeIcons.comment,
                                      color: Colors.white,
                                      size: 27,
                                    ),
                                    const Text(
                                      "0",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(color: Colors.grey, blurRadius: 25)
                              ]),
                              margin: const EdgeInsets.only(
                                  top: 0, bottom: 12, right: 13),
                              child: GestureDetector(
                                onTap: () {
                                  more(context);
                                },
                                child: const Icon(
                                  TualeIcons.elipsis,
                                  color: Colors.white,
                                  size: 23,
                                ),
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),

              //user post info
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return userProfile(
                                  isUser: false,
                                  username: widget.post![widget.index!].username
                                      .toString(),
                                  tag: "yourprofile",
                                );
                              }));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(widget
                                        .post![widget.index!].userProfilePic),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Text(
                                  widget.post![widget.index!].username,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 18.sp,
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
                                      height: 1),
                                ),
                                const Spacer(
                                  flex: 15,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                              // color: Colors.white70,
                              height: 55.h,
                              width: 950.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.post![widget.index!].postText,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      // fontFamily: 'Poppins',
                                      fontSize: 15.sp,
                                      height: 1,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.volume_down_rounded,
                                    size: 35.sp,
                                    color: Colors.white,
                                  )
                                ],
                              )),
                        ],
                      ))
                ],
              )
            ],
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.post![widget.index!].postMedia))),
        ),
      ),
    );
  }
}
