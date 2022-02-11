import 'package:mobile/screens/Discover/searchPage.dart';
import 'package:mobile/screens/imports.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);
  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, 103),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: SizedBox(
                        height: 42.h,
                        width: double.infinity,
                        child: FocusScope(
                          onFocusChange: (focus) {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.topToBottom,
                                    child: SearchScreen()));
                          },
                          child: Focus(
                            child: TextField(
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 2),
                                prefixIcon: Icon(Icons.search_rounded),
                                hintText: "Search",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.none,
                                      color: Colors.grey.withOpacity(0.8)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.none,
                                      color: Colors.grey.withOpacity(0.8)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                fillColor: Colors.grey.withOpacity(0.1),
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TabBar(
                        unselectedLabelColor: tualeBlueDark,
                        indicatorColor: tualeOrange,
                        indicatorWeight: 1.1,
                        labelColor: tualeOrange,
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                            // fontWeight: FontWeight.bold,
                            height: 1),
                        tabs: [
                          Tab(text: "All"),
                          Tab(text: "Photos"),
                          Tab(text: "Videos"),
                          Tab(text: "Text")
                        ]),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 1,
              actions: [
                Icon(TualeIcons.notificationbell, color: tualeBlueDark),
                SizedBox(
                  width: 10.w,
                )
              ],
              title: Text(
                "Discover",
                style: TextStyle(
                    color: tualeBlueDark,
                    fontFamily: 'Poppins',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    height: 1),
              ),
            ),
            body: const TabBarView(
              children: [
                allScreen(),
                photosScreen(),
                videoScreen(),
                textScreen()
              ],
            )),
      ),
    );
  }
}
