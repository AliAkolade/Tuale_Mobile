import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/imports.dart';

class CuratedPostController extends GetxController {
  var curatedPost = [].obs;
  final Api _api = Api();
  int pageNo = 1;
  var isLoading = false.obs;
  int curatedNo = 2;
  onInit() {
    getCuratedPosts();
    super.onInit();
  }

  Future updatedb() async {
    try {
      while (curatedNo <= curatedPageNo) {
        List more = await _api.getCuratedPost(curatedNo);
        curatedPost.value.addAll(more);
        curatedNo++;
      }

      //  print(curatedPost.value[0]);
      update();
    } catch (e) {}
  }

  Future getCuratedPosts() async {
    try {
      curatedPost.value = await _api.getCuratedPost(1);
      //  print(curatedPost.value[0]);
      update();
    } catch (e) {}
  }

  Future getMoreCuratedPosts() async {
    curatedPageNo = curatedPageNo + 1;

    isLoading.value = true;
    try {
      print("before");
      print(curatedPost.value.length);
      List more = await _api.getCuratedPost(curatedPageNo);
      print("addition");
      print(more.length);
      for (var i in more) {
        curatedPost.value.add(i);
      }
      print("after");
      print(curatedPost.value.length);
      update();
      // curatedPost.refresh();

    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
