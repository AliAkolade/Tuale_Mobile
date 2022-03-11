import 'package:mobile/screens/imports.dart';

int viewNo = 0;
String finalEmail = '';
String finalOTP = '';
String finalUserID = '';
String finalPassword = '';
String finalPassword2 = '';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  int columnNo = viewNo;
  List toView = <Widget>[
    const EnterEmail(),
    const EnterOTP(),
    const SetPassword()
  ];

  reconcile() {
    setState(() {
      columnNo = viewNo;
    });
  }

  @override
  void dispose() {
    super.dispose();
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

class EnterEmail extends StatefulWidget {
  const EnterEmail({Key? key}) : super(key: key);
  @override
  State<EnterEmail> createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  final email = TextEditingController(text: finalEmail);
  String message = '';
  final valid = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkDetails() async {
    setState(() {
      message = '';
    });
    // Not Empty
    if (email.text == '') {
      setState(() {
        message = 'Please fill all details';
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
          finalEmail = email.text;
          isLoading = true;
        });
        Dio dio = Dio();
        Response response = await dio
            .post(hostAPI + forgotPasswordAPI, data: {"email": finalEmail});
        debugPrint(response.data.toString());
        var responseData = response.data;
        if (responseData['success'].toString() == 'true') {
          setState(() {
            viewNo += 1;
            isLoading = false;
          });
        } else {
          setState(() {
            message = responseData['message'].toString();
            isLoading = false;
          });
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
              child: Text('Reset Password',
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
                      Navigator.pop(context);
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
              'Silly you! We can reset your password for you',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(76, 76, 76, 1),
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.4375),
            ))
          ]),
          const SizedBox(height: 15),
          Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: Color.fromRGBO(4, 42, 43, 0.1), blurRadius: 3)
              ]),
              child: Material(
                  color: Colors.white,
                  elevation: 0,
                  child: TextField(
                      keyboardType: TextInputType.emailAddress,
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
                              color:
                                  Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                              fontFamily: 'Lato',
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              height: 1))))),
          const SizedBox(height: 15),
          (message == '')
              ? Container(child: null)
              : Row(children: [
                  Text(
                    message,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  )
                ]),
          const SizedBox(height: 10),
          isLoading
              ? Center(
                  child: SpinKitFadingCircle(
                    color: tualeOrange.withOpacity(0.75),
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    checkDetails();
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
                          color: Color.fromRGBO(8, 61, 119, 1),
                        ))),
                Positioned(
                    top: 0,
                    left: 99,
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

class EnterOTP extends StatefulWidget {
  const EnterOTP({Key? key}) : super(key: key);
  @override
  State<EnterOTP> createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  final otp = TextEditingController(text: finalOTP);
  String message = '';
  final valid = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkDetails() async {
    setState(() {
      message = '';
    });
    // Not Empty
    if (otp.text == '') {
      setState(() {
        message = 'Please fill all details';
      });
    } else {
      setState(() {
        finalOTP = otp.text;
        isLoading = true;
      });
      Dio dio = Dio();
      Response response = await dio
          .post(hostAPI + verifyResetTokenAPI, data: {"token": finalOTP});
      debugPrint(response.data.toString());
      var responseData = response.data;
      if (responseData['success'].toString() == 'true') {
        setState(() {
          viewNo += 1;
          isLoading = false;
          finalUserID = responseData['userId'].toString();
        });
      } else {
        setState(() {
          message = responseData['message'].toString();
          isLoading = false;
        });
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
              child: Text('Verify your email',
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
            Flexible(
                child: Text(
              'Enter the one time password sent to your email to proceed',
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
          Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: Color.fromRGBO(4, 42, 43, 0.1), blurRadius: 3)
              ]),
              child: Material(
                  color: Colors.white,
                  elevation: 0,
                  child: TextField(
                      keyboardType: TextInputType.text,
                      controller: otp,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(5),
                          prefixIcon: SvgPicture.asset(
                            'assets/vectors/padlock.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          labelText: 'Enter OTP',
                          labelStyle: const TextStyle(
                              color:
                                  Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                              fontFamily: 'Lato',
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              height: 1))))),
          const SizedBox(height: 15),
          (message == '')
              ? Container(child: null)
              : Row(children: [
                  Text(
                    message,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  )
                ]),
          const SizedBox(height: 10),
          isLoading
              ? Center(
                  child: SpinKitFadingCircle(
                    color: tualeOrange.withOpacity(0.75),
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    checkDetails();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: tualeBlueDark,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Proceed',
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
                          color: Color.fromRGBO(8, 61, 119, 0.4),
                        ))),
                Positioned(
                    top: 0,
                    left: 99,
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

class SetPassword extends StatefulWidget {
  const SetPassword({Key? key}) : super(key: key);
  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final pass1 = TextEditingController(text: finalPassword);
  final pass2 = TextEditingController(text: '');
  String message = '';
  final valid = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkDetails() async {
    setState(() {
      message = '';
    });
    // Not Empty
    if (pass1.text == '' || pass2.text == '') {
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
          setState(() {
            finalPassword = pass1.text;
            finalPassword2 = pass2.text;
            isLoading = true;
          });
          Dio dio = Dio();
          print(hostAPI + resetPasswordAPI + finalOTP);

          try {
            Response response = await dio
                .put(hostAPI + resetPasswordAPI + finalUserID, data: {
              "password": finalPassword,
              "confirmPassword": finalPassword2
            });
            debugPrint(response.data.toString());
            var responseData = response.data;
            if (responseData['success'].toString() == 'true') {
              setState(() {
                // viewNo += 1;
                isLoading = false;
              });
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
                              const Text('Password Reset Successful',
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
                                            type:
                                                PageTransitionType.bottomToTop,
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
                                  child: const Text('Log In',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.bold,
                                          height: 1)))
                            ],
                          ))));
            } else {
              setState(() {
                message = responseData['message'].toString();
                isLoading = false;
              });
              var snackBar = SnackBar(
                  content: Text(message,
                      style: const TextStyle(color: Colors.white)),
                  backgroundColor: tualeOrange,
                  duration: const Duration(seconds: 5),
                  padding: const EdgeInsets.all(20));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } on Exception catch (e) {
            print(e);
          } finally {
            setState(() {
              isLoading = false;
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
              child: Text('Create new password',
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
            Flexible(
                child: Text(
              'Now you can set a new password. Try not to forget it',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(76, 76, 76, 1),
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.4375),
            ))
          ]),
          const SizedBox(height: 20),
          Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: Color.fromRGBO(4, 42, 43, 0.1), blurRadius: 3)
              ]),
              child: Material(
                  color: Colors.white,
                  elevation: 0,
                  child: TextField(
                      controller: pass1,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(5),
                          prefixIcon: SvgPicture.asset(
                            'assets/vectors/padlock.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          labelText: 'New Password',
                          labelStyle: const TextStyle(
                              color:
                                  Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                              fontFamily: 'Lato',
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              height: 1))))),
          const SizedBox(height: 20),
          Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: Color.fromRGBO(4, 42, 43, 0.1), blurRadius: 3)
              ]),
              child: Material(
                  color: Colors.white,
                  elevation: 0,
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
                              color:
                                  Color.fromRGBO(3, 42, 43, 0.5199999809265137),
                              fontFamily: 'Lato',
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              height: 1))))),
          const SizedBox(height: 15),
          (message == '')
              ? Container(child: null)
              : Row(children: [
                  Text(
                    message,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  )
                ]),
          const SizedBox(height: 10),
          isLoading
              ? Center(
                  child: SpinKitFadingCircle(
                    color: tualeOrange.withOpacity(0.75),
                  ),
                )
              : ElevatedButton(
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
                          color: Color.fromRGBO(8, 61, 119, 0.4),
                        ))),
                Positioned(
                    top: 0,
                    left: 99,
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
