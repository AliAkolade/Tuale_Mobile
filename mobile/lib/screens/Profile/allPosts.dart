import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:mobile/screens/Profile/controllers/userPostsController.dart';
import 'package:mobile/screens/imports.dart';

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
    Get.delete<UserPostsController>(tag: widget.tag);
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

    return  GetX<UserPostsController>(
      init: UserPostsController(username: widget.username),
      tag: widget.tag,
      builder: (text) {
        return text.isLoading.value
            ? SliverToBoxAdapter(
                child: Center(
                    child:
                        SpinKitFadingCircle(color: tualeOrange.withOpacity(0.75))))
            : post.posts.length == 0
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
                            print(text.posts.length);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.topToBottom,
                                        child: discoverScreen(index: index)));
                              },
                              child: Container(
                                child: Container(
                                  height: 100.h,
                                  width: 100.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: const LinearGradient(
                                        begin: AlignmentDirectional(0.5, 0.5),
                                        end: AlignmentDirectional(0.5, 1.9),
                                        colors: [
                                          Colors.transparent,
                                          Colors.black87
                                        ],
                                      )),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            text.posts[index].postUrl!))),
                                margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                height: 100.h,
                                width: 100.h,
                              ),
                            );
                          },
                          childCount: text.posts.length,
                        )),
                  );
      }
    );
  }
}
