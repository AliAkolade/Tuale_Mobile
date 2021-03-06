import 'dart:developer' as devtools show log;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/screens/imports.dart';

const Color tualeBlueDark = Color.fromRGBO(8, 61, 119, 1);
const Color tualeOrange = Color.fromRGBO(247, 135, 100, 1);
const Color tualeTextBlack = Color.fromRGBO(76, 76, 76, 1);

class Palette {
  static const MaterialColor tualeSwatchLight = MaterialColor(
    0xff083d77,
    <int, Color>{
      50: Color(0xff215085), //10%
      100: Color(0xff396492), //20%
      200: Color(0xff5277a0), //30%
      300: Color(0xff6b8bad), //40%
      400: Color(0xff849ebb), //50%
      500: Color(0xff9cb1c9), //60%
      600: Color(0xffb5c5d6), //70%
      700: Color(0xffced8e4), //80%
      800: Color(0xffe6ecf1), //90%
      900: Color(0xffffffff), //100%
    },
  );
  static const MaterialColor tualeSwatchDark = MaterialColor(
    0xff083d77,
    <int, Color>{
      50: Color(0xff07376b), //10%
      100: Color(0xff06315f), //20%
      200: Color(0xff062b53), //30%
      300: Color(0xff052547), //40%
      400: Color(0xff041f3c), //50%
      500: Color(0xff031830), //60%
      600: Color(0xff021224), //70%
      700: Color(0xff020c18), //80%
      800: Color(0xff01060c), //90%
      900: Color(0xff000000), //100%
    },
  );
}

const String verifyUsernameAPI = 'verify/';
const String registerUserAPI = 'register';
const String forgotPasswordAPI = 'password/forgot';
const String resetPasswordAPI = 'password/reset/';
const String verifyResetTokenAPI = 'verify/password/token';
const String loginUserAPI = 'login';
const String getVibingPosts = 'posts/vibing?pageNumber=';
const String getAllPosts = 'posts?pageNumber=';
const String userpost = 'profile/';
const String profilepost = 'profile/posts/';
const String currentuser = 'me';
const String payment = 'payment/';
const String verify = 'payment/verify';
const String search = 'search/';
const String checkOTP = 'verify/otp';
const String getOTP = 'email/send';
const String notifications = 'notifications';
const String vibing = 'vibe/';
const String unvibing = 'unvibe/';
const String addTuale = 'post/tuale/';
const String deleteUser = 'me/delete';
String currentUsername = '';
int curatedPageNo = 1;
int vibingPageNo = 1;

var format =
    NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
var nairaSign = format.currencySymbol;

class camera extends ChangeNotifier {
  static List<CameraDescription>? cameras;
  bool hideNav = false;

  Future<void> getcamera() async {
    final camera = await availableCameras();
    cameras = camera;

    print(cameras);
  }

  changeNav() {
    hideNav = !hideNav;

    notifyListeners();
  }
}

void log(
  String screenId, {
  dynamic msg,
  dynamic error,
  StackTrace? stackTrace,
}) =>
    devtools.log(
      msg.toString(),
      error: error,
      name: screenId,
      stackTrace: stackTrace,
    );

void showSnackBar(String text,
    {Duration duration = const Duration(seconds: 2)}) {
  Globals.scaffoldMessengerKey.currentState
    ?..clearSnackBars()
    ..showSnackBar(
      SnackBar(content: Text(text), duration: duration),
    );
}

bool isNullOrBlank(String? data) => data?.trim().isEmpty ?? true;

class Globals {
  const Globals._();

  //static final auth = FirebaseAuth.instance;

  //static User? get firebaseUser => auth.currentUser;

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
}
