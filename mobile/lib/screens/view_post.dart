import 'package:flutter/material.dart';
import 'package:mobile/screens/user_Profile_Screen.dart';
import 'package:mobile/screens/vibe_screen_zoom.dart';
import 'package:mobile/screens/vibing_screen.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/tuale_icons.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ViewPost extends StatefulWidget {
  int? index;

  ViewPost({this.index});

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  final ItemScrollController itemScrollControll = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    Future scrollToIndex(index) async {
      itemScrollControll.jumpTo(
        index: index,
        alignment: 0,
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
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 1,
            actions: const [
              Icon(TualeIcons.notificationbell, color: tualeBlueDark),
              SizedBox(
                width: 10,
              )
            ],
            title: const Text(
              "Discover",
              style: TextStyle(
                  color: tualeBlueDark,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: ScrollablePositionedList.builder(
              itemCount: 8,
              itemScrollController: itemScrollControll,
              itemPositionsListener: itemPositionsListener,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(
                      bottom: 10, left: 15, right: 15, top: 20),
                  height: 545,
                  width: 400,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/demoPost.png")),
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
                            //Add this CustomPaint widget to the Widget Tre                                //Add this CustomPaint widget to the Widget Tree
                            Align(
                              widthFactor: 5,
                              alignment: Alignment(1.07, 0.6),
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
                                                  duration: const Duration(
                                                      milliseconds: 20),
                                                  crossFadeState: tualed
                                                      ? CrossFadeState
                                                          .showSecond
                                                      : CrossFadeState
                                                          .showFirst,
                                                  secondChild: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        tualed = false;
                                                        tualCount = 0;
                                                      });
                                                    },
                                                    child: const Icon(
                                                      TualeIcons.tualeactive,
                                                      color: Color.fromRGBO(
                                                          255, 246, 166, 1),
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
                                                    style: TextStyle(
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
                                                  duration: const Duration(
                                                      milliseconds: 20),
                                                  crossFadeState: starred
                                                      ? CrossFadeState
                                                          .showSecond
                                                      : CrossFadeState
                                                          .showFirst,
                                                  secondChild: GestureDetector(
                                                    onTap: () {
                                                      // Post().getPost();
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
                                                const Text(
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return userProfile();
                                    }));
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                child: const CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      "assets/images/demo_profile.png"),
                                                ),
                                              ),
                                              const Spacer(
                                                flex: 1,
                                              ),
                                              const Text(
                                                "@Singe",
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
                                          Container(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                "There is always a light bulb in your head.\n #ideas run the world.",
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
                                          )),
                                        ],
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                        height: 545,
                        width: 400,
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
            ),
          ),
        ),
      ),
    );
  }
}
