import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/imports.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var friends = 0.obs;
  var fans = 0.obs;
  Color color = Colors.grey;
  var profileInfo = UserPostDetails().obs;
  final Api _api = Api();
  String? controllerusername;

  ProfileController({this.controllerusername});

  @override
  onInit() {
    getProfileInfo(controllerusername!);
    super.onInit();
  }

  @override
  void onClose() {
    // profileInfo.close();
    print("hello");
    super.onClose();
  }

  // Rx<UserPostDetails> get profileInfo => _profileInfo;

  delete() {
    profileInfo.value = UserPostDetails();
    update();
  }

  void vibeControll() {
    friends.value + 1;
  }

  void fansAdd() {
    fans.value + 1;
  }

  void vibeSub() {
    friends.value - 1;
  }

  void fansSub() {
    fans.value - 1;
  }

  void getProfileInfo(String username) async {
    try {
      isLoading.value = true;
      UserPostDetails user = await _api.getUserProfile(username);

      profileInfo.update((profileInfo) {
        profileInfo!.id = user.id;
        profileInfo.avatar = user.avatar;
        profileInfo.name = user.name;
        profileInfo.username = user.username;
        profileInfo.fans = user.fans;
        profileInfo.friends = user.friends;
        profileInfo.tualegiven = user.tualegiven;
        profileInfo.tcBalance = user.tcBalance;
        profileInfo.withdrawalBalance = user.withdrawalBalance;
        profileInfo.email = user.email;
        profileInfo.starredPosts = user.starredPosts;
        profileInfo.bio = user.bio;
        profileInfo.location = user.location;
        profileInfo.isVerified = user.isVerified;
        
      });
      ;
      // print(profileInfo.value.starredPosts);

      profileInfo.refresh();
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
      //update(['user']);
    }
  }

  // void getMyProfileInfo(String username) async {
  //   try {
  //     isLoading.value = true;
  //     UserPostDetails user = await _api.getUserProfile(username);

  //     profileInfo.update((profileInfo) {
  //       profileInfo!.id = user.id;
  //       profileInfo.avatar = user.avatar;
  //       profileInfo.name = user.name;
  //       profileInfo.username = user.username;
  //       profileInfo.fans = user.fans;
  //       profileInfo.friends = user.friends;
  //       profileInfo.tualegiven = user.tualegiven;
  //       profileInfo.tcBalance = user.tcBalance;
  //       profileInfo.withdrawalBalance = user.withdrawalBalance;
  //       profileInfo.email = user.email;
  //     });

  //     profileInfo.refresh();
  //   } catch (e) {
  //   } finally {
  //     isLoading.value = false;
  //     update(["myuser"]);
  //   }
  // }
}

// class MyProfileController extends GetxController {
//   var isLoading = true.obs;
//   var profileInfo = UserPostDetails().obs;
//   final Api _api = Api();

//   @override
//   onInit() {
//     getProfileInfo(currentUsername);
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     // profileInfo.close();
//     super.onClose();
//   }

//   // Rx<UserPostDetails> get profileInfo => _profileInfo;

//   void getProfileInfo(String username) async {
//     try {
//       isLoading.value = true;
//       UserPostDetails user = await _api.getUserProfile(username);

//       profileInfo.update((profileInfo) {
//         profileInfo!.id = user.id;
//         profileInfo.avatar = user.avatar;
//         profileInfo.name = user.name;
//         profileInfo.username = user.username;
//         profileInfo.fans = user.fans;
//         profileInfo.friends = user.friends;
//         profileInfo.tualegiven = user.tualegiven;
//         profileInfo.tcBalance = user.tcBalance;
//         profileInfo.withdrawalBalance = user.withdrawalBalance;
//         profileInfo.email = user.email;
//       });

//       profileInfo.refresh();
//     } catch (e) {
//     } finally {
//       isLoading.value = false;
//       update();
//     }
//   }
// }
