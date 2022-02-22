import 'package:flutter/gestures.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mobile/screens/Home/controllers/notificationsController.dart';
import 'package:mobile/screens/Home/models/notificationsModel.dart';
import 'package:mobile/screens/Home/models/notificationsModel.dart';
import 'package:mobile/screens/Home/one_post_page.dart';
import 'package:mobile/screens/imports.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    Api().setNotificationToRead();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: const [
          Icon(
            Icons.more_vert_rounded,
            color: Colors.black,
          )
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Notifications",
          style: TextStyle(
              color: tualeBlueDark,
              fontFamily: 'Poppins',
              fontSize: 18,
              // fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: Obx(
        () => Get.find<NotificationsController>()
                .notificationModel
                .value
                .isEmpty
            ? Center(
                child: Text("No new notifications"),
              )
            : ListView.builder(
                itemCount: Get.find<NotificationsController>()
                    .notificationModel
                    .value
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  List<NotificationModel> notifications =
                      Get.find<NotificationsController>()
                          .notificationModel
                          .value;
                  return notifications[index].type == 'newTuale'
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return OnePost(
                                id: notifications[index].id,
                              );
                            }));
                          },
                          child: newNotification(
                              username: notifications[index].username,
                              postUrl: notifications[index].likedPost,
                              body: 'gave you a tuale',
                              id: notifications[index].id),
                        )
                      : notifications[index].type == 'newStarred'
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return OnePost(
                                    id: notifications[index].id,
                                  );
                                }));
                              },
                              child: newNotification(
                                  username: notifications[index].username,
                                  postUrl: notifications[index].likedPost,
                                  body: 'starred one of your post',
                                  id: notifications[index].id),
                            )
                          : notifications[index].type == 'newComment'
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return OnePost(
                                        id: notifications[index].id,
                                      );
                                    }));
                                  },
                                  child: newNotification(
                                      username: notifications[index].username,
                                      postUrl: notifications[index].likedPost,
                                      body: 'commented on a post',
                                      id: notifications[index].id),
                                )
                              : notifications[index].type == 'newFan'
                                  ? newFan(
                                      username: notifications[index].username,
                                    )
                                  : Container();

                  return Text(notifications[index].type.toString());
                },
              ),
      ),
    );
  }
}

class newFan extends StatelessWidget {
  String? username;
  newFan({this.username});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 4),
      //  color: Colors.black,
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: '@' + username! + " ",
              style: TextStyle(
                  fontSize: 15.sp,
                  color: tualeBlueDark.withOpacity(0.7),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return userProfile(
                      isUser: false,
                      username: username,
                      tag: "notification",
                    );
                  }));
                },
              children: <TextSpan>[
                TextSpan(
                    text: 'started vibing with you',
                    style: TextStyle(color: Colors.black.withOpacity(0.8))),
              ],
            ),
          ),
          SizedBox(
            width: 114.w,
            height: 36.h,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(45.w, 39.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Vibe Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            height: 1)),
                    Container(
                        padding: EdgeInsets.only(
                          bottom: 4,
                        ),
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset("assets/icon/vibe.svg"))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class newNotification extends StatelessWidget {
  String? username;
  String? postUrl;
  String? body;
  String? id;

  newNotification({this.username, this.postUrl, this.body, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 8),
      //  color: Colors.black,
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: '@' + username! + " ",
              style: TextStyle(
                  fontSize: 15.sp,
                  color: tualeBlueDark.withOpacity(0.7),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return userProfile(
                      isUser: false,
                      username: username,
                      tag: "notification",
                    );
                  }));
                },
              children: <TextSpan>[
                TextSpan(
                    text: body!,
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.8))),
              ],
            ),
          ),
          Spacer(),
          Container(
            height: 40.h,
            width: 40.h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(postUrl!)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(1)),
          )
        ],
      ),
    );
  }
}
