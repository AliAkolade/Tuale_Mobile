import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/screens/Home/one_post_page.dart';
import 'package:mobile/screens/Profile/controllers/profileController.dart';
import 'package:mobile/screens/imports.dart';

class starredPosts extends StatefulWidget {
  String? username;
  String? tag;

  starredPosts({this.username, this.tag});

  @override
  _starredPostsState createState() => _starredPostsState();
}

ProfileController post = ProfileController();

class _starredPostsState extends State<starredPosts> {
  @override
  void dispose() {
    super.dispose();
    // Get.delete<UserPostsController>(tag: widget.tag);
  }

  @override
  void initState() {
    super.initState();

    post = Get.put(ProfileController(controllerusername: widget.username),
        tag: widget.tag);
  }

  @override
  Widget build(BuildContext context) {
    //  post = Get.put(UserPostsController(username: widget.username),
    //       tag: widget.tag);

    return GetX<ProfileController>(
        init: ProfileController(controllerusername: widget.username),
        tag: widget.tag,
        builder: (text) {
          return text.isLoading.value
              ? SliverToBoxAdapter(
                  child: Center(
                      child: SpinKitFadingCircle(
                          color: tualeOrange.withOpacity(0.75))))
              : text.profileInfo.value.starredPosts!.isEmpty
                  ? SliverToBoxAdapter(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120.h,
                        ),
                        Text("No post"),
                      ],
                    ))
                  : Get.find<LoggedUserController>()
                              .loggedUser
                              .value
                              .currentuserid ==
                          text.profileInfo.value.id
                      ? SliverPadding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          sliver: SliverGrid(

                              //physics: NeverScrollableScrollPhysics(),

                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                // mainAxisExtent: 5,
                                crossAxisCount: 3,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .topToBottom,
                                              child: OnePost(
                                                  postMedia: text
                                                      .profileInfo
                                                      .value
                                                      .starredPosts![index]
                                                      .url,
                                                  mediaType: text
                                                      .profileInfo
                                                      .value
                                                      .starredPosts![index]
                                                      .mediaType,
                                                  id: text
                                                      .profileInfo
                                                      .value
                                                      .starredPosts![index]
                                                      .id)));
                                    },
                                    child: text
                                                  .profileInfo
                                                  .value
                                                  .starredPosts![index]
                                                  .mediaType !=
                                              'image'
                                          ? Container(
                                            color: Colors.black,
                                              height: 100.h,
                                              width: 100.h,
                                              child: Center(
                                                child: Icon(
                                                    Icons.play_arrow_outlined,
                                                    color: Colors.white,
                                                    ),
                                              ),
                                            )
                                          : Container(
                                      child:  Container(
                                              height: 100.h,
                                              width: 100.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  gradient:
                                                      const LinearGradient(
                                                    begin: AlignmentDirectional(
                                                        0.5, 0.5),
                                                    end: AlignmentDirectional(
                                                        0.5, 1.9),
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black87
                                                    ],
                                                  )),
                                            ),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(text
                                                  .profileInfo
                                                  .value
                                                  .starredPosts![index]
                                                  .url!))),
                                      margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                      height: 100.h,
                                      width: 100.h,
                                    ),
                                  );
                                },
                                childCount:
                                    text.profileInfo.value.starredPosts!.length,
                              )),
                        )
                      : SliverToBoxAdapter(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 120.h,
                            ),
                            Text("You aren't authorized to view this page"),
                          ],
                        ));
        });
  }
}
