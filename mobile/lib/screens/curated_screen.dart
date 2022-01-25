import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/screens/getpost.dart';
import 'package:mobile/screens/vibe_screen_zoom.dart';
import 'package:mobile/utils/constants.dart';

import 'package:mobile/utils/tuale_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Curated extends StatefulWidget {
  Curated({Key? key}) : super(key: globalCuratedState);

  static loadPosts(BuildContext context) {
    globalCuratedState.currentState!.loadPosts(context);
  }

  static final GlobalKey<_CuratedState> globalCuratedState =
      GlobalKey<_CuratedState>();

  Widget build(BuildContext context) {
    return Curated(key: globalCuratedState);
  }

  @override
  _CuratedState createState() => _CuratedState();
}

class _CuratedState extends State<Curated> {
  bool isLoading = true;
  int pageNo = 1;
  List posts = [];

  loadPosts(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    // Get Token
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get Posts
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response =
        await dio.get(hostAPI + getAllPosts + pageNo.toString());
    log(response.data.toString());
    var responseData = response.data;
    List postsResponses = responseData['posts'];
    if (responseData['success'].toString() == 'true') {
      for (int i = 0; i < postsResponses.length; i++) {
        setState(() {
          posts.add(PostDetails(
              userProfilePic: postsResponses[i]['user']['avatar']['url'],
              time: postsResponses[i]['createdAt'],
              postMedia: postsResponses[i]['media']['url'],
              postText: postsResponses[i]['caption'],
              noTuale: postsResponses[i]['tuales'].toList().length,
              noStar: postsResponses[i]['stars'].toList().length,
              noComment: postsResponses[i]['comments'].toList().length,
              username: postsResponses[i]['user']['username']));
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPosts(context);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: SpinKitFadingCircle(color: tualeOrange.withOpacity(0.75)))
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              bool tualed = false;
              int tualCount = 0;
              int starCount = 0;
              bool starred = false;

              return Container(
                margin: const EdgeInsets.only(
                    bottom: 10, left: 30, right: 30, top: 40),
                height: 480,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: Image.network(
                      posts[index].postMedia,
                      fit: BoxFit.fitHeight,
                    ).image,
                  ),
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return VibingZoom();
                    }));
                  },
                  child: Hero(
                    tag: "hero$index",
                    child: Container(
                      child: Stack(
                        children: [
                          Align(
                            widthFactor: 5,
                            alignment: const Alignment(1.1, 0.5),
                            child: SizedBox(
                              height: 350,
                              width: 100,
                              // color: Colors.white,
                              child: CustomPaint(
                                size: Size(
                                    100, (100 * 3.536842105263158).toDouble()),
                                painter: RPSCustomPainter(),
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,

                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // decoration: const BoxDecoration(boxShadow:  [BoxShadow(color: Colors.grey, blurRadius: 50)]),
                                          margin: const EdgeInsets.only(
                                              top: 12, bottom: 12),
                                          child: Column(
                                            children: [
                                              AnimatedCrossFade(
                                                duration:
                                                    const Duration(seconds: 1),
                                                crossFadeState: tualed
                                                    ? CrossFadeState.showSecond
                                                    : CrossFadeState.showFirst,
                                                secondChild: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      tualed = false;
                                                      tualCount = 0;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    TualeIcons.tualeactive,
                                                    color: tualeOrange,
                                                    size: 40,
                                                  ),
                                                ),
                                                firstChild: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      tualed = true;
                                                      tualCount = 1;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    TualeIcons.tuale,
                                                    color: Colors.white,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                              Text("$tualCount",
                                                  style: const TextStyle(
                                                      color: Colors.white))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 40)
                                              ]),
                                          margin: const EdgeInsets.only(
                                              top: 8, bottom: 12),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              AnimatedCrossFade(
                                                duration:
                                                    const Duration(seconds: 1),
                                                crossFadeState: starred
                                                    ? CrossFadeState.showSecond
                                                    : CrossFadeState.showFirst,
                                                secondChild: GestureDetector(
                                                  onTap: () {
                                                    Post().getPost();
                                                    setState(() {
                                                      starred = false;
                                                      starCount = 0;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    TualeIcons.star,
                                                    color: tualeOrange,
                                                    size: 33,
                                                  ),
                                                ),
                                                firstChild: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      starred = true;
                                                      starCount = 1;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    TualeIcons.star,
                                                    color: Colors.white,
                                                    size: 33,
                                                  ),
                                                ),
                                              ),
                                              Text("$starCount",
                                                  style: const TextStyle(
                                                      color: Colors.white))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 25)
                                              ]),
                                          margin: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Column(
                                            children: const [
                                              Icon(
                                                TualeIcons.comment,
                                                color: Colors.white,
                                                size: 27,
                                              ),
                                              Text(
                                                "0",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 25)
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
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 50,
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
                                            posts[index].username.toString(),
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
                                          const Text(
                                            "1 day ago",
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'Poppins',
                                              fontSize: 10,

                                              //height: 1
                                            ),
                                          ),
                                          const Spacer(
                                            flex: 10,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            posts[index].postText.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white70,
                                                // fontFamily: 'Poppins',
                                                fontSize: 14,
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
                          )
                        ],
                      ),
                      height: 480,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            begin: AlignmentDirectional(0.5, 0.5),
                            end: AlignmentDirectional(0.5, 1.4),
                            colors: [Colors.transparent, Colors.black87],
                          )),
                    ),
                  ),
                ),
              );
            },
          );
  }
}

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

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffDBDBDB).withOpacity(0.5);
//Colors.transparent;
    canvas.drawPath(path_0, paint0Fill);
    canvas.drawShadow(path_0, Colors.black87.withOpacity(0.2), 1, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

more(context) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {},
  );

  AlertDialog alert = AlertDialog(
    title: const Text("My title"),
    content: const Text("This is my message."),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// Class for a Post
class PostDetails {
  final String username;
  final String userProfilePic;
  final String time;
  final String postMedia;
  final String postText;
  final int noTuale;
  final int noStar;
  final int noComment;

  const PostDetails(
      {required this.userProfilePic,
      required this.time,
      required this.postMedia,
      required this.postText,
      required this.noTuale,
      required this.noStar,
      required this.noComment,
      required this.username});
}
