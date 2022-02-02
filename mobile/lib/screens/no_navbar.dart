import 'package:flutter/material.dart';
import 'package:mobile/screens/gallery_app.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NoNave extends StatefulWidget {
 NoNave({ Key? key }) : super(key: key);

  @override
  State<NoNave> createState() => _NoNaveState();
}

class _NoNaveState extends State<NoNave> {
  bool nav = true;

  @override
@override
void initState() {
  super.initState();
   WidgetsBinding.instance!
        .addPostFrameCallback((_)  {

        pushNewScreen(
        context,
        screen: gallery(),
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
          
        } ) ;
  
    
}

  Widget build(BuildContext context) {
  
    return CircularProgressIndicator();
  }
}