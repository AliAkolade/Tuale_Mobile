






import 'package:mobile/screens/imports.dart';

class galleryScreen extends StatefulWidget {
  const galleryScreen({Key? key}) : super(key: key);

  @override
  _galleryScreenState createState() => _galleryScreenState();
}

class _galleryScreenState extends State<galleryScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                bottom: const TabBar(
                    unselectedLabelColor: tualeBlueDark,
                    indicatorColor: tualeOrange,
                    indicatorWeight: 1.1,
                    labelColor: tualeOrange,
                    labelStyle:  TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1),
                    tabs: [
                      Tab(
                          child: Text("Images")),
                       Tab(text: "Videos")
                    ]),
              ),
              body: TabBarView(children:
              [
                GalleryImage(),
                GalleryVideo(),

              ]
              
               ),
            )));
  }
}
