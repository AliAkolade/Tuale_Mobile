import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mobile/screens/welcome_screen.dart';
import 'package:mobile/utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';

import 'login_screen.dart';

int viewNo = 0;
String finalEmail = '';
String finalName = '';
String finalDOB = '';
String finalPassword = '';
String finalUsername = '';
String finalPhone = '';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int columnNo = viewNo;
  List toView = <Widget>[
    const ChooseSignUp(),
    const FillDetails(),
    const ChooseUsername(),
    const InputPhone(),
    const VerifyCode(),
    // const VerifyEmail,
  ];

  reconcile() {
    setState(() {
      columnNo = viewNo;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      reconcile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: Stack(children: [
                  Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Spacer(),
                                Image.asset('assets/images/welcome.png'),
                                const Spacer(),
                                const Text('HELLO THERE',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        height: 1)),
                                const SizedBox(height: 10),
                                const Text(
                                    'Welcome to Tuale,\n the fairest creator app in the world.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(3, 43, 24, 1),
                                        fontFamily: 'Lato',
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        height: 1)),
                                const Spacer(),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: const SignUp()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize:
                                            const Size(double.infinity, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: const Text('Get Started',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontFamily: 'Poppins',
                                            fontSize: 15.5,
                                            fontWeight: FontWeight.bold,
                                            height: 1))),
                                const SizedBox(height: 20),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.bottomToTop,
                                          child: const Login(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                        'I already have an account',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                247, 135, 100, 1),
                                            fontFamily: 'Poppins',
                                            fontSize: 15.5,
                                            fontWeight: FontWeight.w600,
                                            height: 1))),
                                const SizedBox(height: 30)
                              ]))),
                  Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.3)),
                  Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Spacer(),
                            Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(250, 250, 250, 1),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0))),
                                height: 600,
                                child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: toView[columnNo]))
                          ]))
                ]))));
  }
}

class ChooseSignUp extends StatefulWidget {
  const ChooseSignUp({Key? key}) : super(key: key);
  @override
  State<ChooseSignUp> createState() => _ChooseSignUpState();
}

class _ChooseSignUpState extends State<ChooseSignUp> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(children: [
            const Align(
              child: Text('Create your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(8, 61, 119, 1),
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      height: 1)),
              alignment: Alignment.center,
            ),
            Align(
              child: IconButton(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  alignment: Alignment.center,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.chevron_left_rounded),
                  color: Colors.grey,
                  iconSize: 35),
              alignment: Alignment.centerLeft,
            )
          ], alignment: AlignmentDirectional.center),
          const SizedBox(height: 50),
          SignInButton(Buttons.Email,
              elevation: 1,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              onPressed: () {
            setState(() {
              viewNo = 1;
            });
          }, text: 'Sign up with Email'),
          const SizedBox(height: 10),
          SignInButton(Buttons.Google,
              elevation: 1,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              onPressed: () {},
              text: 'Sign up with Google'),
          const SizedBox(height: 10),
          SignInButton(Buttons.FacebookNew,
              elevation: 1,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              onPressed: () {},
              text: 'Sign up with Facebook'),
          const SizedBox(height: 10),
          SignInButton(Buttons.Apple,
              elevation: 1,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              onPressed: () {},
              text: 'Sign up with Apple'),
          const SizedBox(height: 30),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: const Login()));
              },
              child: const Text('Have an account? Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(247, 135, 100, 1),
                      fontFamily: 'Poppins',
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      height: 1))),
          const SizedBox(height: 75),
          const Spacer()
        ]);
  }
}

class FillDetails extends StatefulWidget {
  const FillDetails({Key? key}) : super(key: key);
  @override
  State<FillDetails> createState() => _FillDetailsState();
}

class _FillDetailsState extends State<FillDetails> {
  final name = TextEditingController(text: finalName);
  final date = TextEditingController(text: finalDOB);
  final email = TextEditingController(text: finalEmail);
  final pass1 = TextEditingController(text: finalPassword);
  final pass2 = TextEditingController(text: '');
  String message = '';
  final valid = false;
  bool isDateShow = false;
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  checkDetails() {
    setState(() {
      message = '';
    });
    // Not Empty
    if (name.text == '' ||
        date.text == '' ||
        email.text == '' ||
        pass1.text == '' ||
        pass2.text == '') {
      setState(() {
        message = 'Please fill all details';
      });
    } else {
      // Passwords Match
      if (pass1.text != pass2.text) {
        setState(() {
          message = 'Passwords don\'t match';
        });
      } else {
        // Password Length
        if (pass1.text.length < 6) {
          setState(() {
            message = 'Password should be at least 6 characters long';
          });
        } else {
          // Valid Email
          bool emailValid = RegExp(
                  r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(email.text);
          if (!emailValid) {
            setState(() {
              message = 'Please input a valid email';
            });
          } else {
            setState(() {
              finalName = name.text;
              finalDOB = date.text;
              finalEmail = email.text;
              finalPassword = pass1.text;
              viewNo += 1;
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(children: [
            const Align(
              child: Text('Fill in your details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(8, 61, 119, 1),
                      fontFamily: 'Poppins',
                      fontSize: 23,
                      fontWeight: FontWeight.normal,
                      height: 1)),
              alignment: Alignment.center,
            ),
            Align(
              child: IconButton(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  alignment: Alignment.center,
                  onPressed: () {
                    setState(() {
                      viewNo -= 1;
                    });
                  },
                  icon: const Icon(Icons.chevron_left_rounded),
                  color: Colors.grey,
                  iconSize: 35),
              alignment: Alignment.centerLeft,
            )
          ], alignment: AlignmentDirectional.center),
          const SizedBox(height: 20),
          Row(children: const [
            Text(
              'Enter accurate details',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(76, 76, 76, 1),
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.4375),
            )
          ]),
          const SizedBox(height: 10),
          Material(
              elevation: 1,
              child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(5),
                      prefixIcon: SvgPicture.asset(
                        'assets/vectors/user.svg',
                        fit: BoxFit.scaleDown,
                      ),
                      labelText: 'Full Name',
                      labelStyle: const TextStyle(
                          color: Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                          fontFamily: 'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          height: 1)))),
          const SizedBox(height: 20),
          InkWell(
              onTap: () {
                setState(() {
                  isDateShow = !isDateShow;
                });
              },
              child: Material(
                  elevation: 1,
                  child: TextField(
                      enabled: false,
                      controller: date,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(5),
                          prefixIcon: SvgPicture.asset(
                            'assets/vectors/calendar.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          labelText: 'DD/MM/YYYY',
                          labelStyle: const TextStyle(
                              color:
                                  Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                              fontFamily: 'Lato',
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              height: 1))))),
          isDateShow
              ? Column(children: [
                  SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (DateTime newDateTime) {
                          // Do something
                          setState(() {
                            formattedDate =
                                DateFormat.yMMMMd('en_US').format(newDateTime);
                            date.text = formattedDate;
                            finalDOB = newDateTime.day.toString() +
                                '/' +
                                newDateTime.month.toString() +
                                '/' +
                                newDateTime.year.toString();
                          });
                        },
                      )),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isDateShow = !isDateShow;
                      });
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(color: tualeBlueDark),
                    ),
                  )
                ])
              : Container(
                  child: null,
                ),
          const SizedBox(height: 20),
          Material(
              elevation: 1,
              child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(5),
                      prefixIcon: SvgPicture.asset(
                        'assets/vectors/email2.svg',
                        fit: BoxFit.scaleDown,
                      ),
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                          color: Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                          fontFamily: 'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          height: 1)))),
          const SizedBox(height: 20),
          Material(
              elevation: 1,
              child: TextField(
                  controller: pass1,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(5),
                      prefixIcon: SvgPicture.asset(
                        'assets/vectors/padlock.svg',
                        fit: BoxFit.scaleDown,
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                          color: Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                          fontFamily: 'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          height: 1)))),
          const SizedBox(height: 20),
          Material(
              elevation: 1,
              child: TextField(
                  controller: pass2,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(5),
                      prefixIcon: SvgPicture.asset(
                        'assets/vectors/padlock.svg',
                        fit: BoxFit.scaleDown,
                      ),
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(
                          color: Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                          fontFamily: 'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          height: 1)))),
          const SizedBox(height: 15),
          Row(children: [
            Text(
              message,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.redAccent,
                  fontFamily: 'Lato',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  height: 1.4375),
            )
          ]),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                checkDetails();
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: tualeBlueDark,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text('Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      height: 1))),
          const Spacer(),
          SizedBox(
              width: 254,
              height: 3,
              child: Stack(children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(8, 61, 119, 1),
                        ))),
                Positioned(
                    top: 0,
                    left: 66,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(10, 62, 120, 0.4),
                        ))),
                Positioned(
                    top: 0,
                    left: 132,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(8, 61, 119, 0.4),
                        ))),
                Positioned(
                    top: 0,
                    left: 198,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(8, 61, 119, 0.4),
                        ))),
              ]))
        ]);
  }
}

class ChooseUsername extends StatefulWidget {
  const ChooseUsername({Key? key}) : super(key: key);
  @override
  State<ChooseUsername> createState() => _ChooseUsernameState();
}

class _ChooseUsernameState extends State<ChooseUsername> {
  final username = TextEditingController(text: finalUsername);
  bool isLoading = false;
  String message = '';

  checkUsername() async {
    setState(() {
      isLoading = true;
      message = '';
    });
    debugPrint(username.text);
    if (username.text == '' || username.text.isEmpty) {
      setState(() {
        message = 'Please enter a username';
      });
    } else {
      Dio dio = Dio();
      Response response =
          await dio.get(hostAPI + verifyUsernameAPI + username.text);
      debugPrint(response.data.toString());
      var responseData = response.data;
      if (responseData['success'].toString() == 'true') {
        setState(() {
          viewNo += 1;
          finalUsername = username.text;
          message = 'Valid Username';
        });
      } else {
        setState(() {
          message = responseData['message'].toString();
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(children: [
            const Align(
              child: Text('Choose your username',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(8, 61, 119, 1),
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      height: 1)),
              alignment: Alignment.center,
            ),
            Align(
              child: IconButton(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  alignment: Alignment.center,
                  onPressed: () {
                    setState(() {
                      viewNo -= 1;
                    });
                  },
                  icon: const Icon(Icons.chevron_left_rounded),
                  color: Colors.grey,
                  iconSize: 35),
              alignment: Alignment.centerLeft,
            )
          ], alignment: AlignmentDirectional.center),
          const SizedBox(height: 20),
          Row(children: const [
            Flexible(
                child: Text(
              'Choose a unique username made up of letters, numbers and allowed characters',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(76, 76, 76, 1),
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.4375),
            ))
          ]),
          const SizedBox(height: 10),
          Material(
              elevation: 1,
              child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(5),
                      prefixIcon: SvgPicture.asset(
                        'assets/vectors/at.svg',
                        fit: BoxFit.scaleDown,
                      ),
                      labelText: 'Choose Username',
                      labelStyle: const TextStyle(
                          color: Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                          fontFamily: 'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          height: 1)))),
          const SizedBox(height: 20),
          Row(children: [
            Flexible(
                child: Text(
              message,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.redAccent,
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ))
          ]),
          const SizedBox(height: 10),
          isLoading
              ? Center(
                  child: SpinKitFadingCircle(
                    color: tualeBlueDark.withOpacity(0.75),
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    checkUsername();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: tualeBlueDark,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          height: 1))),
          const Spacer(),
          SizedBox(
              width: 254,
              height: 3,
              child: Stack(children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(10, 62, 120, 0.4),
                        ))),
                Positioned(
                    top: 0,
                    left: 66,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(8, 61, 119, 1),
                        ))),
                Positioned(
                    top: 0,
                    left: 132,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(8, 61, 119, 0.4),
                        ))),
                Positioned(
                    top: 0,
                    left: 198,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(8, 61, 119, 0.4),
                        ))),
              ]))
        ]);
  }
}

class InputPhone extends StatefulWidget {
  const InputPhone({Key? key}) : super(key: key);
  @override
  State<InputPhone> createState() => _InputPhoneState();
}

class _InputPhoneState extends State<InputPhone> {
  final phoneNo = TextEditingController(text: finalPhone);
  bool isLoading = false;
  bool isError = false;
  String message =
      'We will send an OTP to this number to confirm if it is yours';

  checkPhone() async {
    setState(() {
      isLoading = true;
      isError = false;
      message = 'We will send an OTP to this number to confirm if it is yours';
    });
    debugPrint(phoneNo.text);
    if (phoneNo.text == '' ||
        phoneNo.text.isEmpty ||
        phoneNo.text.length < 11) {
      setState(() {
        message = 'Please enter a valid phone number to receive and OTP';
        isError = true;
      });
    } else {
      debugPrint('Sending');
      TwilioPhoneVerify _twilioPhoneVerify;
      _twilioPhoneVerify = TwilioPhoneVerify(
          accountSid:
              'AC9dc1570f1a5dc00f7a27e6008525c246', // replace with Account SID
          authToken: 'XXXXXX', // replace with Auth Token Below
          // 461d6ff2a79360c583c3cb7628b76620
          serviceSid:
              'VAb1899cf594ab102723a39403110cd491' // replace with Service SID
          );
      String tempNo = phoneNo.text.trim();
      if (tempNo.substring(0, 1) == "0") {
        tempNo = tempNo.replaceFirst("0", "+234");
      }
      if (tempNo.substring(0, 3) == "234") {
        tempNo = tempNo.replaceFirst("234", "+234");
      }
      var twilioResponse = await _twilioPhoneVerify.sendSmsCode(tempNo);

      if (twilioResponse.successful ?? false) {
        //code sent
        debugPrint('Sent');
        setState(() {
          finalPhone = tempNo;
          viewNo += 1;
        });
      } else {
        debugPrint(twilioResponse.errorMessage);
        setState(() {
          message = 'Invalid Number';
          isError = true;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(children: [
            const Align(
              child: Text('Add your phone number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(8, 61, 119, 1),
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      height: 1)),
              alignment: Alignment.center,
            ),
            Align(
              child: IconButton(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  alignment: Alignment.center,
                  onPressed: () {
                    setState(() {
                      viewNo -= 1;
                    });
                  },
                  icon: const Icon(Icons.chevron_left_rounded),
                  color: Colors.grey,
                  iconSize: 35),
              alignment: Alignment.centerLeft,
            )
          ], alignment: AlignmentDirectional.center),
          const SizedBox(height: 20),
          Row(children: const [
            Flexible(
                child: Text(
              'Input a phone number that you have access to for verification.',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(76, 76, 76, 1),
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.4375),
            ))
          ]),
          const SizedBox(height: 10),
          Material(
              elevation: 1,
              child: TextField(
                  controller: phoneNo,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: SvgPicture.asset(
                        'assets/vectors/flag.svg',
                        fit: BoxFit.scaleDown,
                      ),
                      hintText: '08012345678',
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                          fontFamily: 'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          height: 1)))),
          const SizedBox(height: 10),
          Row(children: [
            Flexible(
                child: Text(
              message,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: isError ? Colors.redAccent : Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ))
          ]),
          const SizedBox(height: 20),
          isLoading
              ? Center(
                  child: SpinKitFadingCircle(
                    color: tualeBlueDark.withOpacity(0.75),
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    checkPhone();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: tualeBlueDark,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          height: 1))),
          const Spacer(),
          SizedBox(
              width: 254,
              height: 3,
              child: Stack(children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(10, 62, 120, 0.4),
                        ))),
                Positioned(
                    top: 0,
                    left: 66,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(10, 62, 120, 0.4),
                        ))),
                Positioned(
                    top: 0,
                    left: 132,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(8, 61, 119, 1),
                        ))),
                Positioned(
                    top: 0,
                    left: 198,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(8, 61, 119, 0.4),
                        ))),
              ]))
        ]);
  }
}

class VerifyCode extends StatefulWidget {
  const VerifyCode({Key? key}) : super(key: key);
  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final code = TextEditingController(text: '');
  bool isLoading = false;
  String message = '';

  checkCode() async {
    setState(() {
      message = '';
    });
    setState(() {
      isLoading = true;
    });
    debugPrint(code.text);
    if (code.text == '' || code.text.isEmpty) {
      setState(() {
        message = 'Please enter a code';
      });
    } else {
      debugPrint('Sending');
      TwilioPhoneVerify _twilioPhoneVerify;
      _twilioPhoneVerify = TwilioPhoneVerify(
          accountSid:
              'AC9dc1570f1a5dc00f7a27e6008525c246', // replace with Account SID
          authToken:
              'fe1ee4af12207ee9830ef0d46a9cb106', // replace with Auth Token
          serviceSid:
              'VAb1899cf594ab102723a39403110cd491' // replace with Service SID
          );

      var twilioResponse = await _twilioPhoneVerify.verifySmsCode(
          phone: finalPhone, code: code.text.trim());

      if (twilioResponse.successful ?? false) {
        if (twilioResponse.verification?.status ==
            VerificationStatus.approved) {
          debugPrint('Phone number is approved');
          debugPrint('Registering Now');
          debugPrint(finalName);
          debugPrint(finalDOB);
          debugPrint(finalEmail);
          debugPrint(finalPhone);
          debugPrint(finalUsername);
          debugPrint(finalPassword);

          Dio dio = Dio();
          Response response = await dio.post(hostAPI + registerUserAPI, data: {
            "name": finalName,
            "dateOfBirth": finalDOB,
            "email": finalEmail,
            "phoneNumber": finalPhone,
            "username": finalUsername,
            "password": finalPassword
          });
          debugPrint(response.data.toString());
          var responseData = response.data;
          if (responseData['success'].toString() == 'true') {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: const Welcome()));
            showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                                'assets/vectors/actionSuccess.svg'),
                            const SizedBox(height: 25),
                            const Text(
                                'Details verified successfully.\nYou can now sign in.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(76, 76, 76, 1),
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100,
                                    height: 1)),
                            const SizedBox(height: 25),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.bottomToTop,
                                          child: const Login()));
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: tualeBlueDark,
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Text('Go to  Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.bold,
                                        height: 1)))
                          ],
                        ))));
          }
        } else {
          debugPrint('Invalid code');
          setState(() {
            message = 'Invalid Code';
          });
        }
      } else {
        debugPrint(twilioResponse.errorMessage);
        setState(() {
          message = 'Error verifying code';
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(children: [
            const Align(
              child: Text('Verify Phone Number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(8, 61, 119, 1),
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      height: 1)),
              alignment: Alignment.center,
            ),
            Align(
              child: IconButton(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  alignment: Alignment.center,
                  onPressed: () {
                    setState(() {
                      viewNo -= 1;
                    });
                  },
                  icon: const Icon(Icons.chevron_left_rounded),
                  color: Colors.grey,
                  iconSize: 35),
              alignment: Alignment.centerLeft,
            )
          ], alignment: AlignmentDirectional.center),
          const SizedBox(height: 20),
          Row(children: const [
            Flexible(
                child: Text(
              'Enter the One Time Password that was sent to the phone number.',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(76, 76, 76, 1),
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.4375),
            ))
          ]),
          const SizedBox(height: 10),
          Material(
              elevation: 1,
              child: TextField(
                  controller: code,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: SvgPicture.asset(
                        'assets/vectors/padlock.svg',
                        fit: BoxFit.scaleDown,
                      ),
                      hintText: 'XXXXXX',
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                          fontFamily: 'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          height: 1)))),
          const SizedBox(height: 10),
          Row(children: [
            Flexible(
                child: Text(
              message,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.redAccent,
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ))
          ]),
          const SizedBox(height: 20),
          isLoading
              ? Center(
                  child: SpinKitFadingCircle(
                    color: tualeBlueDark.withOpacity(0.75),
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    checkCode();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: tualeBlueDark,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          height: 1))),
          const Spacer(),
          SizedBox(
              width: 254,
              height: 3,
              child: Stack(children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(10, 62, 120, 0.4),
                        ))),
                Positioned(
                    top: 0,
                    left: 66,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(10, 62, 120, 0.4),
                        ))),
                Positioned(
                    top: 0,
                    left: 132,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(8, 61, 119, 0.4),
                        ))),
                Positioned(
                    top: 0,
                    left: 198,
                    child: Container(
                        width: 56,
                        height: 3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(8, 61, 119, 1),
                        ))),
              ]))
        ]);
  }
}
