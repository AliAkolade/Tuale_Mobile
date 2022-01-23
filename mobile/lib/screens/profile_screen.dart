import 'package:flutter/material.dart';
import 'package:mobile/screens/allPosts.dart';
import 'package:mobile/screens/signup_screen.dart';
import 'package:mobile/screens/starredPosts.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/tuale_icons.dart';
import 'package:page_transition/page_transition.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
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
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 315),
              child: Container(
                height: 315,
                child: Column(
                  children: [
                    Spacer(),
                    const SizedBox(
                      height: 90,
                      width: 90,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/demo_profile.png'),
                      ),
                    ),
                    Spacer(),
                    const Text(
                      "@siphie_zo",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    Spacer(),
                    const Text(
                      "Nairobi, Kenya",
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          height: 1),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 3,
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
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  height: 1),
                            ),
                          ],
                        ),
                        Spacer(),
                        SizedBox(
                          height: 60,
                          // width: 9,
                          child: VerticalDivider(
                            width: 10,
                            thickness: 1,
                            color: Colors.grey.withOpacity(0.8),
                          ),
                        ),
                        Spacer(),
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
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  height: 1),
                            ),
                          ],
                        ),
                        Spacer(),
                        SizedBox(
                          height: 60,
                          // width: 9,
                          child: VerticalDivider(
                            width: 10,
                            thickness: 1,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        Spacer(),
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
                                  color: Colors.black,
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
                    const Text("Dark Skinned and I love it"),
                    const Spacer(
                      flex: 3,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                insetPadding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Container(
                                    height: 1000,
                                    // width: 1050,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                         TopBar(),
                                         const ProfilePic(),
                                          BioField(
                                            infoString: "Full Name",
                                            fieldHeight: 50,
                                          ),
                                          BioField(
                                            infoString: "Username",
                                            fieldHeight: 50,
                                          ),
                                          BioField(
                                            infoString: "Email",
                                            fieldHeight: 50,
                                          ),
                                          BioField(
                                            infoString: "Phone Number",
                                            fieldHeight: 50,
                                          ),
                                          BioField(
                                            infoString: "Bio",
                                            fieldHeight: 100,
                                          ),
                                         const ChangePassBtn(),
                                         const SaveBioBtn(),
                                        const  SizedBox(height: 10)
                                        ],
                                      ),
                                    )),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(120, 50),
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
                    const TabBar(
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: tualeBlueDark,
                        indicatorWeight: 1.1,
                        labelColor: tualeBlueDark,
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            height: 1),
                        tabs: [
                          Tab(
                            icon: Icon(Icons.view_list_outlined),
                          ),
                          Tab(icon: Icon(TualeIcons.star)),
                        ]),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            actions: const [
              Icon(
                Icons.more_vert_rounded,
                size: 25,
                color: Colors.black,
              )
            ],
            leading: const Icon(
              Icons.arrow_back_rounded,
              size: 25,
              color: Colors.black,
            ),
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
          body: TabBarView(
            children: [AllPosts(), starredPosts()],
          ),
        ),
      ),
    );
  }
}

class SaveBioBtn extends StatelessWidget {
  const SaveBioBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          minimumSize:
              const Size(130, 45),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                      10))),
      child: const Text('Save',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(
                  255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1)),
    );
  }
}

class ChangePassBtn extends StatelessWidget {
  const ChangePassBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showDialog(context: context, builder: 
          (BuildContext context) {
            return Dialog(
                 insetPadding:
                                    const EdgeInsets.only(left: 30, right: 30),
              child: Container(
               // width: 200,
                height: 400,
                child: Column(children:  [
                  TopBar(),
                  BioField(infoString: "Current Password", fieldHeight: 50,),
                     BioField(infoString: "New Password", fieldHeight: 50,),
                        BioField(infoString: "Confirm Password", fieldHeight: 50,),
                        SizedBox(height: 20,),
                        SaveBioBtn()
                ]),
              ),
            );
          }
          );
        },
        child: const Text(
            "Change Password",
            style: TextStyle(
                color: tualeBlueDark,
                fontFamily: 'Poppins',
                fontSize: 15.5,
                fontWeight:
                    FontWeight.bold,
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
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children:  [
      const  SizedBox(
          width: 20,
        ),
       const Icon(Icons.arrow_back_rounded),
      const  Spacer(
          flex: 2,
        ),
       Text(barText!   ,
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

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 160,
      child: Stack(
        children: [
          const SizedBox(
            height: 160,
            width: 160,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/demo_profile.png"),
            ),
          ),
          Align(
            widthFactor: 4.0,
            heightFactor: 7,
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                  color: tualeBlueDark,
                  borderRadius: BorderRadius.circular(30)),
              height: 38,
              width: 38,
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

//
class BioField extends StatelessWidget {
  String? infoString;
  double? fieldHeight;

  BioField({this.infoString, this.fieldHeight});
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
