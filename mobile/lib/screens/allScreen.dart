import 'package:flutter/material.dart';
import 'package:mobile/screens/discover_screen_focus.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/tuale_icons.dart';
import 'package:page_transition/page_transition.dart';

class allScreen extends StatelessWidget {
  const allScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text("@marinadiamis", style: TextStyle(
                      color: Colors.white,
                      fontSize: 11
                    ),),
                    Spacer(),
            
                    Icon(TualeIcons.tualeactive,
                    size: 25,
                    color: tualeOrange,
            
                     ),
                    Text("23", style: TextStyle(
                      color: Colors.white,
                      fontSize: 11
                    ),),
                  ],
                ),
              ),
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