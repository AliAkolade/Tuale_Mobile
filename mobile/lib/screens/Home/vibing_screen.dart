import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/screens/Home/controllers/getVibedPost.dart';
import 'package:mobile/screens/Home/video_player_screen.dart';
import 'package:mobile/screens/imports.dart';
import 'package:mobile/screens/widgets/verifiedTag.dart';
import 'package:mobile/utils/Api.dart';
import 'package:share_plus/share_plus.dart';



class Vibing extends StatefulWidget {
  Vibing({Key? key}) : super(key: key);

  @override
  _VibingState createState() => _VibingState();
}

bool displayTualeAnimation = false;
final scrollController = ScrollController();
late VideoPlayerController currentVibingVP;

bool tualed = false;
int tualCount = 0;
int starCount = 0;
bool starred = false;

class _VibingState extends State<Vibing> {
  VibedPostController control = VibedPostController();

  @override
  void dispose() {
    Get.delete<VibedPostController>();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //  Api().getVibingPost();
    control = Get.put(VibedPostController());
    scrollController.addListener(scrollPosition);
    Api().getUserProfile("demilade211");

    print(Api.currentUserId);
  }

  void scrollPosition() {
    if (scrollController.position.atEdge) {
      final isTop = scrollController.position.pixels == 0;
      if (isTop) {
        print("at the top");
      } else {
        print("at tbe bottom");

        Get.find<VibedPostController>().getMoreVibePosts();
      }
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: control.getVibedPosts(),
        //Api().getVibingPost(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // List posts = snapshot.data;

            return GetBuilder<VibedPostController>(
                init: VibedPostController(),
                builder: (control) {
                  return ListView.builder(
                    controller: scrollController,
                    key: PageStorageKey<String>('VIBED'),
                    itemCount: control.vibePost.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      List posts = control.vibePost.value;

                      return Obx(() => Get.find<VibedPostController>()
                                  .vibePost
                                  .value[index]
                                  .mediaType !=
                              "image"
                          ?
                          // Display video
                          Container(
                              height: 645.h,
                              width: 400.w,
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 15, right: 15, top: 15.h),
                              decoration: BoxDecoration(
                                color: Colors.black,
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
                                              defaultMute: true,
                                              videoUrl: Get.find<
                                                      VibedPostController>()
                                                  .vibePost
                                                  .value[index]
                                                  .postMedia,
                                              cbController:
                                                  (VideoPlayerController vc) {
                                                debugPrint("-here vc-");
                                                currentVibingVP = vc;
                                              },
                                            ))),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onDoubleTap: () {
                                          debugPrint("User double tap");
                                        },
                                        onTap: () async {
                                          currentVibingVP.pause();
                                          final result = await Navigator.push(
                                              context, MaterialPageRoute(
                                                  builder: (context) {
                                            return VibingZoom(
                                                post: Get.find<
                                                        VibedPostController>()
                                                    .vibePost
                                                    .value,
                                                index: index);
                                          }));
                                          if (result == 200) currentVibingVP.play();
                                        },
                                        child: Hero(
                                          tag: "hero$index",
                                          child: Container(
                                            //Container for bottom gradient on image
                                            child: Stack(
                                              children: [
                                                Align(
                                                  widthFactor: 5,
                                                  alignment: const Alignment(
                                                      1.08, 0.6),
                                                  child: Obx(
                                                    () => _actionBar(
                                                        index: index,
                                                        posts: Get.find<
                                                                VibedPostController>()
                                                            .vibePost
                                                            .value),
                                                  ),
                                                ),

                                                //user post info
                                                Obx(() => userInfoVibingWidget(
                                                    context,
                                                    index,
                                                    Get.find<
                                                            VibedPostController>()
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
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Stack(children: [
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
                                // Give tuale when user double tap
                                // Visibility(
                                //   visible: displayTualeAnimation,
                                //   child: Align(
                                //     alignment: Alignment.center,
                                //     child: Icon(
                                //       TualeIcons.tuale,
                                //       color: Colors.yellow,
                                //       size: 100.sp,
                                //     ),
                                //   ),
                                // ),
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        debugPrint("User double tap");
                                        // TODO : make api request
                                        /*setState(() {
                                  displayTualeAnimation =  true;
                                });
                                Future.delayed(
                                  const Duration(seconds: 1), (){
                                    setState(() {
                                      displayTualeAnimation =  false;
                                    });
                                  }
                                );*/
                                      },
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return VibingZoom(
                                            post:
                                                Get.find<VibedPostController>()
                                                    .vibePost
                                                    .value,
                                            index: index,
                                          );
                                        }));
                                      },
                                      child: Hero(
                                        tag: "hero$index",
                                        child: Container(
                                          //Container for bottom gradient on image
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
                                          child: Stack(children: [
                                            Align(
                                                widthFactor: 5,
                                                alignment:
                                                    const Alignment(1.08, 0.6),
                                                child: Obx(
                                                  () => _actionBar(
                                                    index: index,
                                                    posts: Get.find<
                                                            VibedPostController>()
                                                        .vibePost
                                                        .value,
                                                  ),
                                                )),
                                            Obx(() => userInfoVibingWidget(
                                                context,
                                                index,
                                                Get.find<VibedPostController>()
                                                    .vibePost
                                                    .value))
                                          ]),
                                        ),
                                      ),
                                    ))
                              ])));
                    },
                  );
                });
          }
          return Center(
              child: SpinKitFadingCircle(color: tualeOrange.withOpacity(0.75)));
        });
  }

  //
}

Widget _commentsectionModal(
  BuildContext context,
  int index,
) {
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
          builder: (_) => Obx(
                () => _commentModal(
                  posts: Get.find<VibedPostController>().vibePost.value,
                  index: index,
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
          Obx(
            () => Text(
              Get.find<VibedPostController>()
                  .vibePost
                  .value[index]
                  .noComment
                  .toString(),
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ),
  );
}

Column userInfoVibingWidget(BuildContext context, int index, List posts) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  // Get.put(ProfileController(
                  //   controllerusername: posts[index].username.toString()
                  // ))
                  //     .getProfileInfo(posts[index].username.toString());
                  final res = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    if(Get.find<VibedPostController>()
                        .vibePost
                        .value[index]
                        .mediaType ==
                        'video') {currentVibingVP.pause();}
                    return userProfile(
                      isUser: false,
                      username: posts[index].username.toString(),
                      //tag: "yourprofile",
                    );
                  }));
                  if(res==200) {
                    if(Get.find<VibedPostController>()
                        .vibePost
                        .value[index]
                        .mediaType ==
                        'video'){currentVibingVP.play();}
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
                      //width: 165.w,
                      child: Text(
                        "@" + posts[index].username.toString(),
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
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
                      maxLines: 4,
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


class _actionBar extends StatefulWidget {
  List? posts;
  int? index;
  bool muteBtn;
  final Function()? notifyParent;

  _actionBar({this.posts, this.index, this.notifyParent,this.muteBtn=true,});

  @override
  State<_actionBar> createState() => __actionBarState();
}

class __actionBarState extends State<_actionBar> {
  int noStars = 0;
  bool isStarred = false;
  int noTuales = 0;
  bool isTualed = false;
  follow(String userId, BuildContext context) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    var headers = {'Authorization': token};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://tuale-mobile-api.herokuapp.com/api/v1/vibe/$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  share() {
    Share.share('Get Tuale!\nVisit https://www.tuale.app',
        subject: 'Install Tuale');
  }

  copy() async {
    await Clipboard.setData(const ClipboardData(text: "https://www.tuale.app"));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
  }

  delete(String postId, BuildContext context) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    var headers = {'Authorization': token};

    var request = http.Request(
        'DELETE',
        Uri.parse(
            'https://tuale-mobile-api.herokuapp.com/api/v1/post/$postId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("Here");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Post Deleted')));
      
        Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => Home(initialIndex: 0)),
                                          (Route<dynamic> route) => false);
    } else {
      print("Error");
      print(response.reasonPhrase);
    }
  }

  String currentUserID = '';
  getCurrentUser() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    var headers = {'Authorization': token};
    var request = http.Request(
        'GET', Uri.parse('https://tuale-mobile-api.herokuapp.com/api/v1/me'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString()["user"]["_id"]);
      Map valueMap = json.decode(await response.stream.bytesToString());
      // print(valueMap["user"]["_id"]);
      if(mounted){
        setState(() {
          currentUserID = valueMap["user"]["_id"];
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  List<ItemModel> checkUserPost(BuildContext context, String postUserId) {
    List<ItemModel> menuItems = [];
    if (postUserId == currentUserID) {
      menuItems = [
        ItemModel('Share', Icons.send),
        ItemModel('Copy Link', Icons.content_copy),
        ItemModel('Delete', Icons.delete)
      ];
    } else {
      menuItems = [
        // ItemModel('Follow', Icons.add),
        ItemModel('Share', Icons.send),
        ItemModel('Copy Link', Icons.content_copy),
      ];
    }
    return menuItems;
  }

  final CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void initState() {
    getCurrentUser();
    noStars = widget.posts![widget.index!].noStar;
    print("colorcheck$isStarred");
    // Get.find<CuratedPostController>().curatedPost.value[index].noStar;
    isStarred = widget.posts![widget.index!].isStared;
    print("colorcheck$isStarred");
    //Get.find<CuratedPostController>().curatedPost.value[index].isStared;

    noTuales = widget.posts![widget.index!].noTuale;
    isTualed = widget.posts![widget.index!].isTualed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h,
      width: 110.w,
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
                        duration: const Duration(milliseconds: 20),
                        crossFadeState: isTualed
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        secondChild: GestureDetector(
                          onTap: () async {
                            // debugPrint("tuales : ${widget.post?.tuales}");
                            // debugPrint("testme : $alreadyGiveTuale");

                            if (widget.posts![widget.index!].isTualed) {
                              //"61e327db86dcaee74311fa14"
                              debugPrint("User already give a tuale");
                            } else {
                              // var result = await Api()
                              //     .addTuale(posts[index].id ?? " ");
                              // if (result[0]) {
                              //   control.getCuratedPosts();
                              // } else {
                              //   // TODO : display message
                              //   debugPrint(result[1]);
                              // }
                            }
                          },
                          child: Icon(
                            TualeIcons.tualeactive,
                            color: Colors.yellow,
                            size: 40.sp,
                          ),
                        ),
                        firstChild: GestureDetector(
                          onTap: () async {
                            if (widget.posts![widget.index!].isTualed) {
                              //"61e327db86dcaee74311fa14"
                              debugPrint("User already give a tuale");
                            } else {
                              if (Get.find<LoggedUserController>()
                                      .loggedUser
                                      .value
                                      .noTuales! <
                                  2) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 40.h,
                                      width: 100.h,
                                      child: AlertDialog(
                                        // title: Text('Welcome'),
                                        content: Text(
                                            'Not enought Tuallet points \n to give this tuale'),
                                        actions: [
                                          GestureDetector(
                                            onTap: () async {
                                              if (Get.isRegistered<
                                                  VibedPostController>()) {
                                                //checks if mediatype is video
                                                Get.find<VibedPostController>()
                                                            .vibePost
                                                            .value[
                                                                widget.index!]
                                                            .mediaType ==
                                                        'video'
                                                    ? currentVibingVP.pause()
                                                    : print('no');
                                                final result =
                                                    await Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            child:
                                                                TualletHome()));
                                                if (result == 200 &&
                                                    Get.find<VibedPostController>()
                                                            .vibePost
                                                            .value[
                                                                widget.index!]
                                                            .mediaType ==
                                                        'video')
                                                  currentVibingVP.play();
                                              }
                                            },
                                            child: Container(
                                                height: 30,
                                                width: double.infinity,
                                                child: Center(
                                                  child: Text(
                                                      'Buy more Tuallet points',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: tualeBlueDark,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9))),
                                          ),
                                          // FlatButton(
                                          //   textColor: Colors.black,
                                          //   onPressed: () async {
                                          //     final result =
                                          //         await Navigator.push(
                                          //             context,
                                          //             PageTransition(
                                          //                 type:
                                          //                     PageTransitionType
                                          //                         .fade,
                                          //                 child:
                                          //                     TualletHome()));
                                          //   },
                                          //   child: Text('ACCEPT'),
                                          // ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                setState(() {
                                  isTualed = true;
                                  noTuales = noTuales + 1;
                                });
                                var result = await Api().addTuale(
                                    widget.posts![widget.index!].id ?? " ");
                                if (result[0]) {
                                  Get.find<VibedPostController>()
                                      .getVibedPosts();
                                } else {
                                  setState(() {
                                    isTualed = false;
                                    noTuales = noTuales - 1;
                                  });
                                  debugPrint(result[1]);
                                  Get.find<VibedPostController>()
                                      .getVibedPosts();
                                }
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
                      Text(noTuales.toString(),
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
                        duration: const Duration(milliseconds: 20),
                        crossFadeState: isStarred
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        secondChild: GestureDetector(
                          onTap: () async {
                            //when button is white on tap should make it yellow, isStarred ==true
                            if (isStarred) {
                              setState(() {
                                isStarred = false;
                                noStars = noStars - 1;
                              });
                              //checks if api response is ok to keep or discard local variable
                              var result = await Api().unStartPost(
                                  widget.posts![widget.index!].id ?? " ");
                              if (result[0] == true) {
                                debugPrint(result[1]);

                                Get.find<VibedPostController>().getVibedPosts();
                              } else {
                                setState(() {
                                  isStarred = true;
                                  noStars = noStars + 1;
                                  print('post got restarredddd whyyy');
                                });
                                debugPrint(result[1]);

                                Get.find<VibedPostController>().getVibedPosts();

                                ;
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
                            if (isStarred) {
                              debugPrint("User already star a post");
                            } else {
                              setState(() {
                                print("meant to set state");
                                isStarred = true;
                                noStars = noStars + 1;
                              });
                              var result = await Api().startPost(
                                  widget.posts![widget.index!].id ?? " ");
                              if (result[0] == true) {
                                Get.find<VibedPostController>().getVibedPosts();
                              } else {
                                setState(() {
                                  isStarred = false;
                                  noStars = noStars + 1;
                                });
                                debugPrint(result[1]);
                                Get.find<VibedPostController>().getVibedPosts();

                                debugPrint('herrre${result[1]}');
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
                      Text(noStars.toString(),
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                _commentsectionModal(context, widget.index!),
                // Container(
                //   decoration: const BoxDecoration(boxShadow: [
                //     BoxShadow(color: Colors.grey, blurRadius: 25)
                //   ]),
                //   margin: const EdgeInsets.only(top: 0, bottom: 12, right: 13),
                //   child: GestureDetector(
                //     onTap: () {},
                //     child: Icon(
                //       TualeIcons.elipsis,
                //       color: Colors.white,
                //       size: 25.sp,
                //     ),
                //   ),
                // )
                CustomPopupMenu(
                    arrowColor: const Color.fromRGBO(250, 250, 250, 1),
                    menuBuilder: () => ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: const Color.fromRGBO(250, 250, 250, 1),
                            child: IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: checkUserPost(context,
                                        widget.posts![widget.index!].userId)
                                    .map(
                                      (item) => GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          switch (item.title) {
                                            case "Follow":
                                              {
                                                var id = widget
                                                    .posts![widget.index!]
                                                    .userId;
                                                follow(id, context);
                                              }
                                              break;

                                            case "Share":
                                              {
                                                share();
                                              }
                                              break;
                                            case "Copy Link":
                                              {
                                                copy();
                                              }
                                              break;
                                            case "Delete":
                                              {
                                                var id = widget
                                                    .posts![widget.index!].id;
                                                delete(id, context);
                                              }
                                              break;
                                          }
                                          setState(() {
                                            _controller.hideMenu();
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                item.icon,
                                                size: 15,
                                                color: Color.fromRGBO(
                                                    76, 76, 76, 1),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(
                                                    item.title,
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          76, 76, 76, 1),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                    pressType: PressType.singleClick,
                    verticalMargin: -10,
                    controller: _controller,
                    child: Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 25)
                        ]),
                        margin: const EdgeInsets.only(
                            top: 0, bottom: 12, right: 13),
                        child: Icon(TualeIcons.elipsis,
                            color: Colors.white, size: 25.sp))),
                if(widget.muteBtn) Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 12),
                    child: Icon(
                      Icons.volume_off_rounded,
                      color: Colors.white,
                      size: 37.sp,
                    )
                ),
              ]),
        ),
      ),
    );
  }
}

class _commentModal extends StatefulWidget {
  List? posts;
  int? index;

  _commentModal({
    this.posts,
    this.index,
  });

  @override
  State<_commentModal> createState() => _commentModalState();
}

class _commentModalState extends State<_commentModal> {
  final myController = TextEditingController();
  late FocusNode _focusNode;
  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    // Clean up the controller when the widget is disposed.
    myController.dispose();
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
              child: widget.posts![widget.index!].comment.isEmpty
                  ? Center(child: Text('no comment'))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.posts![widget.index!].comment.length,
                      itemBuilder: (BuildContext context, int commentIndex) {
                        return Container(
                          //  color: Colors.blue,
                          margin: EdgeInsetsDirectional.only(top: 5),
                          // color: Colors.black,
                          height: 70.h,
                          width: ScreenUtil().screenWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 35.h,
                                width: 35.h,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(widget
                                          .posts![widget.index!]
                                          .comment[commentIndex]['user']
                                      ['avatar']['url']),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.posts![widget.index!]
                                            .comment[commentIndex]['user']
                                        ['username'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  FittedBox(
                                    child: SizedBox(
                                      height: 50.h,
                                      width: 250.w,
                                      child: Text(
                                        widget.posts![widget.index!]
                                            .comment[commentIndex]['text'],
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
                      backgroundImage:
                          AssetImage('assets/images/demo_profile.png'),
                    ),
                  ),
                  SizedBox(
                      width: 280.w,
                      height: 50.h,
                      child: TextField(
                        focusNode: _focusNode,
                        controller: myController,
                        maxLines: 7,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 2),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                style: BorderStyle.solid, color: Colors.grey),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      )),
                  GestureDetector(

                    onTap: () async {
                        Loader.show(context,
                          isSafeAreaOverlay: false,
                          isAppbarOverlay: true,
                          isBottomBarOverlay: false,
                          progressIndicator: SpinKitFadingCircle(
                              color: tualeOrange.withOpacity(0.75)),
                          themeData: Theme.of(context)
                              .copyWith(accentColor: Colors.black38),
                          overlayColor: const Color(0x99E8EAF6));
                       _focusNode.unfocus();
                      String comment = myController.text;
                               myController.clear();
                      List result = await Api().commentOnAPost(
                          widget.posts![widget.index!].id, comment);

                      if (result[0]) {
                          Loader.hide();
                        Get.find<VibedPostController>().getVibedPosts();
                      } else {
                          Loader.hide();
                        Get.snackbar("Error", result[1],
                            duration: Duration(seconds: 4),
                            isDismissible: true,
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: Colors.black,
                            backgroundColor: Colors.white);
                      }
                    },
                    child: SizedBox(
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
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
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

// more(context) {
//   print("heyy");
//   showAlertDialog(BuildContext context) {
//     // set up the button
//     Widget okButton = TextButton(
//       child: Text("OK"),
//       onPressed: () {},
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text("My title"),
//       content: Text("This is my message."),
//       actions: [
//         okButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
