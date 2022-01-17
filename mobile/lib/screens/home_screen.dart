import 'package:flutter/material.dart';
import 'package:mobile/screens/vibing_screen.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/tuale_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(

      home: DefaultTabController(length: 
      2, child:  Scaffold(
        appBar: AppBar(
       
          actions:  const [
             Icon(Icons.ac_unit, color: Colors.black) 
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          bottom:  TabBar(
            unselectedLabelColor: tualeBlueDark,
            indicatorColor: tualeOrange,
            indicatorWeight: 1.1,
            labelColor: tualeOrange,
            labelStyle: const TextStyle(
            
                         
               fontFamily: 'Poppins',
                fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1
            ),
            tabs: [
            Tab(child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
              Text("Vibing",),
              Icon(TualeIcons.vibing,
              size: 15,
              )
            ],),),
            Tab(text: "Curated",),
            ],),
        ) ,
        body:  TabBarView(children: [
            Vibing(),
           const Icon(Icons.ac_unit)


        ],)
      ),),
    );
  }
}

