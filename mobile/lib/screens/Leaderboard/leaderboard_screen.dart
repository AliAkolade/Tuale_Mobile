
import 'package:mobile/screens/imports.dart';



class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);
  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

bool vibe = false;

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: RichText(
            text:  TextSpan(
                text: "Tua",
                style: TextStyle(
                    color: tualeOrange,
                    fontFamily: 'Poppins',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    height: 1),
                children: [
              TextSpan(
                text: "Leaderboard",
                style: TextStyle(
                    color: tualeBlueDark,
                    fontFamily: 'Poppins',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    height: 1),
              )
            ])),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          const  SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:  [
                Spacer(
                  flex: 3,
                ),
                Text(
                  "User",
                  style: TextStyle(
                      color: tualeBlueDark,
                      fontFamily: 'Poppins',
                      fontSize: 17.sp,
                      height: 1),
                ),
                Spacer(
                  flex: 4,
                ),
                Text(
                  "Tuales Given",
                  style: TextStyle(
                      color: tualeBlueDark,
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      height: 1),
                ),
                Spacer(flex: 2,)
              ],
            ),
            Container(
            
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 14,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                  
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15.h,
                        ),
                         Text(
                          "1.",
                          style: TextStyle(
                              color: tualeBlueDark,
                              fontFamily: 'Poppins',
                              fontSize: 19.sp,
                              height: 1),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                         Icon(
                          TualeIcons.usericon,
                          color: Colors.grey,
                          size: 45.sp,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Enoke Lade",
                              style: TextStyle(
                                color: tualeBlueDark,
                                fontFamily: 'Poppins',
                                fontSize: 17.sp,
                              ),
                            ),
                            Text(
                              "@Streamygirl_",
                              style: TextStyle(
                                color: tualeBlueDark.withOpacity(0.5),
                                fontFamily: 'Poppins',
                                fontSize: 13.sp,
                                height: 1,
                              ),
                            )
                          ],
                        ),
                        const Spacer(
                          flex: 6,
                        ),
                         Text(
                          '1151',
                          style: TextStyle(
                            color: tualeBlueDark,
                            fontFamily: 'Poppins',
                            fontSize: 22.sp,
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 100),
                          crossFadeState: vibe
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          secondChild: GestureDetector(
                            onTap: () {
                              setState(() {
                                vibe = false;
                              });
                            },
                            child: Container(
                                height: 33.h,
                                width: 33.h,
                                child: SvgPicture.asset(
                                    "assets/icon/vibingUser.svg")),
                          ),
                          firstChild: GestureDetector(
                              onTap: () {
                                setState(() {
                                  vibe = true;
                                });
                              },
                              child: Container(
                                  height: 33.h,
                                  width: 33.h,
                                  child:
                                      SvgPicture.asset("assets/icon/vibe.svg"))),
                        ),
                        const Spacer(
                          flex: 2,
                        )
                      ],
                    ),
                    height: 74.h,
                    margin: const EdgeInsets.only(
                      bottom: 5,
                      top: 0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      borderRadius : const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.4), offset: Offset(0, 1.3))
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 13.h,)
          ],
        ),
      ),
    );
  }
}
