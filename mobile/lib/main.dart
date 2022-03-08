import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile/screens/Auth/welcome_screen.dart';
import 'package:mobile/screens/Home/inprogress_screen.dart';

import 'package:mobile/screens/imports.dart';
import 'package:mobile/screens/splash_screen.dart';
import 'package:mobile/utils/constants.dart';
import 'package:provider/provider.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    camera().getcamera();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log('Initialized');
    log("Is Logged In? = " + prefs.getBool('isLoggedIn').toString());
    bool check = prefs.getBool('isLoggedIn') ?? false;
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';
    bool isLaunched = prefs.getBool('isLaunched') ?? false;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    runApp(MyApp(isLoggedIn: prefs.getBool('isLoggedIn') ?? false));
  } catch (err) {
    /// setMockInitialValues initiates shared preference
    /// Adds app-name
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("app-name", "Tuale");
    prefs.getString("app-name");
    print('Mock Initialized');
    print("Is Logged In? = " + prefs.getBool('isLoggedIn').toString());
    bool check = prefs.getBool('isLoggedIn') ?? false;
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    runApp(MyApp(isLoggedIn: prefs.getBool('isLoggedIn') ?? false));
  }
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
                debugShowCheckedModeBanner: false, home: SplashScreen());
          } else {
            return ScreenUtilInit(
                designSize: const Size(428, 926),
                minTextAdapt: true,
                builder: () {
                  return GetMaterialApp(
                      navigatorObservers: [routeObserver],
                      builder: (context, widget) {
                        ScreenUtil.setContext(context);
                        return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 1.0),
                            child: widget!);
                      },
                      debugShowCheckedModeBanner: false,
                      title: 'Tuale',
                      theme: ThemeData(primarySwatch: Palette.tualeSwatchLight),
                      home: (widget.isLoggedIn)
                          ? NavBar(index: 0)
                          : const Welcome());
                });
          }
        });
  }
}

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mobile/screens/Auth/welcome_screen.dart';
//
// import 'package:mobile/screens/imports.dart';
// import 'package:mobile/utils/constants.dart';
// import 'package:provider/provider.dart';
//
// final RouteObserver<ModalRoute<void>> routeObserver =
//     RouteObserver<ModalRoute<void>>();
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   camera().getcamera();
//
//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       systemNavigationBarColor: Colors.white, // navigation bar color
//       systemNavigationBarIconBrightness: Brightness.dark,
//       statusBarColor: Colors.white,
//       statusBarIconBrightness: Brightness.dark // status bar color
//       ));
//   runApp(MultiProvider(providers: [
//     ChangeNotifierProvider(create: (context) => camera()),
//   ], child: const MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         designSize: Size(428, 926),
//         minTextAdapt: true,
//         builder: () {
//           return MaterialApp(
//               navigatorObservers: [ routeObserver ],
//             builder: (context, widget) {
//               //add this line
//               ScreenUtil.setContext(context);
//               return MediaQuery(
//                 //Setting font does not change with system font size
//                 data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//                 child: widget!,
//               );
//             },
//             debugShowCheckedModeBanner: false,
//             title: 'Tuale',
//             theme: ThemeData(primarySwatch: Palette.tualeSwatchLight),
//             home: const Welcome(),
//           );
//         });
//   }
// }
