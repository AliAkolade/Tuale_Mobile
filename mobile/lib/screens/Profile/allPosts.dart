import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
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

class _AllPostsState extends State<AllPosts> {
  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return GetX<UserPostsController>(
      init: UserPostsController(),
      tag: widget.tag,
      builder: (post) {
        return post.isLoading.value ? SliverGrid(

            //physics: NeverScrollableScrollPhysics(),

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            colors: [Colors.transparent, Colors.black87],
                          )),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image:  DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(post.posts[index].postUrl!))),
                    margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                    height: 100.h,
                    width: 100.h,
                  ),
                );
              },
              childCount: post.posts.length,
            )) : Container(
              height: 50,
              width: 50,
              color: Colors.black,
            ); 
      }
    );
  }
}
