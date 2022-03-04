import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/screens/Profile/controllers/profileController.dart';
import 'package:mobile/screens/Profile/profile_screen.dart';
import 'package:mobile/screens/imports.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController bio = TextEditingController();
  String profilImg = "";
  String profilImgProfilId = "";
  File fileContent = File("");
  String filePath = "";
  final cloudinary = CloudinaryPublic('demilade211', 'Tuale-Ogunbanwo', cache: false);


  @override
  void initState() {
    // TODO: implement initState
    var currentUsr  = Get.find<LoggedUserController>().loggedUser.value;

    //debugPrint("TextName : ${currentUsr.currentuserAvatar!}");

    setState(() {
      fullname.text = currentUsr.currentuserName! != "" ?
      currentUsr.currentuserName! : "";
      username.text = currentUsr.currentUserUsername! != "" ?
      currentUsr.currentUserUsername!  : "";
      bio.text = currentUsr.currentuserBio!;
      profilImgProfilId = currentUsr.currentuserAvatarPublicId!;
      profilImg = currentUsr.currentuserAvatarUrl! != "" ?
      currentUsr.currentuserAvatarUrl! : "https://i.pinimg.com/originals/7a/e7/06/7ae706d977ccd25285c9fe7f424e247d.jpg";
    });


    debugPrint("initstate : ${username.text }");
    super.initState();
  }

  Future uploadPicture() async {
    final XFile? asset;
    File file;
    String filePath;
    asset = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(asset != null) {
      file = File(asset.path);
      filePath = asset.path;
      debugPrint("imgUrl  : $file");
      return [file,filePath];
    }
  }

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


  updateProfilApi(String publicId, String url) async{

    var result = await Api().updateUserProfil(
        username.text,
        fullname.text,
        bio.text,
        publicId,
        url
    );
    if(result[0]) {
      debugPrint(result[1]);
      showSnackBar(result[1],result[0]);
      // TODO : try to Everything pass - refresh currentUserInformations
      Get.delete<LoggedUserController>;
      Get.put(LoggedUserController());
      Get.put(ProfileController(controllerusername:username.text), tag: "myprofile").getProfileInfo(username.text);
    }else{
      debugPrint("Err : "+result[1]);
      showSnackBar(result[1],result[0]);
    }
  }

  updateProfil() async {
    try{
      Loader.show(context,
          isSafeAreaOverlay: false,
          isAppbarOverlay: true,
          isBottomBarOverlay: false,
          progressIndicator: CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 5.0,
            percent: 1.0,
            //center: Text(uploadingPercentage.toString() + "%"),
            center: const Text("Loading...."),
            progressColor: tualeOrange,
          ),
          themeData: Theme.of(context)
              .copyWith(accentColor: Colors.black38),
          overlayColor: const Color(0x99E8EAF6));

      if(filePath.trim() != ""){
        CloudinaryResponse response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(filePath,folder: "Tuale profile pictures", resourceType: CloudinaryResourceType.Image),
            onProgress: (count, total){
            }
        );
        debugPrint("➡️ Img has been saved in Cloud : ${response.secureUrl}");
        if(response.secureUrl  != "") {
          String publicId = response.publicId;
          String url = response.secureUrl;
          await updateProfilApi(publicId,url);
          Loader.hide();
        }
        else{
          Loader.hide();
          debugPrint("Something went wrong, retry");
        }
      }
      else{
        String publicId = profilImgProfilId;
        String url = profilImg;
        await updateProfilApi(publicId,url);
        Loader.hide();
      }
    }
    on CloudinaryException catch (e) {
      Loader.hide();
      debugPrint("Cloudinary Err : ${e.message}");
    }
  }

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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ProfilPic
              GestureDetector(
                child: Container(
                  height: 160,
                  width: 160,
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 160,
                        width: 160,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(300.0),
                          child: filePath == "" ?
                          Image.network(profilImg,fit: BoxFit.cover,):
                          Image.file(fileContent, fit: BoxFit.cover,),
                        )
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
                ),
                onTap: () async {
                  var res = await uploadPicture();
                  if(res != null){
                    setState(() {
                      fileContent = res[0];
                      filePath = res[1];
                    });
                  }
                },
              ),
              BioField(
                infoString: "Full Name",
                fieldHeight: 50,
                txtController: fullname,
              ),
              BioField(
                infoString: "Username",
                fieldHeight: 50,
                txtController: username,
              ),
              BioField(
                infoString: "Bio",
                fieldHeight: 100,
                txtController: bio,
              ),
              ChangePassBtn(),
              SizedBox(height: 20.h),
              SaveBioBtn(
                onPress: () {
                  // TODO : save in cloudinary && call Api
                  updateProfil();
                  //Navigator.pop(context);
                },
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}
