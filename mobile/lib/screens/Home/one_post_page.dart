import 'dart:convert';
import 'dart:math';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/screens/Home/controllers/getOnePostController.dart';
import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/screens/Home/video_player_screen.dart';
import 'package:mobile/screens/imports.dart';
import 'package:share_plus/share_plus.dart';

class OnePost extends StatefulWidget {
  String? id;
  String? mediaType;
  String? postMedia;
  bool pageType;

  OnePost({this.id, this.mediaType, this.postMedia, this.pageType = true});

  @override
  _OnePostState createState() => _OnePostState();
}

OnePostController post = OnePostController();
late VideoPlayerController currentVideoPlayer;

class _OnePostState extends State<OnePost> {
  @override
  void initState() {
    super.initState();
    post = Get.put(OnePostController(id: widget.id));
  }

  @override
  void dispose() {
    Get.delete<OnePostController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          child: Obx(
        () => post.isLoading.value
            ? Center(
                child:
                    SpinKitFadingCircle(color: tualeOrange.withOpacity(0.75)),
              )
            : widget.mediaType != "image"
                ? Container(
                    color: Colors.black,
                    child: Stack(
                      children: [
                        Icon(Icons.linked_camera_sharp),
                        VideoPlayerScreen(
                            videoUrl: widget.postMedia!,
                            enablePlayBtn: true,
                            cbController: (VideoPlayerController vc) {
                              currentVideoPlayer = vc;
                              debugPrint("-here vc-");
                            }),
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
                                  //Navigator.pop(context);
                                  widget.pageType
                                      ? Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Home()),
                                        )
                                      : Navigator.pop(
                                          context,
                                        );
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
                            child: Obx(
                              () => _actionBar(
                                mediaType: widget.mediaType,
                                posts: Get.find<OnePostController>()
                                    .postdetails
                                    .value,
                              ),
                            )),
                        Userinfo(context, widget.mediaType!)
                      ],
                    ),
                  )
                : Container(
                    child: Stack(
                      children: [
                        Align(
                          // heightFactor: 1.0,
                          // widthFactor: 12.0,
                          alignment: Alignment(0.9, -0.94),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Colors.white70,
                              child: GestureDetector(
                                onTap: () {
                                  widget.pageType
                                      ? Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Home()),
                                        )
                                      : Navigator.pop(
                                          context,
                                        );
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
                        // widget to the Widget Tre                                //Add this CustomPaint widget to the Widget Tree
                        Align(
                            widthFactor: 5,
                            alignment: const Alignment(1.08, 0.6),
                            child: Obx(
                              () => _actionBar(
                                mediaType: widget.mediaType,
                                posts: Get.find<OnePostController>()
                                    .postdetails
                                    .value,
                              ),
                            )),
                        //user post info
                        Userinfo(context, widget.mediaType!)
                      ],
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                post.postdetails.value.postMedia))),
                  ),
      )),
    );
  }

  Column Userinfo(BuildContext context, String mediaType) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final res = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      currentVideoPlayer.pause();
                      return userProfile(
                        isUser: false,
                        username: post.postdetails.value.username.toString(),
                        //tag: "yourprofile",
                      );
                    }));
                    if (res == 200) {
                      currentVideoPlayer.play();
                    }

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return userProfile(
                    //     isUser: false,
                    //     username: post.postdetails.value.username.toString(),
                    //     //  tag: "yourprofile",
                    //   );
                    // }));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              post.postdetails.value.userProfilePic),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        post.postdetails.value.username,
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
                      post.postdetails.value.isVerified
                          ? Container(
                              height: 17.h,
                              width: 17.h,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  size: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                      /*Text(
                                          "1 day ago",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'Poppins',
                                              fontSize: 12.sp,
                                              height: 1),
                                        ),*/
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
                          post.postdetails.value.postText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white70,
                            // fontFamily: 'Poppins',
                            fontSize: 15.sp,
                            height: 1,
                          ),
                        ),
                        Spacer(),
                        /*Icon(
                          Icons.volume_down_rounded,
                          size: 35.sp,
                          color: Colors.white,
                        )*/
                      ],
                    )),
              ],
            ))
      ],
    );
  }
}

//widget containing tuale, like, comments, etc
class _actionBar extends StatefulWidget {
  PostDetails? posts;
  String? mediaType;

  _actionBar({this.posts, this.mediaType});

  @override
  State<_actionBar> createState() => _actionBarState();
}

class _actionBarState extends State<_actionBar> {
  int noStars = 0;
  bool isStarred = false;
  int noTuales = 0;
  bool isTualed = false;
  final CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void initState() {
    noStars = widget.posts!.noStar;
    print("colorcheck$isStarred");
    // Get.find<CuratedPostController>().curatedPost.value[index].noStar;
    isStarred = widget.posts!.isStared;
    print("colorcheck$isStarred");
    //Get.find<CuratedPostController>().curatedPost.value[index].isStared;

    noTuales = widget.posts!.noTuale;
    isTualed = widget.posts!.isTualed;
    super.initState();
  }

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
      await Future.delayed(const Duration(seconds: 1));
      // Navigator.pop(context);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => NavBar(index: 1)),
          (Route<dynamic> route) => false);
      // pushNewScreen(context,
      //     screen: NavBar(index: 0),
      //     withNavBar: false,
      //     pageTransitionAnimation: PageTransitionAnimation.cupertino);
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
      if (mounted) {
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

                            if (widget.posts!.isTualed) {
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
                            if (widget.posts!.isTualed) {
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
                                              widget.mediaType == 'video'
                                                  ? currentVideoPlayer.pause()
                                                  : print('hi');
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
                                                  widget.mediaType == 'video')
                                                currentVideoPlayer.play();
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
                                var result =
                                    await Api().addTuale(widget.posts!.id);
                                if (result[0]) {
                                  Get.find<OnePostController>()
                                      .getOnePost(widget.posts!.id);
                                  Future<SharedPreferences> _prefs =
                                      SharedPreferences.getInstance();
                                  final SharedPreferences prefs = await _prefs;
                                  MixPanelSingleton.instance.mixpanel
                                      .track("GiveTuale", properties: {
                                    'User': prefs.getString('username') ?? ''
                                  });
                                  MixPanelSingleton.instance.mixpanel.flush();
                                } else {
                                  setState(() {
                                    isTualed = false;
                                    noTuales = noTuales - 1;
                                  });
                                  debugPrint(result[1]);
                                  Get.find<OnePostController>()
                                      .getOnePost(widget.posts!.id);
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
                              var result =
                                  await Api().unStartPost(widget.posts!.id);
                              if (result[0] == true) {
                                debugPrint(result[1]);
                                Get.find<OnePostController>()
                                    .getOnePost(widget.posts!.id);
                              } else {
                                setState(() {
                                  isStarred = true;
                                  noStars = noStars + 1;
                                  print('post got restarredddd whyyy');
                                });
                                debugPrint(result[1]);

                                Get.find<OnePostController>()
                                    .getOnePost(widget.posts!.id);

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
                              var result =
                                  await Api().startPost(widget.posts!.id);
                              if (result[0] == true) {
                                Get.find<OnePostController>()
                                    .getOnePost(widget.posts!.id);
                              } else {
                                setState(() {
                                  isStarred = false;
                                  noStars = noStars - 1;
                                });
                                debugPrint(result[1]);
                                Get.find<OnePostController>()
                                    .getOnePost(widget.posts!.id);
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
                ),
                CustomPopupMenu(
                    arrowColor: const Color.fromRGBO(250, 250, 250, 1),
                    menuBuilder: () => ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: const Color.fromRGBO(250, 250, 250, 1),
                            child: IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: checkUserPost(
                                        context, widget.posts!.userId)
                                    .map(
                                      (item) => GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          switch (item.title) {
                                            case "Follow":
                                              {
                                                var id = widget.posts!.userId;
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
                                                var id = widget.posts!.id;
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
                /*Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 25)
                  ]),
                  margin: const EdgeInsets.only(top: 0, bottom: 12, right: 13),
                  child: GestureDetector(
                    onTap: () {
                      Get.find<OnePostController>()
                          .getOnePost(widget.posts!.id);
                    },
                    child: Icon(
                      TualeIcons.elipsis,
                      color: Colors.white,
                      size: 25.sp,
                    ),
                  ),
                )*/
              ]),
        ),
      ),
    );
  }
}

Widget _commentsectionModal(
  BuildContext context,
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
                  posts: Get.find<OnePostController>().postdetails.value,
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
              Get.find<OnePostController>()
                  .postdetails
                  .value
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

class _commentModal extends StatefulWidget {
  PostDetails? posts;

  _commentModal({
    this.posts,
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
              child: widget.posts!.comment!.isEmpty
                  ? Center(child: Text('no comment'))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.posts!.comment!.length,
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
                                  backgroundImage: NetworkImage(
                                      widget.posts!.comment![commentIndex]
                                          ['user']['avatar']['url']),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.posts!.comment![commentIndex]['user']
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
                                        widget.posts!.comment![commentIndex]
                                            ['text'],
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
                      backgroundImage: NetworkImage(
                          Get.find<LoggedUserController>()
                              .loggedUser
                              .value
                              .currentuserAvatarUrl!),
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
                      List result = await Api()
                          .commentOnAPost(widget.posts!.id, myController.text);

                      if (result[0]) {
                        Loader.hide();
                        Get.find<OnePostController>()
                            .getOnePost(widget.posts!.id);
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

//painter for that nice curve you see on each post :)
