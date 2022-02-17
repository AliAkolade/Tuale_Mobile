import 'package:mobile/screens/Profile/profile_screen.dart';
import 'package:mobile/screens/imports.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
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
          "Edit Profile",
          style: TextStyle(
              color: tualeBlueDark,
              fontFamily: 'Poppins',
              fontSize: 18,
              // fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: Column(
        children: [
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
            infoString: "Bio",
            fieldHeight: 100,
          ),
          const ChangePassBtn(),
          SizedBox(height: 20.h),
          const SaveBioBtn(),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}
