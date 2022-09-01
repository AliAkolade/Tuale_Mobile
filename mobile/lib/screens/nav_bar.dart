import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/screens/Discover/searchPage.dart';
import 'package:mobile/screens/Home/controllers/notificationsController.dart';
import 'package:mobile/screens/imports.dart';

import 'Home/models/postsetails.dart';
import 'Home/one_post_page.dart';
import 'imports.dart';

//context for current scene
BuildContext? selectedTabContext;

class NavBar extends StatefulWidget {
  int index;
  int initIndex;
  String deepLinkPath;
  String deepLinkId;
  bool deepLink;

  NavBar({
    Key? key,
    required this.index,
    required this.deepLink,
    required this.deepLinkPath,
    required this.deepLinkId,
    this.initIndex = 1,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late PersistentTabController _controller;

  // TODO : new design

  List<Widget> _buildScreens() {
    return [
      Home(
        initialIndex: widget.initIndex,
      ),
      const SearchScreen(),
      PostTimeline(
        fileContent: File(""),
        filePath: "",
        mediaType: "image",
      ),
      const Leaderboard(),
      Obx(
        () => userProfile(
          isUser: true,
          username: Get.find<LoggedUserController>()
              .loggedUser
              .value
              .currentUserUsername,
          // tag: "myprofile",
        ),
      )
    ];
  }

  int _currentIndex = 0;
  double iconSize = 25.0;

  late List<Widget> _children = [];

  deepLinkNav() async {
    if (widget.deepLink) {
      if (widget.deepLinkPath == "post") {
        PostDetails postDetails = await Api().getOnePost(widget.deepLinkId);
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.topToBottom,
                child: OnePost(
                    id: widget.deepLinkId,
                    mediaType: postDetails.mediaType,
                    postMedia: postDetails.postMedia)));
      } else if (widget.deepLinkPath == "user") {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.topToBottom,
            child: userProfile(username: widget.deepLinkId, isUser: false)));
      }
    }
  }

  @override
  void initState() {
    Get.put(NotificationsController());
    Get.put(LoggedUserController());
    // Api().getNotifications;

    setState(() {
      _controller = PersistentTabController(initialIndex: widget.index);
    });

    _children = [
      Home(
        initialIndex: widget.initIndex,
      ),
      const SearchScreen(),
      PostTimeline(
        fileContent: File(""),
        filePath: "",
        mediaType: "image",
      ),
      const Leaderboard(),
      Obx(
        () => userProfile(
          isUser: true,
          username: Get.put(LoggedUserController())
              .loggedUser
              .value
              .currentUserUsername,
          // tag: "myprofile",
        ),
      )
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) => deepLinkNav());
  }

  onTabTapped(int index) {
    // try to show animation when user want to publish
    if (index == 2) {
      cameraSelect(context);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        //height: 85.h,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: const Radius.circular(30),
              topLeft: const Radius.circular(30)),
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          elevation: 10,
          //backgroundColor: Colors.red,
          fixedColor: tualeOrange,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                color: tualeBlueDark,
                size: iconSize,
              ),
              label: 'Home',
              //backgroundColor: Colors.red,
              activeIcon: Icon(
                Icons.home_rounded,
                color: tualeOrange,
                size: iconSize,
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.solidCompass,
                  color: tualeBlueDark,
                  size: iconSize,
                ),
                label: 'Discover',
                //backgroundColor: Colors.red,
                activeIcon: Icon(
                  FontAwesomeIcons.solidCompass,
                  color: tualeOrange,
                  size: iconSize,
                )),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.add_circle,
                  color: tualeBlueDark,
                  size: 40,
                ),
                label: '',
                activeIcon: Icon(
                  Icons.add_circle,
                  color: tualeOrange,
                  size: iconSize,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.leaderboard_rounded,
                  color: tualeBlueDark,
                  size: iconSize,
                ),
                label: 'Leaderboard',
                activeIcon: Icon(
                  Icons.leaderboard_rounded,
                  color: tualeOrange,
                  size: iconSize,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: tualeBlueDark,
                  size: iconSize,
                ),
                label: 'Profile',
                activeIcon: Icon(
                  Icons.person,
                  color: tualeOrange,
                  size: iconSize,
                )),
          ],
        ),
      ),
    );
  }
}

Future pickMedia(ImageSource source, String type) async {
  final XFile? asset;
  File file;
  String filePath;
  if (type == "image") {
    MixPanelSingleton.instance.mixpanel.timeEvent("PostImage");
    asset = await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (asset != null) {
      file = File(asset.path);
      filePath = asset.path;
      debugPrint("imgUrl  : $file");
      return [file, filePath];
    }
  } else {
    MixPanelSingleton.instance.mixpanel.timeEvent("PostVideo");
    asset = await ImagePicker().pickVideo(source: source);
    if (asset != null) {
      file = File(asset.path);
      filePath = asset.path;
      debugPrint("videoUrl  : $file");
      return [file, filePath];
    }
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
                  const Text("Create"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        var response =
                            await pickMedia(ImageSource.gallery, "image");
                        if (response != null) {
                          File fileContent = response[0];
                          String filePath = response[1];
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return PostTimeline(
                                  fileContent: fileContent,
                                  filePath: filePath,
                                  mediaType: "image",
                                );
                              },
                            ),
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          debugPrint("User cancel uploading");
                        }
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
                      onTap: () async {
                        var response =
                            await pickMedia(ImageSource.gallery, "video");
                        if (response != null) {
                          File fileContent = response[0];
                          String filePath = response[1];
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return PostTimeline(
                                  fileContent: fileContent,
                                  filePath: filePath,
                                  mediaType: "video",
                                );
                              },
                            ),
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          debugPrint("User cancel uploading");
                        }
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
                  /*Padding(
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
                  ),*/
                ],
              ),
            ),
          ));
}
