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
    
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder <List> (
      future: Api().getVibingPost() ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.connectionState == ConnectionState.done){
         print(snapshot.data.length);

          if (snapshot.data.length == 0 ){
            return Center(
            child: Text("You haven't vibed with anyone yet :) "));
          }
          return ListView.builder(
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin:
                  const EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 20),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    
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
                                                  const Duration(milliseconds: 20),
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
                                                style:
                                                    TextStyle(color: Colors.white))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey, blurRadius: 40)
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
                                                  const Duration(milliseconds: 20),
                                              crossFadeState: starred
                                                  ? CrossFadeState.showSecond
                                                  : CrossFadeState.showFirst,
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
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                              side: BorderSide(),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                                            ),
                                              useRootNavigator: true,
                                              context: context,
                                              builder: (context) => Container(
                                                    padding: EdgeInsets.only(
                                                        left: 15, right: 15, top: 15,),
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
                                                                (BuildContext
                                                                        context,
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
                                                                    SizedBox(
                                                                        width: 10),
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
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        FittedBox(
                                                                            child:
                                                                                SizedBox(
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              300,
                                                                          child:
                                                                              Text(
                                                                            "Was I high when I said this? Lol. I do not even remember writing this.",
                                                                            maxLines:
                                                                                3,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
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
                                                            const  SizedBox(
                                                                height: 45,
                                                                width: 45,
                                                                child: CircleAvatar(
                                                                  backgroundImage:
                                                                      AssetImage(
                                                                          'assets/images/demo_profile.png'),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 260,
                                                                  height: 53,
                                                                  child: TextField(
                                                                    maxLines: 7,
                                                                    decoration:
                                                                        InputDecoration(
                                                                          filled: true,
                                                                          fillColor: Colors.grey.shade100,
                                                                      contentPadding:
                                                                          const EdgeInsets
                                                                                  .fromLTRB(
                                                                              5,
                                                                              5,
                                                                              5,
                                                                              2),
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:  BorderSide(
                                                                            style: BorderStyle
                                                                                .solid,
                                                                            color: Colors
                                                                                .grey.shade300),
                                                                        borderRadius:
                                                                            BorderRadius
                                                                                .circular(7),
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
                                                                                .circular(7),
                                                                      ),
                                                                    ),
                                                                  )),
                                                              SizedBox(
                                                                height: 40,
                                                                width: 40,
                                                                child: CircleAvatar(
                                                                    backgroundColor:
                                                                        tualeBlueDark,
                                                                    child: Transform.rotate(
                                                                      angle: -pi/7,
                                                                      child: const Icon(
                                                                          Icons
                                                                              .send,
                                                                              color: Colors.white,
                                                                              ),
                                                                    )),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                        },
                                        child: Container(
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
                                                style:
                                                    TextStyle(color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey, blurRadius: 25)
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
                                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
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
        );
    
        }
        return  Center(
            child: SpinKitFadingCircle(color: tualeOrange.withOpacity(0.75)));

      }
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
