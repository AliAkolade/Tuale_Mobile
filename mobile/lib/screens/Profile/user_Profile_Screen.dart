import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/screens/Home/inprogress_screen.dart';
import 'package:mobile/screens/Profile/controllers/profileController.dart';
import 'package:mobile/screens/Profile/edit_profile.dart';
import 'package:mobile/screens/Profile/starred_posts_screen.dart';
import 'package:mobile/screens/imports.dart';
import 'package:mobile/screens/widgets/verifiedTag.dart';

class userProfile extends StatefulWidget {
  bool? isUser;
  String? username;
  ProfileController? profileController;

  // String? tag;

  userProfile({
    Key? key,
    this.isUser,
    this.username,
    // this.tag
  }) : super(key: key);

  @override
  State<userProfile> createState() => _ProfileState();
}

bool? isAccountOwner;

ProfileController profileController = ProfileController();
// UserPostDetails userdetails = UserPostDetails();

class _ProfileState extends State<userProfile> with RouteAware {
  final pass = TextEditingController(text: "");
  bool hidePass = true;
  String password = "";
  bool isLoadingDelete = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ProfileController>();
  }

  @override
  void initState() {
    super.initState();
  }

  bool isBlocked(String id) {
    bool isblocked = false;
    for (var i
    in Get
        .find<LoggedUserController>()
        .loggedUser
        .value
        .blockedUsers!) {
      // debugPrint(i['user']);
      // debugPrint(id);
      if (id == i['user']) {
        isblocked = true;

        break;
      } else {
        isblocked = false;

        // break;
      }
    }
    return isblocked;
  }

  deleteAccount() async {
    setState(() {
      isLoadingDelete = true;
    });

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response =
    await dio.post(hostAPI + deleteUser, data: {"password": password});
    // debugPrint(response.data.toString());
    var responseData = response.data;
    if (responseData['success'].toString() == 'true') {
      setState(() {
        isLoadingDelete = false;
      });
      Get.deleteAll();
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      prefs.clear();

      MixPanelSingleton.instance.mixpanel.track('Delete',
          properties: {'User': prefs.getString('username') ?? ''});
      MixPanelSingleton.instance.mixpanel.flush();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Welcome()),
              (Route<dynamic> route) => false);
      var snackBar = SnackBar(
          content: Text(responseData['message'].toString(),
              style: const TextStyle(color: Colors.white)),
          backgroundColor: tualeOrange,
          duration: const Duration(seconds: 10),
          padding: const EdgeInsets.all(20));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        isLoadingDelete = false;
      });
      Navigator.pop(context);
      var snackBar = SnackBar(
          content: Text(responseData['message'].toString(),
              style: const TextStyle(color: Colors.white)),
          backgroundColor: tualeOrange,
          duration: const Duration(seconds: 5),
          padding: const EdgeInsets.all(20));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  final CustomPopupMenuController _controller = CustomPopupMenuController();

  List<ItemModel> checkUserPost(BuildContext context, String postUserId) {
    List<ItemModel> menuItems = [];

    menuItems = [ItemModel('Delete Account', Icons.delete_outline)];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    // profileController.getProfileInfo(widget.username!);
    return Material(
        child: GetX<ProfileController>(
            init: ProfileController(controllerusername: widget.username),
            builder: (text) {
              return text.isLoading.value
                  ? Center(
                  child: SpinKitFadingCircle(
                      color: tualeOrange.withOpacity(0.75)))
                  : DefaultTabController(
                  length: 2,
                  child: //profileController.isLoading.value
                  //     ? Container():
                  Scaffold(
                      appBar: AppBar(
                          leading: widget.isUser!
                              ? Container()
                              : GestureDetector(
                              onTap: () {
                                Navigator.pop(context, 200);
                              },
                              child: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.black)),
                          actions: [
                            widget.isUser!
                                ? Row(children: [
                              // IconButton(
                              //     icon: const Icon(
                              //         Icons.more_horiz,
                              //         color: Colors.black),
                              //     onPressed: () async {
                              //       // Get.deleteAll();
                              //       // Future<SharedPreferences>
                              //       //     _prefs = SharedPreferences
                              //       //         .getInstance();
                              //       // final SharedPreferences
                              //       //     prefs = await _prefs;
                              //       //
                              //       // prefs.setBool(
                              //       //     'isLoggedIn', false);
                              //       //
                              //       // MixPanelSingleton
                              //       //     .instance.mixpanel
                              //       //     .track('Logout',
                              //       //         properties: {
                              //       //       'User': prefs.getString(
                              //       //               'username') ??
                              //       //           ''
                              //       //     });
                              //       // MixPanelSingleton
                              //       //     .instance.mixpanel
                              //       //     .flush();
                              //       // Navigator.of(context)
                              //       //     .pushAndRemoveUntil(
                              //       //         MaterialPageRoute(
                              //       //             builder: (context) =>
                              //       //                 const Welcome()),
                              //       //         (Route<dynamic>
                              //       //                 route) =>
                              //       //             false);
                              //       // pushNewScreen(context,
                              //       //     screen: Welcome(),
                              //       //     withNavBar: false,
                              //       //     pageTransitionAnimation:
                              //       //         PageTransitionAnimation
                              //       //             .cupertino);
                              //       // runApp(MyApp(
                              //       //   isLoggedIn: false,
                              //       // ));
                              //     }),

                              CustomPopupMenu(
                                  arrowColor: const Color.fromRGBO(
                                      250, 250, 250, 1),
                                  menuBuilder: () =>
                                      ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(
                                              5),
                                          child: Container(
                                              color:
                                              const Color.fromRGBO(
                                                  250, 250, 250, 1),
                                              child: IntrinsicWidth(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .stretch,
                                                    children: checkUserPost(
                                                        context, "")
                                                        .map((item) =>
                                                        GestureDetector(
                                                            behavior: HitTestBehavior
                                                                .translucent,
                                                            onTap: () {
                                                              switch (item
                                                                  .title) {
                                                                case "Delete Account":
                                                                  {
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (
                                                                            BuildContext context) {
                                                                          String contentText = "Content of Dialog";
                                                                          return StatefulBuilder(
                                                                              builder: (
                                                                                  context,
                                                                                  setState) {
                                                                                return

                                                                                  Dialog(
                                                                                      elevation: 0,
                                                                                      backgroundColor: Colors
                                                                                          .transparent,
                                                                                      child: Container(
                                                                                          padding: const EdgeInsets
                                                                                              .all(
                                                                                              30),
                                                                                          decoration: const BoxDecoration(
                                                                                              color: Colors
                                                                                                  .white,
                                                                                              borderRadius: BorderRadius
                                                                                                  .all(
                                                                                                  Radius
                                                                                                      .circular(
                                                                                                      20))),
                                                                                          child: Column(
                                                                                              mainAxisAlignment: MainAxisAlignment
                                                                                                  .center,
                                                                                              mainAxisSize: MainAxisSize
                                                                                                  .min,
                                                                                              children: [
                                                                                                // SvgPicture.asset(
                                                                                                //     'assets/vectors/actionSuccess.svg'),
                                                                                                // const SizedBox(height: 25),
                                                                                                const Text(
                                                                                                    'Delete your Tuale Account?',
                                                                                                    textAlign: TextAlign
                                                                                                        .center,
                                                                                                    style: TextStyle(
                                                                                                        color: Color
                                                                                                            .fromRGBO(
                                                                                                            76,
                                                                                                            76,
                                                                                                            76,
                                                                                                            1),
                                                                                                        fontFamily: 'Poppins',
                                                                                                        fontSize: 16,
                                                                                                        fontWeight: FontWeight
                                                                                                            .w100,
                                                                                                        height: 1)),
                                                                                                const SizedBox(
                                                                                                    height: 25),
                                                                                                Container(
                                                                                                    decoration: const BoxDecoration(
                                                                                                        boxShadow: [
                                                                                                          BoxShadow(
                                                                                                              color: Color
                                                                                                                  .fromRGBO(
                                                                                                                  4,
                                                                                                                  42,
                                                                                                                  43,
                                                                                                                  0.1),
                                                                                                              blurRadius: 3)
                                                                                                        ]),
                                                                                                    child: Material(
                                                                                                        elevation: 0,
                                                                                                        color: Colors
                                                                                                            .white,
                                                                                                        child: TextField(
                                                                                                            controller: pass,
                                                                                                            obscureText: hidePass,
                                                                                                            decoration: InputDecoration(
                                                                                                                border: InputBorder
                                                                                                                    .none,
                                                                                                                contentPadding: const EdgeInsets
                                                                                                                    .all(
                                                                                                                    5),
                                                                                                                prefixIcon: SvgPicture
                                                                                                                    .asset(
                                                                                                                  'assets/vectors/padlock.svg',
                                                                                                                  fit: BoxFit
                                                                                                                      .scaleDown,
                                                                                                                ),
                                                                                                                suffixIcon: IconButton(
                                                                                                                  color: const Color
                                                                                                                      .fromRGBO(
                                                                                                                      3,
                                                                                                                      42,
                                                                                                                      43,
                                                                                                                      0.5199999809265137),
                                                                                                                  icon: hidePass
                                                                                                                      ? const Icon(
                                                                                                                      Icons
                                                                                                                          .visibility_outlined)
                                                                                                                      : const Icon(
                                                                                                                      Icons
                                                                                                                          .visibility_off_outlined),
                                                                                                                  onPressed: () {
                                                                                                                    setState(() {
                                                                                                                      hidePass =
                                                                                                                      !hidePass;
                                                                                                                    });
                                                                                                                  },
                                                                                                                ),
                                                                                                                labelText: 'Password',
                                                                                                                labelStyle: const TextStyle(
                                                                                                                    color: Color
                                                                                                                        .fromRGBO(
                                                                                                                        3,
                                                                                                                        42,
                                                                                                                        43,
                                                                                                                        0.5199999809265137),
                                                                                                                    fontFamily: 'Lato',
                                                                                                                    fontSize: 15,
                                                                                                                    fontWeight: FontWeight
                                                                                                                        .normal,
                                                                                                                    height: 1))))),

                                                                                                const SizedBox(
                                                                                                    height: 25),
                                                                                                isLoadingDelete
                                                                                                    ? Center(
                                                                                                  child: SpinKitFadingCircle(
                                                                                                    color: tualeOrange
                                                                                                        .withOpacity(
                                                                                                        0.75),
                                                                                                  ),
                                                                                                )
                                                                                                    :
                                                                                                ElevatedButton(
                                                                                                    onPressed: () {
                                                                                                      setState(() {
                                                                                                        password =
                                                                                                            pass
                                                                                                                .text;
                                                                                                      });
                                                                                                      deleteAccount();
                                                                                                      setState(() {
                                                                                                        pass
                                                                                                            .text =
                                                                                                        "";
                                                                                                      });
                                                                                                    },
                                                                                                    style: ElevatedButton
                                                                                                        .styleFrom(
                                                                                                        elevation: 0,
                                                                                                        primary: tualeBlueDark,
                                                                                                        minimumSize:
                                                                                                        const Size(
                                                                                                            double
                                                                                                                .infinity,
                                                                                                            50),
                                                                                                        shape: RoundedRectangleBorder(
                                                                                                            borderRadius:
                                                                                                            BorderRadius
                                                                                                                .circular(
                                                                                                                10))),
                                                                                                    child: const Text(
                                                                                                        'Confirm Delete',
                                                                                                        textAlign: TextAlign
                                                                                                            .center,
                                                                                                        style: TextStyle(
                                                                                                            color: Colors
                                                                                                                .white,
                                                                                                            fontFamily: 'Poppins',
                                                                                                            fontSize: 15.5,
                                                                                                            fontWeight: FontWeight
                                                                                                                .bold,
                                                                                                            height: 1)))
                                                                                              ])));
                                                                              });
                                                                        }
                                                                    );
                                                                  }
                                                                  break;
                                                              }
                                                              setState(
                                                                      () {
                                                                    _controller
                                                                        .hideMenu();
                                                                  });
                                                            },
                                                            child: Container(
                                                              // height:
                                                              //     40,
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal: 10),
                                                                child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Icon(
                                                                          item
                                                                              .icon,
                                                                          size:
                                                                          10,
                                                                          color: Color
                                                                              .fromRGBO(
                                                                              76,
                                                                              76,
                                                                              76,
                                                                              1)),
                                                                      Expanded(
                                                                          child: Container(
                                                                            // margin: const EdgeInsets.only(left: 10),
                                                                              padding: const EdgeInsets
                                                                                  .all(
                                                                                  10),
                                                                              child: Text(
                                                                                  item
                                                                                      .title,
                                                                                  style: const TextStyle(
                                                                                      color: Color
                                                                                          .fromRGBO(
                                                                                          76,
                                                                                          76,
                                                                                          76,
                                                                                          1),
                                                                                      fontSize: 15))))
                                                                    ]))))
                                                        .toList(),
                                                  )))),
                                  pressType:
                                  PressType.singleClick,
                                  verticalMargin: -10,
                                  controller: _controller,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(color: Colors.transparent,
                                                blurRadius: 0)
                                          ]),
                                      margin:
                                      const EdgeInsets.only(
                                          top: 0,
                                          bottom: 5,
                                          right: 5),
                                      child: Icon(
                                          TualeIcons.elipsis,
                                          color: Colors.black,
                                          size: 25.sp))),
                              IconButton(
                                  icon: const Icon(Icons.logout,
                                      color: Colors.black),
                                  onPressed: () async {
                                    Get.deleteAll();
                                    Future<SharedPreferences>
                                    _prefs = SharedPreferences
                                        .getInstance();
                                    final SharedPreferences
                                    prefs = await _prefs;

                                    prefs.setBool(
                                        'isLoggedIn', false);

                                    MixPanelSingleton
                                        .instance.mixpanel
                                        .track('Logout',
                                        properties: {
                                          'User': prefs.getString(
                                              'username') ??
                                              ''
                                        });
                                    MixPanelSingleton
                                        .instance.mixpanel
                                        .flush();
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const Welcome()),
                                            (Route<dynamic>
                                        route) =>
                                        false);
                                    // pushNewScreen(context,
                                    //     screen: Welcome(),
                                    //     withNavBar: false,
                                    //     pageTransitionAnimation:
                                    //         PageTransitionAnimation
                                    //             .cupertino);
                                    // runApp(MyApp(
                                    //   isLoggedIn: false,
                                    // ));
                                  })
                            ])
                                : Stack(children: [
                              IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                            side: BorderSide(),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius
                                                    .circular(15),
                                                topRight:
                                                Radius.circular(
                                                    15))),
                                        useRootNavigator: true,
                                        isScrollControlled: true,
                                        enableDrag: true,
                                        context: context,
                                        builder: (context) =>
                                            ReportWidget(
                                                parentcontext:
                                                context,
                                                username: widget
                                                    .username!,
                                                id: text
                                                    .profileInfo
                                                    .value
                                                    .id
                                                    .toString(),
                                                name: text
                                                    .profileInfo
                                                    .value
                                                    .name
                                                    .toString()));
                                  },
                                  icon: const Icon(
                                      Icons.more_vert,
                                      color: Colors.black)),
                              isBlocked(
                                  text.profileInfo.value.id!)
                                  ? Positioned(
                                  left: 27,
                                  top: 10,
                                  child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              8))))
                                  : Container()
                            ])
                          ],
                          centerTitle: true,
                          elevation: 0,
                          backgroundColor: Colors.white,
                          title: GetX<ProfileController>(
                              init: ProfileController(
                                  controllerusername: widget.username),
                              // tag: widget.tag,
                              builder: (context) {
                                return Text(
                                    context.profileInfo.value.name!,
                                    style: const TextStyle(
                                      color: tualeBlueDark,
                                      fontFamily: 'Poppins',
                                      fontSize: 18, // fontWeig
                                    ));
                              })),
                      body: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              isBlocked(text.profileInfo.value.id!)
                                  ? Colors.grey
                                  : Colors.transparent,
                              BlendMode.saturation),
                          child: AbsorbPointer(
                              absorbing:
                              isBlocked(text.profileInfo.value.id!),
                              child: NestedScrollView(
                                  physics:
                                  const ClampingScrollPhysics(),
                                  headerSliverBuilder:
                                      (context, isScrolled) {
                                    return [
                                      SliverPersistentHeader(
                                        delegate: _SliverAppBarDelegate(
                                            ProfileInfotwo(
                                              username: widget.username,
                                              // tag: widget.tag!
                                            )),
                                        pinned: false,
                                        //  floating: true
                                      ),
                                      SliverOverlapAbsorber(
                                          handle: NestedScrollView
                                              .sliverOverlapAbsorberHandleFor(
                                              context),
                                          sliver: SliverAppBar(
                                            //floating: true,
                                              pinned: true,
                                              // collapsedHeight: 100,
                                              expandedHeight: 10,
                                              flexibleSpace: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    const TabBar(
                                                        unselectedLabelColor:
                                                        Colors.grey,
                                                        indicatorColor:
                                                        Colors
                                                            .transparent,
                                                        indicatorWeight:
                                                        1.1,
                                                        labelColor:
                                                        tualeBlueDark,
                                                        labelStyle:
                                                        TextStyle(
                                                            fontFamily:
                                                            'Poppins',
                                                            fontSize:
                                                            16,
                                                            // fontWeight: FontWeight.bold,
                                                            height:
                                                            1),
                                                        tabs: [
                                                          Tab(
                                                              icon: Icon(
                                                                  TualeIcons
                                                                      .allposts,
                                                                  size:
                                                                  30)),
                                                          Tab(
                                                              icon:
                                                              Icon(
                                                                TualeIcons
                                                                    .starredpost,
                                                                size: 35,
                                                                // color: Colors.grey.withOpacity(0.3)
                                                              ))
                                                        ]),
                                                    SizedBox(
                                                        height: 1,
                                                        // TODO : don't have 10.h
                                                        width: ScreenUtil()
                                                            .screenWidth,
                                                        child: const Divider(
                                                            color: Colors
                                                                .grey))
                                                  ]),
                                              backgroundColor:
                                              Colors.white))
                                    ];
                                  },
                                  body: TabBarView(children: [
                                    Builder(builder: (context) {
                                      return CustomScrollView(slivers: [
                                        SliverOverlapInjector(
                                            handle: NestedScrollView
                                                .sliverOverlapAbsorberHandleFor(
                                                context)),
                                        AllPosts(
                                            username: widget.username)
                                      ]);
                                    }),
                                    Builder(builder: (context) {
                                      return CustomScrollView(slivers: [
                                        SliverOverlapInjector(
                                            handle: NestedScrollView
                                                .sliverOverlapAbsorberHandleFor(
                                                context)),
                                        starredPosts(
                                            username: widget.username)
                                      ]);
                                    })
                                  ]))))));
            }));
  }
}

class ReportWidget extends StatefulWidget {
  BuildContext parentcontext;
  String username;
  String id;
  String name;

  ReportWidget({Key? key,
    required this.parentcontext,
    required this.username,
    required this.id,
    required this.name})
      : super(key: key);

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  bool isBlocked(String id) {
    bool isblocked = false;
    for (var i
    in Get
        .find<LoggedUserController>()
        .loggedUser
        .value
        .blockedUsers!) {
      // debugPrint(i['user']);
      // debugPrint(id);
      if (id == i['user']) {
        isblocked = true;

        break;
      } else {
        isblocked = false;

        // break;
      }
    }
    return isblocked;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom),
        child: Container(
            height: 100,
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
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
                            builder: (context) =>
                                SizedBox(
                                    height: 500,
                                    child: ReportList(
                                        parentContext: context,
                                        id: widget.id)));
                      },
                      child: const Text("Report",
                          style: TextStyle(fontSize: 23, color: Colors.red))),
                  const SizedBox(height: 15),
                  Get
                      .find<LoggedUserController>()
                      .loggedUser
                      .value
                      .currentuserid ==
                      widget.id
                      ? Container()
                      : GestureDetector(
                      onTap: () {
                        showDialog(
                            context: widget.parentcontext,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                //  title: Text('Welcome'),
                                  content: Text(isBlocked(widget.id)
                                      ? 'Are you sure you want to unblock this account'
                                      : 'Are you sure you want to block this user'),
                                  actions: [
                                    TextButton(
                                      
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('NO', style: TextStyle(color: Colors.black))),
                                    TextButton(
                                       
                                        onPressed: () async {
                                          Loader.show(context,
                                              isSafeAreaOverlay: false,
                                              isAppbarOverlay: true,
                                              isBottomBarOverlay: false,
                                              progressIndicator:
                                              SpinKitFadingCircle(
                                                  color: tualeOrange
                                                      .withOpacity(
                                                      0.75)),
                                              themeData: Theme.of(context)
                                                  .copyWith(
                                                  accentColor:
                                                  Colors.black38),
                                              overlayColor:
                                              const Color(0x99E8EAF6));
                                          var result = isBlocked(widget.id)
                                              ? await Api()
                                              .unblockUser(widget.id)
                                              : await Api()
                                              .blockUser(widget.id);
                                          if (result) {
                                            Get.find<LoggedUserController>()
                                                .getLoggeduser();
                                            Get.find<ProfileController>()
                                                .getProfileInfo(
                                                widget.name);
                                            // debugPrint(result.toString());
                                            Loader.hide();
                                            Navigator.pop(context);
                                          } else {}
                                        },
                                        child: const Text('YES',style: TextStyle(color: Colors.black)))
                                  ]);
                            });
                      },
                      child: Text(
                          isBlocked(widget.id) ? "Unblock" : "Block",
                          style: const TextStyle(
                              fontSize: 23, color: Colors.black)))
                ])));
  }
}

class ReportList extends StatefulWidget {
  final BuildContext parentContext;
  final String? username;
  final String? id;

  const ReportList(
      {Key? key, required this.parentContext, this.username, this.id})
      : super(key: key);

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  int val = -1;
  final Api _api = Api();
  String reason = "";

  reportProfile(String id) async {
    if (val == 1) {
      reason = "He/She is posting content that shouldn't be on Tuale";
    } else if (val == 2) {
      reason = "He/She is pretending to be someone else";
    } else if (val == 3) {
      reason = "He/She is posting bad comments";
    } else if (val == 4) {
      reason = "Other reasons";
    }
    bool response = await _api.reportUser(reason, id);
    if (response) {
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(widget.parentContext).showSnackBar(
          const SnackBar(content: Text('Your request has been submitted')));
    } else {
      ScaffoldMessenger.of(widget.parentContext)
          .showSnackBar(const SnackBar(content: Text('Something go wrong')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        child: Column(children: [
          const SizedBox(height: 5),
          const Text("Report",
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Divider(),
          const Text("Why are you reporting this account",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text(
              "Your report is anonymous, execept if you're reporting "
                  "an intellectual property infrigement. If someone is in immediate"
                  "danger, call the local emergency services - don't wait",
              style: TextStyle(fontSize: 15, color: Colors.grey)),
          const SizedBox(height: 20),
          ListTile(
              title: const Text(
                  "He/She is posting content that shouldn't be on Tuale"),
              leading: Radio(
                  value: 1,
                  groupValue: val,
                  onChanged: (int? value) {
                    setState(() {
                      val = value ?? -1;
                    });
                    reportProfile(widget.id!);
                  },
                  activeColor: Colors.orange)),
          const SizedBox(height: 5),
          ListTile(
              title: const Text("He/She is pretending to be someone else"),
              leading: Radio(
                  value: 2,
                  groupValue: val,
                  onChanged: (int? value) {
                    setState(() {
                      val = value ?? -1;
                    });
                    reportProfile(widget.id!);
                  },
                  activeColor: Colors.orange)),
          const SizedBox(height: 5),
          ListTile(
              title: const Text("He/She is posting bad comments"),
              leading: Radio(
                  value: 3,
                  groupValue: val,
                  onChanged: (int? value) {
                    setState(() {
                      val = value ?? -1;
                    });
                    reportProfile(widget.id!);
                  },
                  activeColor: Colors.orange)),
          const SizedBox(height: 5),
          ListTile(
              title: const Text("Other reasons"),
              leading: Radio(
                  value: 4,
                  groupValue: val,
                  onChanged: (int? value) {
                    setState(() {
                      val = value ?? -1;
                    });
                    reportProfile(widget.id!);
                  },
                  activeColor: Colors.orange))
        ]),
        padding: const EdgeInsets.only(left: 20, right: 20));
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
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
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

  // String? tag;

  ProfileInfotwo({
    this.isUser,
    this.username,
    //this.tag
  });

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
                      child: GetX<ProfileController>(
                          init: ProfileController(controllerusername: username),
                          builder: (text) {
                            return CircleAvatar(
                                backgroundImage: NetworkImage(
                                    text.profileInfo.value.avatar!));
                          }))),
              const Spacer(flex: 2),
              GetX<ProfileController>(
                  init: ProfileController(controllerusername: username),
                  // tag: tag,
                  builder: (text) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            //Get.find<ProfileController>().profileInfo.value.friends!,
                              "@" + text.profileInfo.value.username!,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.bold
                              )),
                          text.profileInfo.value.isVerified!
                              ? const verifiedTag()
                              : Container()
                        ]);
                  }),
              const Spacer(flex: 2),
              GetX<ProfileController>(
                  init: ProfileController(controllerusername: username),
                  builder: (text) {
                    return Text(text.profileInfo.value.location!,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            height: 1));
                  }),
              const Spacer(flex: 4),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [
                      GetX<ProfileController>(
                          init: ProfileController(controllerusername: username),
                          // tag: tag,
                          builder: (text) {
                            return Text(
                              //Get.find<ProfileController>().profileInfo.value.friends!,
                                text.profileInfo.value.fans.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 1));
                          }),
                      const Text("Fans",
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              height: 1))
                    ]),

                    // const Spacer(),

                    Container(
                      // height: 50,
                        width: 100,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          //  color: Colors.black,
                            border: Border(
                                left: BorderSide(
                                    color: Colors.grey.withOpacity(0.3)),
                                right: BorderSide(
                                    color: Colors.grey.withOpacity(0.3)))),
                        child: Column(children: [
                          GetX<ProfileController>(
                              init: ProfileController(
                                  controllerusername: username),
                              // tag: tag,
                              builder: (text) {
                                return Text(
                                  //Get.find<ProfileController>().profileInfo.value.friends!,
                                    text.profileInfo.value.friends.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        height: 1));
                              }),
                          const Text("Friends",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  height: 1))
                        ])),
                    // Spacer(),

                    // Spacer(),
                    Column(mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetX<ProfileController>(
                              init: ProfileController(
                                  controllerusername: username),
                              //tag: tag,
                              builder: (text) {
                                return Text(
                                  //Get.find<ProfileController>().profileInfo.value.friends!,
                                    text.profileInfo.value.tualegiven
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        height: 1));
                              }),

                          const Text("Tuales given",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  height: 1)),
                          //  Spacer(flex: 3)
                        ])
                  ]),
              const Spacer(flex: 3),
              GetX<ProfileController>(
                  init: ProfileController(controllerusername: username),
                  builder: (text) {
                    return Text(text.profileInfo.value.bio.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            height: 1));
                  }),
              const Spacer(flex: 4),
              Obx(() =>
              Get
                  .find<LoggedUserController>()
                  .loggedUser
                  .value
                  .currentuserid ==
                  Get
                      .put(
                    ProfileController(controllerusername: username),
                    //tag: tag
                  )
                      .profileInfo
                      .value
                      .id
                  ? Row(children: [
                const Spacer(flex: 3),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const EditProfile()));
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
                const Spacer(flex: 3),
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
                      const Text('Tuallet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Poppins',
                              fontSize: 15.5,
                              fontWeight: FontWeight.bold,
                              height: 1)),
                      SizedBox(width: 5.h),
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                              'assets/vectors/tualletWallet.svg'))
                    ])),
                const Spacer(flex: 3)
              ])
                  : profileButton(
                  username: username,
                  // tag: tag,
                  userId: Get
                      .put(
                    ProfileController(controllerusername: username),
                    //tag: tag
                  )
                      .profileInfo
                      .value
                      .id)),
              const Spacer(flex: 3)
            ]));
  }
}

class profileButton extends StatelessWidget {
  String? username;
  String? tag;
  String? userId;

  profileButton({this.username, this.tag, this.userId});

  @override
  Widget build(BuildContext context) {
    bool isFollowing() {
      bool followed = false;
      for (var i
      in Get
          .find<LoggedUserController>()
          .loggedUser
          .value
          .friends!) {
        // debugPrint(i['user']);
        if (Get
            .put(ProfileController(controllerusername: username))
            .profileInfo
            .value
            .id! ==
            i["user"]) {
          followed = true;
          break;
        } else {
          followed = false;
        }
      }

      return followed;
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Spacer(flex: 2),
      ElevatedButton(
          onPressed: () {
            isFollowing()
                ? Api().unvibeWithUser(userId!, username!)
                : Api().vibeWithUser(userId!, username!);
          },
          style: ElevatedButton.styleFrom(
              primary: isFollowing() ? tualeOrange : tualeBlueDark,
              minimumSize: const Size(150, 45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(isFollowing() ? 'Vibing' : 'vibe',
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                    child: const InProgressScreen()));
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
      const Spacer(flex: 2)
    ]);
  }
}

class SaveBioBtntwo extends StatelessWidget {
  const SaveBioBtntwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(130, 45),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Text('Save',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                height: 1)));
  }
}

class ChangePassBtntwo extends StatelessWidget {
  const ChangePassBtntwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    insetPadding: const EdgeInsets.only(left: 30, right: 30),
                    child: SizedBox(
                      // width: 200,
                        height: 400,
                        child: Column(children: [
                          TopBartwo(barText: "Change Password"),
                          BioFieldtwo(
                              infoString: "Current Password", fieldHeight: 50),
                          BioFieldtwo(
                              infoString: "New Password", fieldHeight: 50),
                          BioFieldtwo(
                              infoString: "Confirm Password", fieldHeight: 50),
                          const SizedBox(height: 20),
                          const SaveBioBtntwo()
                        ])));
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
        padding: const EdgeInsets.only(top: 10, bottom: 15),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(width: 20),
          const Icon(Icons.arrow_back_rounded),
          const Spacer(flex: 2),
          Text(barText!,
              style: const TextStyle(
                  color: tualeBlueDark,
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  height: 1)),
          const Spacer(flex: 3)
        ]));
  }
}

class ProfilePictwo extends StatelessWidget {
  const ProfilePictwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 160,
        width: 160,
        child: Stack(children: [
          const SizedBox(
              height: 160,
              width: 160,
              child: CircleAvatar(
                  backgroundImage:
                  AssetImage("assets/images/demo_profile.png"))),
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
                  child: const Icon(Icons.camera_alt_rounded,
                      color: Colors.white)))
        ]));
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
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  style: BorderStyle.solid, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)))))
            ]));
  }
}
