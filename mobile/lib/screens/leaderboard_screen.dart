import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/tuale_icons.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);
  @override
  State<Leaderboard> createState() => _LeaderboardState();
}
bool vibe = false;
class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: RichText(text: const TextSpan(
          text: "Tua",
          style:   TextStyle(

              color: tualeOrange,  
               fontFamily: 'Poppins',
                fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1
            ),
          children: [
            TextSpan(text: "Leaderboard", style:   TextStyle(

              color: tualeBlueDark,  
               fontFamily: 'Poppins',
                fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1
            ),)
          ]
        ) ),
      ),
      body: Column(
        children:  [
         const  Divider(
                              color: Color.fromRGBO(135, 153, 153, 1),
                              thickness: 0.4000000059604645),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: const [
                                Spacer(flex: 2,),
                                Text("User", style: TextStyle(
      
              color: tualeBlueDark,  
               fontFamily: 'Poppins',
                fontSize: 18,
                             
                              height: 1
            ),),
            Spacer(flex: 3,),
                                Text("Tuales Given", 
                                style: TextStyle(
      
              color: tualeBlueDark,  
               fontFamily: 'Poppins',
                fontSize: 18,
                             
                              height: 1
            ),
                                ),
                                Spacer()
                              ],),
                              Expanded(child: 
                              ListView.builder(
                                itemCount: 8,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:  [
                                 SizedBox(width: 15,),
                                    const  Text("1.", style: TextStyle(
      
              color: tualeBlueDark,  
               fontFamily: 'Poppins',
                fontSize: 17,
                             
                              height: 1
            ),),
           const Spacer(flex: 1,),
           const Icon(TualeIcons.usericon, color: Colors.grey, size: 40,),
           SizedBox(width: 5,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
             const  Text("Enoke Lade", 
              style: TextStyle(
      
              color: tualeBlueDark,  
               fontFamily: 'Poppins',
                fontSize: 15,
                             
                             
            ),
              ),
              Text("@Streamygirl_",
              style: TextStyle(
      
              color: tualeBlueDark.withOpacity(0.5),  
               fontFamily: 'Poppins',
                fontSize: 12,
                height: 1,
                             
                          
            ),
              )
            ],),
          const  Spacer(flex: 6,),
           const Text('1151',
           style: TextStyle(
      
              color: tualeBlueDark,  
               fontFamily: 'Poppins',
                fontSize: 18,
                             
                             
            ),
           ),
           const Spacer(flex: 2,),
             AnimatedCrossFade(
                 duration: const Duration(milliseconds:100),
                  crossFadeState: vibe ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                 secondChild: GestureDetector(
                   onTap: () {
                    
                     setState(() {
                     vibe = false;
                    
                     });
                   },
                   child:   Container(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset("assets/icon/vibingUser.svg")),
                 ) ,
                 firstChild:  GestureDetector(
                   onTap: (){
                     setState(() {
                       vibe = true;
                     
                     });
                   },
                   child:  Container(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset("assets/icon/vibe.svg"))
                 ) ,),
               
             
          const  Spacer(flex: 2,)
      
              
                                    ],),
                                    height: 80,
                                    margin: const EdgeInsets.only(bottom:15, top:15,),                       
                                    width: MediaQuery.of(context).size.width,
                                    decoration:const BoxDecoration(
                                         color: Colors.white,
                                       borderRadius: BorderRadius.only(
                                         bottomLeft: Radius.circular(30),
                                         bottomRight: Radius.circular(30)
                                       ),
                                       boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, 1.3))],
                                    
                                    ),
                                  );
                                },
                              ),
                              
                              )
      
      
      
        ],
      
      
      
      ),
    );
  }
}
