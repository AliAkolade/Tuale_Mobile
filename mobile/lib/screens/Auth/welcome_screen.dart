import 'package:mobile/screens/imports.dart';
import 'package:url_launcher/url_launcher.dart';

class Welcome extends StatefulWidget {
  const Welcome({
    Key? key,
  }) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
          return true as Future<bool>;
        },
        child: Scaffold(
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
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                            padding: const EdgeInsets.all(30),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                      child: RichText(
                                                          text: const TextSpan(
                                                              children: [
                                                            TextSpan(
                                                                text:
                                                                    'By signing up, you agree to our ',
                                                                style: TextStyle(
                                                                    color: Color.fromRGBO(
                                                                        76, 76, 76, 1),
                                                                    fontFamily: 'Poppins',
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                    FontWeight.w100,
                                                                    height: 1.5)),
                                                            TextSpan(
                                                              text:
                                                                  'Terms of Service\n\n',
                                                              style: TextStyle(
                                                                  color: tualeOrange,
                                                                  fontFamily: 'Poppins',
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight.w100,
                                                                  height: 1.5),
                                                              /*recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                            // Double tapped.
                          }*/
                                                            ),
                                                                TextSpan(
                                                                text:
                                                                    'View our ',
                                                                style: TextStyle(
                                                                    color: Color.fromRGBO(
                                                                        76, 76, 76, 1),
                                                                    fontFamily: 'Poppins',
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                    FontWeight.w100,
                                                                    height: 1.5)),
                                                            TextSpan(
                                                              text:
                                                                  'Privacy Policy',
                                                              style: TextStyle(
                                                                  color: tualeOrange,
                                                                  fontFamily: 'Poppins',
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight.w100,
                                                                  height: 1.5),
                                                              /*recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                            // Double tapped.
                          }*/
                                                            ),

                                                          ])),
                                                      onTap: () {
                                                        launch(
                                                            "https://www.tuale.app/privacy");
                                                      }),
                                                  const SizedBox(height: 25),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                type:
                                                                    PageTransitionType
                                                                        .fade,
                                                                child:
                                                                    const SignUp()));
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          primary:
                                                              tualeBlueDark,
                                                          minimumSize:
                                                              const Size(
                                                                  double
                                                                      .infinity,
                                                                  50),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      child: const Text(
                                                          'Agree and Continue',
                                                          textAlign: TextAlign
                                                              .center,
                                                          style:
                                                              TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      15.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  height: 1)))
                                                ]))));
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
                        ])))));
  }
}
