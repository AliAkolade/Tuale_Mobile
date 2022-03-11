import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/models/currentUserdetails.dart';
import 'package:mobile/screens/imports.dart';

class LoggedUserController extends GetxController {
  var loggedUser = CurrentUserDetails().obs;
  final Api _api = Api();

  @override
  onInit() {
    getLoggeduser();
    super.onInit();
  }

  getLoggeduser() async {
    try {
      CurrentUserDetails user = await _api.getCurrentUserId();

      loggedUser.update((loggedUser) {
        loggedUser!.currentUserUsername = user.currentUserUsername;
        loggedUser.currentuserAvatarUrl = user.currentuserAvatarUrl;
        loggedUser.currentuserAvatarPublicId = user.currentuserAvatarPublicId;
        loggedUser.currentuserName = user.currentuserName;
        loggedUser.currentuserBio = user.currentuserBio;
        loggedUser.currentuserid = user.currentuserid;
        loggedUser.unreadNotifications = user.unreadNotifications;
        loggedUser.friends = user.friends;
        loggedUser.noTuales = user.noTuales;
      });

      loggedUser.refresh();
    } catch (e) {
      print(e);
    } finally {
      print(loggedUser.value.currentuserid);
      //update(['user']);
    }
  }
}
