import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/imports.dart';

class CuratedPostController extends GetxController {
  var curatedPost = [].obs;
  final Api _api = Api();
  int pageNo = 1;

  onInit() {
    getCuratedPosts();
    super.onInit();
  }

  Future getCuratedPosts() async {
    try {
      curatedPost.value = await _api.getCuratedPost(pageNo);
      //  print(curatedPost.value[0]);
      update();
    } catch (e) {}
  }

  Future getMoreCuratedPosts() async {
    try {
      print("before");
      print(curatedPost.value.length);
      List more = await _api.getCuratedPost(pageNo + 1);
      print("addition");
      print(more.length);
      for (var i in more) {
        curatedPost.value.add(i);
      }
      print("after");
      print(curatedPost.value.length);
      update();
      // curatedPost.refresh();

    } catch (e) {}
  }
}
