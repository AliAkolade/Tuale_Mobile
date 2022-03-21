import 'package:mobile/screens/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: Color.fromRGBO(250, 250, 250, 1)),
        child: Scaffold(
            backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
            body: Center(
                child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset('assets/images/bottomSplash.png',
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter)),
                  Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/vectors/TualeLogo.svg'))
                ]))));
  }
}
