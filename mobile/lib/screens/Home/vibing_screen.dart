import 'dart:math';

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
  @override
  void initState() {
    super.initState();
    //  Api().getVibingPost();
    Api().getUserProfile("demilade211");
    print(Api.currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: Api().getVibingPost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
           List posts = snapshot.data ;
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data.length);

            if (snapshot.data.length == 0) {
              return Center(
                  child: Text("You haven't vibed with anyone yet :) "));
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
              
                bool tualed = false;
                int tualCount = 0;
                int starCount = 0;
                bool starred = false;

                return Container(
                  //container for main image
                  margin: EdgeInsets.only(
                      bottom: 10, left: 15, right: 15, top: 15.h),
                  height: 645.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
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
                        return VibingZoom(
                          post: posts[index],
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
                              alignment: const Alignment(1.08, 0.6),
                              child: sideBar(tualed, tualCount, index, starred,
                                 posts, starCount, context, ),
                            ),

                            //user post info
                            userInfo(context, index, posts)
                          ],
                        ),
                        height: 645.h,
                        width: 400.w,
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
          } else {
             return Center(
              child: SpinKitFadingCircle(color: tualeOrange.withOpacity(0.75)));
          }
         

              
        }
        
        
        );

        
  }
    SizedBox sideBar(bool tualed, int tualCount, int index, bool starred, List posts,
      int starCount, BuildContext context) {
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
                        duration: const Duration(seconds: 1),
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
                          child: Icon(
                            TualeIcons.tualeactive,
                            color: tualeOrange,
                            size: 40.sp,
                          ),
                        ),
                        firstChild: GestureDetector(
                          onTap: () {
                            setState(() {
                              tualed = true;
                              tualCount = 1;
                            });
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
                        duration: const Duration(seconds: 1),
                        crossFadeState: starred
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        secondChild: GestureDetector(
                          onTap: () {
                            setState(() {
                              starred = false;
                              starCount = 0;
                            });
                          },
                          child: Icon(
                            TualeIcons.star,
                            color: tualeOrange,
                            size: 33.sp,
                          ),
                        ),
                        firstChild: GestureDetector(
                          onTap: () {
                            setState(() {
                              starred = true;
                              starCount = 1;
                            });
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return 
                      userProfile(
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
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
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
