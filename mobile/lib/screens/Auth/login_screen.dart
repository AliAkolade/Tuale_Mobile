import 'dart:math' as math;

import 'package:mobile/screens/Auth/reset_password_screen.dart';
import 'package:mobile/screens/imports.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final email = TextEditingController(text: '');
  final pass = TextEditingController(text: '');

  // final email = TextEditingController(text: 'tulenoreply@gmail.com');
  // final pass = TextEditingController(text: 'Azerty');

  // final email = TextEditingController(text: 'afolabiogunbanwo@gmail.com');
  // final pass = TextEditingController(text: 'testing');
  // final email = TextEditingController(text: 'clintonali127@gmail.com');
  // final pass = TextEditingController(text: 'Clinton01');

  // final email = TextEditingController(text: 'barelysolution@gmail.com');
  // final pass = TextEditingController(text: 'Abc123');
  String message = '';
  bool hidePass = true;

  bool isLoading = false;

  login() async {
    setState(() {
      isLoading = true;
      message = '';
    });

    Dio dio = Dio();
    Response response = await dio.post(hostAPI + loginUserAPI,
        data: {"email": email.text.trim(), "password": pass.text.trim()});
    debugPrint(response.data.toString());
    var responseData = response.data;
    debugPrint(responseData.toString());
    if (responseData['success'].toString() == 'true') {
      // MixPanelSingleton.instance.mixpanel.timeEvent("Image Upload");
      // MixPanelSingleton.instance.mixpanel.track("Image Upload");
      MixPanelSingleton.instance.mixpanel
          .track('Login', properties: {'User': email.text.trim()});
      MixPanelSingleton.instance.mixpanel
          .getPeople()
          .set("Email", email.text.trim());
      MixPanelSingleton.instance.mixpanel
          .getPeople()
          .set("Name", responseData['name'].toString());
      MixPanelSingleton.instance.mixpanel.flush();

      debugPrint('Login Successful');
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      prefs.setString('token', responseData['token'].toString());

      prefs.setBool('isLoggedIn', true);
      prefs.setString('username', email.text.trim());
      prefs.setString('password', pass.text.trim());

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.topToBottom,
              child: NavBar(
                  index: 0,
                  deepLinkPath: '',
                  deepLink: false,
                  deepLinkId: '')));
    } else {
      setState(() {
        message = responseData['message'];
        var snackBar = SnackBar(
            content: Text(responseData['message'].toString(),
                style: const TextStyle(color: Colors.white)),
            backgroundColor: tualeOrange,
            duration: const Duration(seconds: 5),
            padding: const EdgeInsets.all(20));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        body: SafeArea(
            child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      Row(children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset('assets/vectors/x.svg'))
                      ]),
                      const SizedBox(height: 30),
                      const Text('Sign into your account',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Poppins',
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                              height: 1)),
                      const SizedBox(height: 30),
                      Container(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(4, 42, 43, 0.1),
                                blurRadius: 3)
                          ]),
                          child: Material(
                              elevation: 0,
                              color: Colors.white,
                              child: TextField(
                                  controller: email,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(5),
                                      prefixIcon: SvgPicture.asset(
                                        'assets/vectors/email.svg',
                                        fit: BoxFit.scaleDown,
                                      ),
                                      labelText: 'Email',
                                      labelStyle: const TextStyle(
                                          color: Color.fromRGBO(
                                              3, 42, 43, 0.5199999809265137),
                                          fontFamily: 'Lato',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          height: 1))))),
                      const SizedBox(height: 20),
                      Container(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(4, 42, 43, 0.1),
                                blurRadius: 3)
                          ]),
                          child: Material(
                              elevation: 0,
                              color: Colors.white,
                              child: TextField(
                                  controller: pass,
                                  obscureText: hidePass,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(5),
                                      prefixIcon: SvgPicture.asset(
                                        'assets/vectors/padlock.svg',
                                        fit: BoxFit.scaleDown,
                                      ),
                                      suffixIcon: IconButton(
                                        color: const Color.fromRGBO(
                                            3, 42, 43, 0.5199999809265137),
                                        icon: hidePass
                                            ? const Icon(
                                                Icons.visibility_outlined)
                                            : const Icon(
                                                Icons.visibility_off_outlined),
                                        onPressed: () {
                                          setState(() {
                                            hidePass = !hidePass;
                                          });
                                        },
                                      ),
                                      labelText: 'Password',
                                      labelStyle: const TextStyle(
                                          color: Color.fromRGBO(
                                              3, 42, 43, 0.5199999809265137),
                                          fontFamily: 'Lato',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          height: 1))))),
                      const SizedBox(height: 50),
                      (message == '')
                          ? Container(child: null)
                          : Column(children: [
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
                              const SizedBox(height: 10)
                            ]),
                      isLoading
                          ? Center(
                              child: SpinKitFadingCircle(
                                color: tualeOrange.withOpacity(0.75),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                // //DISABLED FOR NOW
                                login();
                                //  Navigator.push(
                                //      context,
                                //      PageTransition(
                                //          type: PageTransitionType.topToBottom,
                                //          child: NavBar(index: 0)));
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: tualeOrange,
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text('Login',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
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
                                    type: PageTransitionType.topToBottom,
                                    child: const ResetPassword()));
                          },
                          child: const Text('Forgot password?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(76, 76, 76, 1),
                                  fontFamily: 'Lato',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  height: 1))),
                      const SizedBox(height: 20),
                      Transform.rotate(
                          angle: -2.4848083448933725e-17 * (math.pi / 180),
                          child: const Divider(
                              color: Color.fromRGBO(135, 153, 153, 1),
                              thickness: 0.4000000059604645)),
                      const SizedBox(height: 20),
                      // SignInButton(Buttons.Google,
                      //     elevation: 1,
                      //     shape: const RoundedRectangleBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(7))),
                      //     onPressed: () {},
                      //     text: 'Continue with Google'),
                      // const SizedBox(height: 5),
                      // SignInButton(Buttons.FacebookNew,
                      //     elevation: 1,
                      //     shape: const RoundedRectangleBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(7))),
                      //     onPressed: () {},
                      //     text: 'Continue with Facebook'),
                      // const SizedBox(height: 5),
                      // SignInButton(Buttons.Apple,
                      //     elevation: 1,
                      //     shape: const RoundedRectangleBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(7))),
                      //     onPressed: () {},
                      //     text: 'Continue with Apple'),
                      const SizedBox(height: 20),
                      Transform.rotate(
                          angle: -2.4848083448933725e-17 * (math.pi / 180),
                          child: const Divider(
                              color: Color.fromRGBO(135, 153, 153, 1),
                              thickness: 0.4000000059604645)),
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const Login()));
                          },
                          child: const Text(
                              'No Account? Click here to get started.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(8, 61, 119, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.normal,
                                  height: 1))),
                      const SizedBox(height: 20)
                    ])))));
  }
}
