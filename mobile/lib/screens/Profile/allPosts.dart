import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:mobile/screens/Home/one_post_page.dart';
import 'package:mobile/screens/Profile/controllers/userPostsController.dart';
import 'package:mobile/screens/imports.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AllPosts extends StatefulWidget {
  String? username;
  String? tag;

  AllPosts({this.username, this.tag});

  @override
  _AllPostsState createState() => _AllPostsState();
}

UserPostsController post = UserPostsController();

class _AllPostsState extends State<AllPosts> {
  @override
  void dispose() {
    super.dispose();
    Get.delete<UserPostsController>();
  }

  @override
  void initState() {
    super.initState();

    // post = Get.put(UserPostsController(username: widget.username),
    //     tag: widget.tag);
  }

  @override
  Widget build(BuildContext context) {
    //  post = Get.put(UserPostsController(username: widget.username),
    //       tag: widget.tag);

    return GetX<UserPostsController>(
        init: UserPostsController(username: widget.username),
        // tag: widget.tag,
        builder: (text) {
          return text.isLoading.value
              ? SliverToBoxAdapter(
                  child: Center(
                      child: SpinKitFadingCircle(
                          color: tualeOrange.withOpacity(0.75))))
              : text.posts.length == 0
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
                  : SliverPadding(
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
                              if (text.posts[index].mediaType != 'image') {}
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.topToBottom,
                                          child: OnePost(
                                            postMedia: text
                                                .posts.value[index].postMedia,
                                            mediaType: text
                                                .posts.value[index].mediaType,
                                            id: text.posts.value[index].id,
                                            pageType: false,
                                          )));
                                },
                                child: text.posts[index].mediaType != 'image'
                                    ? VideoThumbnailWidget(
                                      controller: text.posts[index].postMedia,
                                    )
                                    : Container(
                                        child: Container(
                                          height: 100.h,
                                          width: 100.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              gradient: const LinearGradient(
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(text
                                                    .posts[index].postMedia))),
                                        margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                        height: 100.h,
                                        width: 100.h,
                                      ),
                              );
                            },
                            childCount: text.posts.length,
                          )),
                    );
        });
  }
}

class VideoThumbnailWidget extends StatelessWidget {
  String? controller;

  VideoThumbnailWidget({this.controller});

  String? fileName;

  Future<String> getThumbnail() async {
    fileName = await VideoThumbnail.thumbnailFile(
      video: controller!,
      // thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight:
          64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    print(fileName);
    return fileName!;
  }

  @override
  Widget build(BuildContext context) {
    getThumbnail();
    return Container(
        margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
        height: 100.h,
        width: 100.h,
        color: Colors.black,
        child: Icon(Icons.play_arrow_outlined, color: Colors.white));
  }
}
