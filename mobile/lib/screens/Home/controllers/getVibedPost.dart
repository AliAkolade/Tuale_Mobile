import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/imports.dart';

class VibedPostController extends GetxController {
  var vibePost = [].obs;

  final Api _api = Api();

  Future getVibedPosts() async {
    try {
      vibePost.value = await _api.getVibingPost();
      print(vibePost.value[0]);
    } catch (e) {
    }
   
  }
}
