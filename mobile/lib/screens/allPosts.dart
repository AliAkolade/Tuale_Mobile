import 'package:flutter/material.dart';
import 'package:mobile/screens/discover_screen_focus.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/tuale_icons.dart';
import 'package:page_transition/page_transition.dart';

class AllPosts extends StatefulWidget {
  AllPosts({Key? key}) : super(key: key);

  @override
  _AllPostsState createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
         margin: EdgeInsets.only(left: 10, right: 10, top: 10, ),
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        
      ), itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap:  () {
              Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.topToBottom, child: discoverScreen(index: index )));
    

          },
          child: Container(
            child: Container(
              height:100,
              width: 100,
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        begin: AlignmentDirectional(0.5, 0.5),
                        end: AlignmentDirectional(0.5, 1.9),
                        colors: [Colors.transparent, Colors.black87],
                      )),
              
            ),
            decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                image: AssetImage("assets/images/Demo_Image.jpg"))),
            margin: EdgeInsets.all(2),
          
            height: 100,
            width: 100,
          ),
        );
      }),
    );
  }
}