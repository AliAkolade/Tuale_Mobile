import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mobile/screens/Profile/controllers/profileController.dart';
import 'package:mobile/screens/Profile/controllers/userPostsController.dart';
import 'package:mobile/screens/Profile/edit_profile.dart';

import 'package:mobile/screens/imports.dart';

class userProfile extends StatefulWidget {
  bool? isUser;
  String? username;
  ProfileController? profileController;
  String? tag;

  userProfile({
    this.isUser,
    this.username,
    this.tag,
  });
  State<userProfile> createState() => _ProfileState();
}

bool? isAccountOwner;

ProfileController profileController = ProfileController();
// UserPostDetails userdetails = UserPostDetails();

class _ProfileState extends State<userProfile> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();

    Get.delete<ProfileController>(tag: widget.tag);
  }

  @override
  void initState() {
    super.initState();

    profileController = Get.put<ProfileController>(
        ProfileController(controllerusername: widget.username!),
        tag: widget.tag!);

      Get.put(UserPostsController().getProfilePosts(widget.username!), tag: widget.tag);     
  }

  @override
  Widget build(BuildContext context) {
    // profileController.getProfileInfo(widget.username!);
    return Material(
      child: DefaultTabController(
          length: 2,
          child: //profileController.isLoading.value
              //     ? Container():
              Scaffold(
            appBar: AppBar(
                leading: widget.isUser!
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.black,
                        ),
                      ),
                actions: [
                  Icon(
                    Icons.more_vert_rounded,
                    color: Colors.black,
                  )
                ],
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                title: GetX<ProfileController>(
                    init:
                        ProfileController(controllerusername: widget.username),
                    tag: widget.tag,
                    builder: (context) {
                      return Text(
                        context.profileInfo.value.name!,
                        style: TextStyle(
                          color: tualeBlueDark,
                          fontFamily: 'Poppins',
                          fontSize: 18, // fontWeig
                        ),
                      );
                    })),
            body: NestedScrollView(
                physics: ClampingScrollPhysics(),
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(ProfileInfotwo(
                      username: widget.username,
                      tag: widget.tag!,

                      )),
                      pinned: false,
                      //  floating: true,
                    ),
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        //floating: true,
                        pinned: true,
                        // collapsedHeight: 100,
                        expandedHeight: 10,
                        flexibleSpace: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TabBar(
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: Colors.transparent,
                                indicatorWeight: 1.1,
                                labelColor: tualeBlueDark,
                                labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                    height: 1),
                                tabs: [
                                  Tab(
                                    icon: Icon(
                                      TualeIcons.allposts,
                                      size: 30,
                                    ),
                                  ),
                                  Tab(
                                      icon: Icon(
                                    TualeIcons.starredpost,
                                    size: 35,
                                    // color: Colors.grey.withOpacity(0.3),
                                  )),
                                ]),
                            // GetBuilder<ProfileController>(
                            //   init: ProfileController(),
                            //  // dispose: ProfileController().delete(),
                            //   builder: (context) {

                            //     return Divider(
                            //       color: context.color,
                            //     );
                            //   }
                            // )
                          ],
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    Builder(builder: (context) {
                      return CustomScrollView(
                        slivers: [
                          SliverOverlapInjector(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context)),
                          AllPosts()
                        ],
                      );
                    }),
                    Builder(builder: (context) {
                      return CustomScrollView(
                        slivers: [
                          SliverOverlapInjector(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context)),
                          AllPosts(
                            username: widget.username,
                            tag: widget.tag
                          ),
                        ],
                      );
                    }),
                  ],
                )),
          )),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final Widget _tabBar;

  @override
  double get minExtent => 350;
  @override
  double get maxExtent => 350;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class ProfileInfotwo extends StatelessWidget {
  bool? isUser;
  String? username;
  String? tag;

  ProfileInfotwo({this.isUser, this.username, this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 350,
        width: double.infinity,
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 90,
                width: 90,
                child: Obx(
                  () => CircleAvatar(
                    backgroundImage: NetworkImage(
                        profileController.profileInfo.value.avatar!),
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Obx(
              () => Text(
                "@" + profileController.profileInfo.value.username!,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    // fontWeight: FontWeight.bold,
                    height: 1),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            const Text(
              "Nairobi, Kenya",
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  height: 1),
            ),
            const Spacer(
              flex: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Obx(
                      () => Text(
                        profileController.profileInfo.value.fans!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ),
                    Text(
                      "Fans",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          height: 1),
                    ),
                  ],
                ),

                // const Spacer(),

                Container(
                  // height: 50,
                  width: 100,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                      //  color: Colors.black,
                      border: Border(
                          left: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          right:
                              BorderSide(color: Colors.grey.withOpacity(0.3)))),
                  child: Column(
                    children: [
                      Obx(
                        () => Text(
                          //Get.find<ProfileController>().profileInfo.value.friends!,
                          profileController.profileInfo.value.friends!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1),
                        ),
                      ),
                      Text(
                        "Friends",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            height: 1),
                      ),
                    ],
                  ),
                ),
                // Spacer(),

                // Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        //Get.find<ProfileController>().profileInfo.value.tualegiven!,
                        profileController.profileInfo.value.tualegiven!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ),

                    Text(
                      "Tuales given",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          height: 1),
                    ),
                    //  Spacer(flex: 3,)
                  ],
                ),
              ],
            ),
            const Spacer(
              flex: 3,
            ),
            const Text(
              "Dark Skinned and I love it",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  height: 1),
            ),
            const Spacer(
              flex: 4,
            ),
            Obx(() =>
               Api.currentUserId ==
                      Get.put(ProfileController(controllerusername: username),
                              tag: tag)
                          .profileInfo
                          .value
                          .id
                  ?   Row(
                      children: [
                        Spacer(
                          flex: 3,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: EditProfile()));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: tualeBlueDark,
                                minimumSize: const Size(150, 45),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text('Edit Profile',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Poppins',
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.bold,
                                    height: 1))),
                        Spacer(
                          flex: 3,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: TualletHome()));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: tualeOrange,
                                minimumSize: const Size(150, 45),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Row(children: [
                              Text('Tuallet',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'Poppins',
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.bold,
                                      height: 1)),
                              SizedBox(
                                width: 5.h,
                              ),
                              SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: SvgPicture.asset(
                                      'assets/vectors/tualletWallet.svg'))
                            ])),
                        Spacer(
                          flex: 3,
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: SignUp()));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: tualeBlueDark,
                                minimumSize: const Size(150, 45),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text('Vibe',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Poppins',
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w200,
                                    height: 1))),
                        const Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: TualletHome()));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(218, 65, 103, 1),
                                minimumSize: const Size(150, 45),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text('Chat',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Poppins',
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w200,
                                    height: 1))),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ));
  }
}

class SaveBioBtntwo extends StatelessWidget {
  const SaveBioBtntwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(130, 45),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: const Text('Save',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1)),
    );
  }
}

class ChangePassBtntwo extends StatelessWidget {
  const ChangePassBtntwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  insetPadding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    // width: 200,
                    height: 400,
                    child: Column(children: [
                      TopBartwo(
                        barText: "Change Password",
                      ),
                      BioFieldtwo(
                        infoString: "Current Password",
                        fieldHeight: 50,
                      ),
                      BioFieldtwo(
                        infoString: "New Password",
                        fieldHeight: 50,
                      ),
                      BioFieldtwo(
                        infoString: "Confirm Password",
                        fieldHeight: 50,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SaveBioBtntwo()
                    ]),
                  ),
                );
              });
        },
        child: const Text("Change Password",
            style: TextStyle(
                color: tualeBlueDark,
                fontFamily: 'Poppins',
                fontSize: 15.5,
                fontWeight: FontWeight.bold,
                height: 1)));
  }
}

class TopBartwo extends StatelessWidget {
  String? barText;
  TopBartwo({this.barText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 15,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          width: 20,
        ),
        const Icon(Icons.arrow_back_rounded),
        const Spacer(
          flex: 2,
        ),
        Text(
          barText!,
          style: const TextStyle(
              color: tualeBlueDark,
              fontFamily: 'Poppins',
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              height: 1),
        ),
        const Spacer(
          flex: 3,
        ),
      ]),
    );
  }
}

class ProfilePictwo extends StatelessWidget {
  const ProfilePictwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 160,
      child: Stack(
        children: [
          const SizedBox(
            height: 160,
            width: 160,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/demo_profile.png"),
            ),
          ),
          Align(
            widthFactor: 4.0,
            heightFactor: 7,
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                  color: tualeBlueDark,
                  borderRadius: BorderRadius.circular(30)),
              height: 38,
              width: 38,
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

//
class BioFieldtwo extends StatelessWidget {
  String? infoString;
  double? fieldHeight;

  BioFieldtwo({this.infoString, this.fieldHeight});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 22, right: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(infoString!),
          SizedBox(
            height: fieldHeight!,
            width: 350,
            child: TextField(
              maxLines: 7,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 2),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      style: BorderStyle.solid, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      style: BorderStyle.solid, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
