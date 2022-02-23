import 'dart:math';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/screens/Home/controllers/notificationsController.dart';
import 'package:mobile/models/currentUserdetails.dart';
import 'package:mobile/screens/Discover/searchPage.dart';
import 'package:mobile/screens/Profile/controllers/profileController.dart';
import 'package:mobile/screens/imports.dart';
import 'package:image_picker/image_picker.dart';
import 'imports.dart';

//context for current scene
BuildContext? selectedTabContext;

class NavBar extends StatefulWidget {
  final int index;

  const NavBar({
    Key? key,
    required this.index,
  }) : super(key: key);
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [
      Home(),
      SearchScreen(),
      PostTimeline(),
      Leaderboard(),
      Obx(
        () => userProfile(
          isUser: true,
          username: Get.put(LoggedUserController())
              .loggedUser
              .value
              .currentUserUsername,
          tag: "myprofile",
        ),
      )
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_rounded),
        title: ("Home"),
        activeColorPrimary: tualeOrange,
        inactiveColorPrimary: tualeBlueDark,
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.solidCompass),
          title: ("Discover"),
          activeColorPrimary: tualeOrange,
          inactiveColorPrimary: tualeBlueDark),
      PersistentBottomNavBarItem(
        iconSize: 40,
        //  contentPadding: 2,
        icon: Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Icon(
            Icons.add_circle,
          ),
        ),

        title: ("."),
        activeColorPrimary: tualeOrange,
        inactiveColorPrimary: tualeBlueDark,
        onPressed: (context) async {
          await cameraSelect(selectedTabContext);
        },
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.leaderboard_rounded),
        title: ("Leaderboard"),
        activeColorPrimary: tualeOrange,
        inactiveColorPrimary: tualeBlueDark,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: tualeOrange,
        inactiveColorPrimary: tualeBlueDark,
        // onPressed: (context) {
        //   Get.put(
        //           ProfileController(
        //               controllerusername: Get.put(LoggedUserController())
        //                   .loggedUser
        //                   .value
        //                   .currentUserUsername),
        //           tag: 'myprofile')
        //       .getProfileInfo(Get.put(LoggedUserController())
        //           .loggedUser
        //           .value
        //           .currentUserUsername!);

        // }
      ),
    ];
  }

  @override
  void initState() {
    Get.put(NotificationsController());
    // Api().getNotifications;

    setState(() {
      _controller = PersistentTabController(initialIndex: widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<camera>(builder: (context, cam, child) {
      return PersistentTabView(
        context,
        selectedTabScreenContext: (context) {
          selectedTabContext = context;
        },
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        hideNavigationBar: cam
            .hideNav, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.simple,
      );
    });
  }
}

Future pickMedia(ImageSource source, String type) async {
  if (type == "Image") {
    final image = await ImagePicker().pickImage(source: source);
  } else {
    final image = await ImagePicker().pickVideo(source: source);
  }
}

Future cameraSelect(text) async {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          side: BorderSide(),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      useRootNavigator: true,
      isScrollControlled: true,
      enableDrag: true,
      context: text!,
      builder: (context) => Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(text).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(text).size.height * 0.28,
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        pickMedia(ImageSource.gallery, "Image");
                      },
                      child: Row(
                        children: const [
                          CircleAvatar(
                            child: Icon(
                              Icons.image,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Image from gallery"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        pickMedia(ImageSource.gallery, "Video");
                      },
                      child: Row(
                        children: const [
                          CircleAvatar(
                            child: Icon(
                              Icons.video_library,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Video from gallery"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          child: Icon(
                            Icons.camera,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Image/Video from camera"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
}
