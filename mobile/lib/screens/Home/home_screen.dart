import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/screens/Home/controllers/getCuratedPost.dart';
import 'package:mobile/screens/Home/controllers/getVibedPost.dart';
import 'package:mobile/screens/Home/notifications.dart';
import 'package:mobile/screens/imports.dart';
import 'package:mobile/screens/imports.dart';
import 'package:mobile/utils/Api.dart';

class Home extends StatefulWidget {
  final int initialIndex;
  const Home({Key? key, this.initialIndex=1}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    debugPrint("HomePage");
    super.initState();
   
     
  }
  @override
  Widget build(BuildContext context) {
    print(currentUsername);
    return WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
          return true as Future<bool>;
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: DefaultTabController(
                initialIndex: widget.initialIndex,
                length: 2,
                child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: PreferredSize(
                        preferredSize:
                            const Size(double.infinity, kToolbarHeight + 10),
                        child: SafeArea(
                            child: Column(children: [
                          Spacer(
                            flex: 5,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                        child: const Icon(Icons.refresh_rounded,
                                            color: tualeBlueDark),
                                        onTap: () {
                                          // Curated().loadPosts(context);
                                          //Vibing.loadPosts(context);
                                        }),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: TabBar(
                                            unselectedLabelColor: tualeBlueDark,
                                            indicatorColor: tualeOrange,
                                            indicatorWeight: 1.1,
                                            labelColor: tualeOrange,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                height: 1),
                                            tabs: [
                                          Tab(
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                Text("Vibing"),
                                                Icon(TualeIcons.vibing,
                                                    size: 15)
                                              ])),
                                          const Tab(text: "Curated")
                                        ])),
                                    const SizedBox(width: 10),
                                    Obx(
                                      () => InkWell(
                                          child: Stack(
                                            children: [
                                              const Icon(
                                                  TualeIcons.notificationbell,
                                                  color: tualeBlueDark),
                                              Get.put(LoggedUserController())
                                                      .loggedUser
                                                      .value
                                                      .unreadNotifications!
                                                  ? Container(
                                                      height: 12.h,
                                                      width: 12.h,
                                                      decoration: BoxDecoration(
                                                          color: tualeOrange,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.r)),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          onTap: () {
                                            print(
                                                Get.find<LoggedUserController>()
                                                    .loggedUser
                                                    .value
                                                    .unreadNotifications);
                                            //= false;
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return Notifications();
                                            }));
                                          }),
                                    )
                                  ])),
                          Container(
                              height: 0.5,
                              width: double.infinity,
                              color: Colors.grey.shade400),
                        ]))),
                    body: TabBarView(children: [Vibing(), Curated()])))));
  }
}
