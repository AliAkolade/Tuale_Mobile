import 'package:flutter/material.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/tuale_icons.dart';

import 'vibing_screen.dart';


class VibingZoom extends StatefulWidget {

  int? index;
VibingZoom({this.index});
  @override
  _VibingZoomState createState() => _VibingZoomState();
}

class _VibingZoomState extends State<VibingZoom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
         
          child: Stack(
                  children: [
        Align(
         // heightFactor: 1.0,
         // widthFactor: 12.0,
          alignment: Alignment(1.2, -1.05),
          child: SizedBox(
            height: 100,
            width: 130,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.fullscreen_exit_rounded,
              color: Colors.black,
              size: 30,
              ),
            ),
          ),
        )   ,         
                                    //Add this CustomPaint widget to the Widget Tre                                //Add this CustomPaint widget to the Widget Tree
        Align(
        heightFactor: 1.9,
        alignment: Alignment(1.06, 1.0),
        child:   Container(
         
        height: 350,
        width: 100,
        // color: Colors.white,
        child: CustomPaint(
            size: Size(100, (100*3.536842105263158).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: RPSCustomPainter(),
            child: Center(
              child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            
            // crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Container(
                     // decoration: const BoxDecoration(boxShadow:  [BoxShadow(color: Colors.grey, blurRadius: 50)]),
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Column(children:  [
                   AnimatedCrossFade(
                   duration: const Duration(milliseconds: 20 ),
                      crossFadeState: tualed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                     secondChild: GestureDetector(
                       onTap: () {
                         setState(() {
                           tualed = false;
                           tualCount = 0; 
                         });
                       },
                       child: const Icon(TualeIcons.tualeactive,
                       color: Colors.yellow,
                       size: 40,
                       ),
                     ) ,
                     firstChild:  GestureDetector(
                       onTap: (){
                         setState(() {
                           tualed = true;
                           tualCount = 1;
                         });
                       },
                       child: const Icon(TualeIcons.tuale,
                       color: Colors.white,
                       size: 40,
                       ),
                     ) ,),
                    Text("$tualCount" ,style: TextStyle(color: Colors.white, fontSize: 14,))
                  ],),
                ),
              
                 Container(
                       decoration: const BoxDecoration(boxShadow:  [BoxShadow(color: Colors.grey, blurRadius: 40)]),
                      margin: const EdgeInsets.only(top: 8, bottom: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                       AnimatedCrossFade(
                    duration: const Duration(milliseconds: 20 ),
                      crossFadeState: starred ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                     secondChild: GestureDetector(
                       onTap: () {
                      
                         setState(() {
                          starred = false;
                          starCount = 0;
                         });
                       },
                       child:  const Icon(TualeIcons.star,
                    color: tualeOrange,
                    size: 33,
                    ),
                     ) ,
                     firstChild:  GestureDetector(
                       onTap: (){
                         setState(() {
                           starred = true;
                           starCount = 1;
                         });
                       },
                       child: const Icon(TualeIcons.star,
                    color: Colors.white,
                    size: 33,
                    ),
                     ) ,),
                   
                    Text("$starCount", style: const  TextStyle(color: Colors.white, fontSize: 14,))
                  ],),
                ),
                 Container(
                   decoration: const BoxDecoration(boxShadow:  [BoxShadow(color: Colors.grey, blurRadius: 25)]),
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(children:const [
                  
                     Icon(TualeIcons.comment,
                    color: Colors.white,
                    size: 27,
                    ),
                    const  Text("0", style:  TextStyle(color: Colors.white, fontSize: 14,))
                  ],),
                ),
                 Container(
                       decoration: const BoxDecoration(boxShadow:  [BoxShadow(color: Colors.grey, blurRadius: 25)]),
                      margin: const EdgeInsets.only(top: 0, bottom: 12, right: 13 ),
                  child:  
                   GestureDetector(
                     onTap: (){
                       more(context);
                     },
                     child: const  Icon(TualeIcons.elipsis,
                      color: Colors.white,
                      size: 23,
                      ),
                   ),
                )
              ]
              ),
            ),
        ),
        ),
        ),
        
        //user post info 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                        margin:const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            Container(
                              height: 50,
                              width: 50,
                              child:const CircleAvatar(
                                backgroundImage: AssetImage("assets/images/demo_profile.png"),
                              ),
                            ),
                          const  Spacer(
                              flex: 1,
                            ),
                           const Text("@Singe", style:
                    TextStyle(
        
                  color: Colors.white,  
                   fontFamily: 'Poppins',
                    fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  height: 1
                ),
                            
                            ),
                             const Spacer(
                              flex: 1,
                            ),
                            const  Text("1 day ago", style:
                    TextStyle(
        
                  color: Colors.white70,  
                   fontFamily: 'Poppins',
                    fontSize: 10,
                                 
                                  height: 1
                ),
                            
                            ),
                           const  Spacer(
                              flex: 15,
                            ),
                          ],
                          ),
                          Container(
                           // color: Colors.white70,
                          height: 50,
                          width: 950,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const  [
                             Text("There is always a light bulb in your head.\n #ideas run the world.",
                             overflow: TextOverflow.ellipsis,
                             style:    TextStyle(
        
                  color: Colors.white70,  
                  // fontFamily: 'Poppins',
                    fontSize: 15,
                    height: 1, 
                                 
                ),
                             ),
                             Spacer(),
                               Icon(
                        
                            Icons.volume_down_rounded,
                               size: 35,
                               color: Colors.white,
                            
                            )
                          ],)
                          ),
                        
                        ],)
                        )
                      ],
                    )
                  ],
                ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            
            color: Colors.amber,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/demoPost.png"))),
        ),
      ),
    );
  }
}