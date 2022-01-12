import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/screens/login_screen.dart';
import 'package:mobile/screens/signup_screen.dart';
import 'package:mobile/utils/constants.dart';
import 'package:page_transition/page_transition.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                                    child: SignUp()));
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text('Get Started',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
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
                          child: const Text('I already have an account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(247, 135, 100, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w600,
                                  height: 1))),
                      const SizedBox(height: 30)
                    ]))));
  }
}
