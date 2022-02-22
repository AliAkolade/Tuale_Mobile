import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/Home/models/notificationsModel.dart';
import 'package:mobile/screens/imports.dart';

class NotificationsController extends GetxController {
  var notificationModel = <NotificationModel>[].obs;
  Api _api = Api();

  @override
  onInit() {
    getNewnotifications();
    super.onInit();
  }

  getNewnotifications() async {
    try {
      notificationModel.value = await _api.getNotifications();
      print(notificationModel.value[0].type);
    } catch (e) {
      print(e);
    } finally {}
  }
}
