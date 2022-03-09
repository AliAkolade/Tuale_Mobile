import 'package:get/get.dart';
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/screens/Home/video_player_screen.dart';
import 'package:mobile/screens/Profile/controllers/userPostsController.dart';
import 'package:mobile/screens/imports.dart';

class discoverScreen extends StatefulWidget {
  int? index;
  String? tag;

  discoverScreen({this.index, this.tag});

  @override
  _discoverScreenState createState() => _discoverScreenState();
}

class _discoverScreenState extends State<discoverScreen> {
  final ItemScrollController itemScrollControll = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    Future scrollToIndex(index) async {
      itemScrollControll.jumpTo(
        index: index,
        alignment: 0.1,
      );
    }

    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => scrollToIndex(widget.index));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            centerTitle: true,
            title: Text(
              "My Posts",
              style: TextStyle(
                  color: tualeBlueDark,
                  fontFamily: 'Poppins',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  height: 1),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: GetX<UserPostsController>(
                tag: widget.tag,
                builder: (userpostcontroller) {
                  return ScrollablePositionedList.builder(
                    itemCount: userpostcontroller.posts.length,
                    itemScrollController: itemScrollControll,
                    itemPositionsListener: itemPositionsListener,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(() => userpostcontroller
                                  .posts.value[index].mediaType !=
                              "image"
                          ?
                          // Display video
                          Container(
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
                                              videoUrl: Get.find<
                                                      UserPostsController>()
                                                  .posts
                                                  .value[index]
                                                  .postMedia,
                                                cbController: (VideoPlayerController vc){
                                                  debugPrint("-here vc-");
                                                }
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
                                        onTap: () {
                                          // Navigator.push(context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) {
                                          //   return VibingZoom(
                                          //       post: Get.find<
                                          //               CuratedPostController>()
                                          //           .curatedPost
                                          //           .value,
                                          //       index: index);
                                          // }));
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
                                                        posts:
                                                            userpostcontroller
                                                                .posts.value),
                                                  ),
                                                ),

                                                //user post info
                                                Obx(() => userInfoWidget(
                                                    context,
                                                    index,
                                                    userpostcontroller
                                                        .posts.value))
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
                              child: Stack(children: [
                                SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      userpostcontroller
                                          .posts.value[index].postMedia,
                                      // Get.find<CuratedPostController>()
                                      //     .curatedPost
                                      //     .value[index]
                                      //     .postMedia,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Give tuale when user double tap
                                Visibility(
                                  visible: displayTualeAnimation,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      TualeIcons.tuale,
                                      color: Colors.yellow,
                                      size: 100.sp,
                                    ),
                                  ),
                                ),
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
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (context) {
                                        //   return VibingZoom(
                                        //     post: userpostcontroller.posts.value,
                                        //     // Get.find<
                                        //     //         CuratedPostController>()
                                        //     //     .curatedPost
                                        //     //     .value,
                                        //     index: index,
                                        //   );
                                        // }));
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
                                                      posts: userpostcontroller
                                                          .posts.value),
                                                )),
                                            Obx(() => userInfoWidget(
                                                context,
                                                index,
                                                userpostcontroller.posts.value))
                                          ]),
                                        ),
                                      ),
                                    ))
                              ])));
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class _actionBar extends StatefulWidget {
  List? posts;
  int? index;
  String? tag;

  _actionBar({this.posts, this.index, this.tag});

  @override
  State<_actionBar> createState() => __actionBarState();
}

class __actionBarState extends State<_actionBar> {
  int noStars = 0;
  bool isStarred = false;
  int noTuales = 0;
  bool isTualed = false;

  @override
  void initState() {
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
                              setState(() {
                                isTualed = true;
                                noTuales = noTuales + 1;
                              });
                              var result = await Api().addTuale(
                                  widget.posts![widget.index!].id ?? " ");
                              if (result[0]) {
                                Get.find<UserPostsController>(tag: widget.tag)
                                    .getProfilePosts(
                                        Get.find<LoggedUserController>()
                                            .loggedUser
                                            .value
                                            .currentUserUsername!);
                              } else {
                                setState(() {
                                  isTualed = false;
                                  noTuales = noTuales - 1;
                                });
                                debugPrint(result[1]);
                                Get.find<UserPostsController>(tag: widget.tag)
                                    .getProfilePosts(
                                        Get.find<LoggedUserController>()
                                            .loggedUser
                                            .value
                                            .currentUserUsername!);
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
                                Get.find<UserPostsController>(tag: widget.tag)
                                    .getProfilePosts(
                                        Get.find<LoggedUserController>()
                                            .loggedUser
                                            .value
                                            .currentUserUsername!);
                                ;
                              } else {
                                setState(() {
                                  isStarred = true;
                                  noStars = noStars + 1;
                                  print('post got restarredddd whyyy');
                                });
                                debugPrint(result[1]);

                                Get.find<UserPostsController>(tag: widget.tag)
                                    .getProfilePosts(
                                        Get.find<LoggedUserController>()
                                            .loggedUser
                                            .value
                                            .currentUserUsername!);

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
                                Get.find<UserPostsController>(tag: widget.tag)
                                    .getProfilePosts(
                                        Get.find<LoggedUserController>()
                                            .loggedUser
                                            .value
                                            .currentUserUsername!);
                              } else {
                                setState(() {
                                  isStarred = false;
                                  noStars = noStars + 1;
                                });
                                debugPrint(result[1]);
                                Get.find<UserPostsController>(tag: widget.tag)
                                    .getProfilePosts(
                                        Get.find<LoggedUserController>()
                                            .loggedUser
                                            .value
                                            .currentUserUsername!);
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
                _commentsectionModal(
                  context,
                  widget.index!,
                ),
                Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 25)
                  ]),
                  margin: const EdgeInsets.only(top: 0, bottom: 12, right: 13),
                  child: GestureDetector(
                    onTap: () {},
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
                () => commentModal(
                  posts: Get.find<UserPostsController>().posts.value,
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
              Get.find<UserPostsController>()
                  .posts
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
