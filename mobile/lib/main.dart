import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/screens/welcome_screen.dart';
import 'package:mobile/utils/constants.dart';

void main() {
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.black, 
    statusBarIconBrightness: Brightness.light// status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Tuale',
      theme: ThemeData(primarySwatch: Palette.tualeSwatchLight),
      home: const Welcome(),
    );
  }
}
