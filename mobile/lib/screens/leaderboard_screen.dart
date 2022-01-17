import 'package:flutter/material.dart';
import 'package:mobile/utils/constants.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);
  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
                                itemCount: 4,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:  [
                                 SizedBox(width: 15,),
                                    const  Text("1.", style: TextStyle(

              color: tualeBlueDark,  
               fontFamily: 'Poppins',
                fontSize: 15,
                             
                              height: 1
            ),),
            Spacer(flex: 1,),
           const Icon(Icons.account_circle, size: 30,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
              Text("Enoke Lade"),
              Text("@Streamy Girl")
            ],),
            Spacer(flex: 6,),
           const Text('1151'),
           Spacer(flex: 2,),
           Icon(Icons.account_box_outlined),
           Spacer(flex: 2,)

              
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
