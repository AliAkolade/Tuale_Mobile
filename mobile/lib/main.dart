//import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/screens/Auth/welcome_screen.dart';
import 'package:mobile/screens/imports.dart';
import 'package:mobile/screens/splash_screen.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/mixPanel.dart';
import 'package:new_version/new_version.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

// final RouteObserver<ModalRoute<void>> routeObserver =
// RouteObserver<ModalRoute<void>>();
// final RouteObserver<ModalRoute<void>> routeObserver =
//     RouteObserver<ModalRoute<void>>();

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
    //await Firebase.initializeApp();
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
    //await Firebase.initializeApp();
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
  var localVersion = "0.0.0";
  var storeVersion = "0.0.0";
  var appStoreLink = "";
  bool canUpdate = true;
  String screenPath = "";
  String screenPathId = "";
  bool redirect = false;

  StreamSubscription? _sub;

  Future<void> initUniLinks() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    _sub = linkStream.listen((String? link) {
      if (link != null) {
        var uri = Uri.parse(link);
        log(uri.toString()); //URL
        log(uri.path);
        log(uri.fragment);
        log(uri.query);
        log(uri.pathSegments.toString());
        if (isLoggedIn) {
          if (uri.path.split('/')[1] == "post") {
            setState(() {
              screenPath = "post";
              screenPathId = uri.pathSegments[1];
              redirect = true;
            });
          } else {
            setState(() {
              screenPath = "user";
              screenPathId = uri.path.replaceAll('/', '');
              redirect = true;
            });
          }
        }
      }
    }, onError: (err) {
      log(err);
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initUniLinks());
    MixPanelSingleton.instance.initMixpanel();
    displayDialog();
  }

  Future<void> displayDialog() async {
    await updateFunc();
    bool canCancel =
        ((int.parse(localVersion[0]) == int.parse(storeVersion[0])) &&
            (int.parse(localVersion[2]) >= int.parse(storeVersion[2])));

    if (canUpdate) {
      try {
        return showDialog<void>(
          context: context,
          barrierDismissible: canCancel, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Update'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        "You need to update your app from $localVersion to $storeVersion"),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                    child: const Text("Yes, for sure"),
                    onPressed: () async {
                      if (!await launch(appStoreLink))
                        throw 'Could not launch $appStoreLink';
                    }),
              ],
            );
          },
        );
      } catch (e) {}
    }
  }

  updateFunc() async {
    try {
      try {
        final newVersion = NewVersion();
        final status = await newVersion.getVersionStatus();

        if (status != null) {
          debugPrint("status-local : ${status.localVersion}");
          debugPrint("status-store : ${status.storeVersion}");
          debugPrint("status-link : ${status.appStoreLink}");
          debugPrint("status : ${status.canUpdate.toString()}");
          setState(() {
            localVersion = status.localVersion;
            storeVersion = status.storeVersion;
            appStoreLink = status.appStoreLink;
            canUpdate = status.canUpdate;
          });
        } else {
          debugPrint("Err getVersionStatus");
        }
      } catch (err) {
        debugPrint("Err getVersionStatus");
      }
    } catch (e) {
      log(e.toString());
    }
  }

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
                builder: (context, child) {
                  return MaterialApp(
                      // navigatorObservers: [routeObserver],
                      builder: (context, widget) {
                        //ScreenUtil.setContext(context);
                        return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 1.0),
                            child: widget!);
                      },
                      debugShowCheckedModeBanner: false,
                      title: 'Tuale',
                      theme: ThemeData(primarySwatch: Palette.tualeSwatchLight),
                      home: (widget.isLoggedIn)
                          ? NavBar(
                              index: 0,
                              deepLink: redirect,
                              deepLinkId: screenPathId,
                              deepLinkPath: screenPath)
                          : const Welcome());
                  // : const SignUp());
                });
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
    _sub?.cancel();
  }
}
