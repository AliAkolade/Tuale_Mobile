import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/imports.dart';

class CuratedPostController extends GetxController {
  var curatedPost = [].obs;
  final Api _api = Api();

  Future getCuratedPosts() async {
    try {
  curatedPost.value = await _api.getCuratedPost();
   print(curatedPost.value[0]);
      
    } catch (e) {
    }
   
  }
}
