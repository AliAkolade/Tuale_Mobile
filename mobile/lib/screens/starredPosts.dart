import 'package:flutter/material.dart';
import 'package:mobile/screens/discover_screen_focus.dart';
import 'package:page_transition/page_transition.dart';

class starredPosts extends StatefulWidget {
  const starredPosts({ Key? key }) : super(key: key);

  @override
  _starredPostsState createState() => _starredPostsState();
}

class _starredPostsState extends State<starredPosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        begin: AlignmentDirectional(0.5, 0.5),
                        end: AlignmentDirectional(0.5, 1.9),
                        colors: [Colors.transparent, Colors.black87],
                      )),
              
            ),
            decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                image: AssetImage("assets/images/Demo_Image.jpg"))),
            margin: EdgeInsets.all(12),
          
            height: 100,
            width: 100,
          ),
        );
      }),
    );
  }
}