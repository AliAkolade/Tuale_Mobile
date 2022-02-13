import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/imports.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profileInfo = UserPostDetails(
    id : "",
   avatar: '',
    name: "",
    username: '',
    fans: '',
   friends: "",
    tualegiven : "",
   tcBalance : "",
    withdrawalBalance : '',
   email: ''
  ).obs;
  final Api _api = Api();

  @override
  onInit() {
    getProfileInfo(currentUsername);
    super.onInit();
  }

  // Rx<UserPostDetails> get profileInfo => _profileInfo;

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
      });

      profileInfo.refresh();
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
