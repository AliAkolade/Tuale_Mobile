import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/screens/Auth/welcome_screen.dart';
import 'package:mobile/utils/constants.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    camera().getcamera();
    
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    systemNavigationBarIconBrightness: Brightness.dark,

    statusBarColor: Colors.white, 
    statusBarIconBrightness: Brightness.dark// status bar color
  ));
  runApp(ChangeNotifierProvider(
        create: (context) => camera(),
    child: const MyApp()));
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
