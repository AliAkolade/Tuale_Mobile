import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/screens/Leaderboard/leaderboardController.dart';
import 'package:mobile/screens/imports.dart';
import 'package:mobile/screens/widgets/verifiedTag.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);
  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

bool vibe = false;
LeaderboardController leaderboard = LeaderboardController();

class _LeaderboardState extends State<Leaderboard> {
  @override
  void initState() {
    leaderboard = Get.put(LeaderboardController());

    super.initState();
  }

  bool isFollowing(String id) {
    bool followed = false;
    for (var i in Get.find<LoggedUserController>().loggedUser.value.friends!) {
      // print(i['user']);
      if (id == i["user"]) {
        followed = true;
        break;
      } else {
        followed = false;
      }
    }

    return followed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: RichText(
            text: TextSpan(
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
      body: Obx(
        () => leaderboard.isLoading.value
            ? Center(
                child:
                    SpinKitFadingCircle(color: tualeOrange.withOpacity(0.75)),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
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
                       const Spacer(
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
                       const Spacer(
                          flex: 2,
                        )
                      ],
                    ),
                Container(
                      child: Obx(

                        () => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: leaderboard.leaderboard.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                
                                  SizedBox(
                                    height: 20.h,
                                    width: 20.h,
                                    child: Text(
                                      "${index + 1}.",
                                      style: TextStyle(
                                          color: tualeBlueDark,
                                          fontFamily: 'Poppins',
                                          fontSize: 19.sp,
                                          height: 1),
                                    ),
                                  ),
                                  Container(
                                    color:  Colors.black,
                                    width: 15.w,
                                  ),
                                  Icon(
                                    TualeIcons.usericon,
                                    color: Colors.grey,
                                    size: 45.sp,
                                  ),
                                  Container(
                                    color: Colors.blue,
                                    width: 5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            leaderboard
                                                .leaderboard.value[index].name,
                                            style: TextStyle(
                                              color: tualeBlueDark,
                                              fontFamily: 'Poppins',
                                              fontSize: 17.sp,
                                            ),
                                          ),
                                         leaderboard.leaderboard.value[index].isVerified ? verifiedTag() :Container()
                                        ],
                                      ),
                                      Text(
                                        "@" +
                                            leaderboard.leaderboard.value[index]
                                                .username,
                                        style: TextStyle(
                                          color: tualeBlueDark.withOpacity(0.5),
                                          fontFamily: 'Poppins',
                                          fontSize: 13.sp,
                                          height: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                 Spacer(
                                   flex: 2,
                                 ),
                                  SizedBox(
                                    height: 26.h,
                                    width: 26.h,
                                    child: Text(
                                      leaderboard
                                          .leaderboard.value[index].noTuales
                                          .toString(),
                                      style: TextStyle(
                                        color: tualeBlueDark,
                                        fontFamily: 'Poppins',
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                  ),
                              SizedBox(
                                width: 55.w,
                              ),
                                leaderboard.leaderboard.value[index].id == Get.find<LoggedUserController>().loggedUser.value.currentuserid ? Container(
                                  height: 33.h,
                                  width: 33.h,
                                ) : AnimatedCrossFade(
                                    duration: const Duration(milliseconds: 100),
                                    crossFadeState: isFollowing(leaderboard
                                            .leaderboard.value[index].id)
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    secondChild: GestureDetector(
                                      onTap: () {
                                        Api()
                                            .unvibeWithUser(
                                                leaderboard.leaderboard
                                                    .value[index].id,
                                                leaderboard.leaderboard
                                                    .value[index].username)
                                            .then((value) =>
                                                leaderboard.getLeaderBoard());
                                      },
                                      child: Container(
                                          height: 33.h,
                                          width: 33.h,
                                          child: SvgPicture.asset(
                                              "assets/icon/vibingUser.svg")),
                                    ),
                                    firstChild: GestureDetector(
                                        onTap: () {
                                          Api()
                                              .vibeWithUser(
                                                  leaderboard.leaderboard
                                                      .value[index].id,
                                                  leaderboard.leaderboard
                                                      .value[index].username)
                                              .then((value) =>
                                                  leaderboard.getLeaderBoard());
                                        },
                                        child: Container(
                                            height: 33.h,
                                            width: 33.h,
                                            child: SvgPicture.asset(
                                                "assets/icon/vibe.svg"))),
                                  ),
                                   Container(
                                     color: Colors.green,
                                    width: 5.w,
                                  ),
                                ],
                              ),
                              height: 74.h,
                              margin: const EdgeInsets.only(
                                bottom: 5,
                                top: 0,
                              ),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      offset: Offset(0, 1.3))
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                   
                  ],
                ),
              ),
      ),
    );
  }
}
