import 'package:image_picker/image_picker.dart';
import 'package:mobile/screens/Profile/edit_profile.dart';
import 'package:mobile/screens/imports.dart';

class Profile extends StatefulWidget {
  bool? isUser = false;

  Profile({this.isUser});

  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
            actions: const [
              Icon(
                Icons.more_vert_rounded,
                color: Colors.black,
              )
            ],
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              "Siphiwe Zola",
              style: TextStyle(
                  color: tualeBlueDark,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  height: 1),
            ),
          ),
          body: NestedScrollView(
              physics: const ClampingScrollPhysics(),
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(const ProfileInfo()),
                    pinned: false,
                    //  floating: true,
                  ),
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      //floating: true,
                      pinned: true,
                      // collapsedHeight: 100,
                      expandedHeight: 10,
                      flexibleSpace: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          TabBar(
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Colors.transparent,
                              indicatorWeight: 1.1,
                              labelColor: tualeBlueDark,
                              labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  height: 1),
                              tabs: [
                                const Tab(
                                  icon: Icon(
                                    TualeIcons.allposts,
                                    size: 30,
                                  ),
                                ),
                                Tab(
                                    icon: Icon(
                                  TualeIcons.starredpost,
                                  size: 35,
                                  // color: Colors.grey.withOpacity(0.3),
                                )),
                              ]),
                          SizedBox(
                            height: 3,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  Builder(builder: (context) {
                    return CustomScrollView(
                      slivers: [
                        SliverOverlapInjector(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context)),
                        AllPosts()
                      ],
                    );
                  }),
                  Builder(builder: (context) {
                    return CustomScrollView(
                      slivers: [
                        SliverOverlapInjector(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context)),
                        AllPosts(),
                      ],
                    );
                  }),
                ],
              )),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final Widget _tabBar;

  @override
  double get minExtent => 350;

  @override
  double get maxExtent => 350;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 350,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 90,
              width: 90,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/demo_profile.png'),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            const Text(
              "@siphie_zo",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  // fontWeight: FontWeight.bold,
                  height: 1),
            ),
            const Spacer(
              flex: 2,
            ),
            const Text(
              "Nairobi, Kenya",
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  height: 1),
            ),
            const Spacer(
              flex: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 4,
                ),
                Column(
                  children: const [
                    Text(
                      "2389",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    Text(
                      "Fans",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          height: 1),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 60,
                  // width: 9,
                  child: VerticalDivider(
                    width: 10,
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
                const Spacer(),
                Column(
                  children: const [
                    Text(
                      "67",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    Text(
                      "Friends",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          height: 1),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 60,
                  // width: 9,
                  child: VerticalDivider(
                    width: 10,
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
                const Spacer(),
                Column(
                  children: const [
                    Text(
                      "35",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    Text(
                      "Tuales Given",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          height: 1),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            const Text(
              "Dark Skinned and I love it",
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  height: 1),
            ),
            const Spacer(
              flex: 4,
            ),
            Row(
              children: [
                const Spacer(
                  flex: 3,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const EditProfile()));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(155, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Edit Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            height: 1))),
                const Spacer(
                  flex: 3,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: TualletHome()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: tualeOrange,
                        minimumSize: const Size(155, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Tuallet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            height: 1))),
                const Spacer(
                  flex: 3,
                )
              ],
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ));
  }
}

class SaveBioBtn extends StatelessWidget {

  VoidCallback onPress;
  SaveBioBtn({
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(130, 45),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: const Text('Save',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1)),
    );
  }
}

class ChangePassBtn extends StatefulWidget {

  ChangePassBtn({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePassBtn> createState() => _ChangePassBtnState();
}

class _ChangePassBtnState extends State<ChangePassBtn> {
  TextEditingController currentPwd = TextEditingController();

  TextEditingController newPwd= TextEditingController();

  TextEditingController cNewPwd= TextEditingController();

  showSnackBar(String msg, bool success) {
    final snackBar = SnackBar(
      content: Text(msg, style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: success ? Colors.green : tualeOrange,
      duration: const Duration(seconds: 5),
      padding: const EdgeInsets.all(20),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  insetPadding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                    // width: 200,
                    height: 400,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        TopBar(
                          barText: "Change Password",
                        ),
                        BioField(
                          infoString: "Current Password",
                          fieldHeight: 50,
                          txtController: currentPwd,
                        ),
                        BioField(
                          infoString: "New Password",
                          fieldHeight: 50,
                          txtController: newPwd,
                        ),
                        BioField(
                          infoString: "Confirm Password",
                          fieldHeight: 50,
                          txtController: cNewPwd,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SaveBioBtn(
                          onPress: () async {
                            // TODO : call Api
                            if(newPwd.text == cNewPwd.text){
                              var res = await Api().updateUserPwd(currentPwd.text,newPwd.text);
                              if(res[0]){
                                debugPrint(res[1]);
                                showSnackBar(res[1],res[0]);
                              }else{
                                debugPrint(res[1]);
                                showSnackBar(res[1],res[0]);
                              }
                            }else{
                              String errMsg = "NewPwd and ConfirmPwd are different";
                              debugPrint(errMsg);
                              showSnackBar(errMsg,false);
                            }
                          },
                        ),
                      ]),
                    ),
                  ),
                );
              });
        },
        child: const Text("Change Password",
            style: TextStyle(
                color: tualeBlueDark,
                fontFamily: 'Poppins',
                fontSize: 15.5,
                fontWeight: FontWeight.bold,
                height: 1)));
  }
}

class TopBar extends StatelessWidget {
  String? barText;

  TopBar({this.barText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 15,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          width: 20,
        ),
        const Icon(Icons.arrow_back_rounded),
        const Spacer(
          flex: 2,
        ),
        Text(
          barText!,
          style: const TextStyle(
              color: tualeBlueDark,
              fontFamily: 'Poppins',
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              height: 1),
        ),
        const Spacer(
          flex: 3,
        ),
      ]),
    );
  }
}

//
class BioField extends StatelessWidget {
  String? infoString;
  double? fieldHeight;
  TextEditingController? txtController;

  BioField({this.infoString, this.fieldHeight, this.txtController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 22, right: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(infoString!),
          SizedBox(
            height: fieldHeight!,
            width: 350,
            child: TextField(
              maxLines: 7,
              controller: txtController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 2),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      style: BorderStyle.solid, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      style: BorderStyle.solid, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
