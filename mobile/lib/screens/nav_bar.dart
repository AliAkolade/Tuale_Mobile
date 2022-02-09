


import 'package:mobile/models/currentUserdetails.dart';
import 'package:mobile/screens/imports.dart';

import 'imports.dart';


class NavBar extends StatefulWidget {
  final int index;

  const NavBar({Key? key, required this.index, }) : super(key: key);
  @override
  State<NavBar> createState() => _NavBarState();
}
 

class _NavBarState extends State<NavBar> {

  late PersistentTabController _controller;

   
  List<Widget> _buildScreens() {
    return  [Home(), Discover(), PostTimeline(), Leaderboard(), userProfile(username: currentUsername, isUser: true,) ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_rounded),
        title: ("Home"),
        activeColorPrimary: tualeOrange,
        inactiveColorPrimary: tualeBlueDark,
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.solidCompass),
          title: ("Discover"),
          activeColorPrimary: tualeOrange,
          inactiveColorPrimary: tualeBlueDark),
      PersistentBottomNavBarItem(
      iconSize: 40,
    //  contentPadding: 2,
       icon: Padding(
         padding:  EdgeInsets.only(bottom: 30),
         child: Icon(Icons.add_circle,
     
         ),
       ),
       
          title: ("."),
         activeColorPrimary: tualeOrange,
        inactiveColorPrimary: tualeBlueDark,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.leaderboard_rounded),
        title: ("Leaderboard"),
        activeColorPrimary: tualeOrange,
        inactiveColorPrimary: tualeBlueDark,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: tualeOrange,
        inactiveColorPrimary: tualeBlueDark,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
       Future getCurrentUserId () async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
 
    Response currentUser = await dio.get(hostAPI + currentuser );
 

    // log(response.data.toString());
    
 //  currentUserId = currentUser.data['user']["_id"].toString();

setState(() {

     currentUsername = currentUser.data['user']["username"].toString();
});


 // CurrentUserDetails currentdetails = CurrentUserDetails(currentuserid: currentUserId, currentUserUsername: currentUserUsername, );
 

  //    return currentUserId; 
    


  }
    
   getCurrentUserId();
   Api().getCurrentUserId();
    setState(() {
      _controller = PersistentTabController(initialIndex: widget.index);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<camera>(
      builder: (context, cam, child) {
        return PersistentTabView(
          context,
      
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true,
          hideNavigationBar: cam.hideNav,     // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle:
              NavBarStyle.simple, 
       
        );
      }
    );
  }
}
