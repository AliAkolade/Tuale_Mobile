import 'package:mobile/screens/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
        backgroundColor: Palette.tualeSwatchDark,
        body: Center(
            child: Column(children: [
          const Spacer(),
          Image.asset('assets/images/tuale_logo.png'),
          const Text('Tuale',
              style: TextStyle(
                  color: Colors.white, letterSpacing: 3, fontSize: 50)),
          const Spacer()
        ])));
  }
}
