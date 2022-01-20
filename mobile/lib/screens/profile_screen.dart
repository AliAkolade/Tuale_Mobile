import 'package:flutter/material.dart';
import 'package:mobile/screens/allPosts.dart';
import 'package:mobile/screens/signup_screen.dart';
import 'package:mobile/screens/starredPosts.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/tuale_icons.dart';
import 'package:page_transition/page_transition.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize:  Size(double.infinity, 250),
              child: Column(children:  [
               const  SizedBox(
                   height: 90,
                   width: 90,
                   child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/demo_profile.png'),
                               ),
                 ),
                const Text("@siphie_zo",
                 style: TextStyle(
            color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                   // fontWeight: FontWeight.bold,
                                                    height: 1),
                 ),
               const  Text("Nairobi, Kenya",
                 style:  TextStyle(
            color: Colors.grey,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 10,
                                                    height: 1),
                 
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    const Spacer(
                      flex: 3,
                    ),
                     Column(children: const [
                       
                         Text("2389",
                 style: TextStyle(
            color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18,
                                                   fontWeight: FontWeight.bold,
                                                    height: 1),
                 ),
                Text("Fans",
                 style:  TextStyle(
            color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    height: 1),
                 
                 ),
                 
                     ],),
                         Spacer(),
                    SizedBox(
                       height: 60,
                      // width: 9,
                       child: VerticalDivider(
                         width: 10,
                                       thickness: 1,
                                       color: Colors.grey.withOpacity(0.8),
                         
                       ),
                     ),
                         Spacer(),
                        Column(children: const [
                         Text("67",
                 style: TextStyle(
            color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18,
                                                   fontWeight: FontWeight.bold,
                                                    height: 1),
                 ),
                Text("Friends",
                 style:  TextStyle(
            color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    height: 1),
                 
                 ),
                 
                     ],),
                         Spacer(),
                      SizedBox(
                       height: 60,
                      // width: 9,
                       child: VerticalDivider(
                         width: 10,
                                       thickness: 1,
                                       color: Colors.grey.withOpacity(0.5),
                         
                       ),
                     ),
                     Spacer(),
                       Column(children: const [
                         Text("35",
                 style: TextStyle(
            color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18,
                                                   fontWeight: FontWeight.bold,
                                                    height: 1),
                 ),
                Text("Tuales Given",
                 style:  TextStyle(
            color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    height: 1),
                 
                 ),
                 
                     ],),
                        const Spacer(
                           flex: 3,
                         ),
    
                   ],
                 ),
    
                const Text("Dark Skinned and I love it"),
                ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: SignUp()));
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(120, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text('Edit Profile',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Poppins',
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.bold,
                                    height: 1))),
                                     const TabBar(
                                                unselectedLabelColor: Colors.grey,
                                                indicatorColor: tualeBlueDark,
                                                indicatorWeight: 1.1,
                                                labelColor: tualeBlueDark,
                                                labelStyle:  TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                   // fontWeight: FontWeight.bold,
                                                    height: 1),
                                                tabs: [
                                              Tab(
                                                icon: Icon(Icons.view_list_outlined),
                                                 ),
                                               Tab(icon: Icon(TualeIcons.star)),
                            
                                            ]),
    
              ],),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: const [
            Icon(Icons.more_vert_rounded,
            size: 25,
            color: Colors.black,
            )
          ],
          leading: const Icon(Icons.arrow_back_rounded,
          size: 25,
          color: Colors.black,
          ),
          title: const Text("Siphiwe Zola",
          style:  TextStyle(
            color: tualeBlueDark,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18,
                                                   // fontWeight: FontWeight.bold,
                                                    height: 1),
          ),
        ),
        body: TabBarView(children: [
          AllPosts(),
          starredPosts()
        ],),
      ),
    );
  }
}
