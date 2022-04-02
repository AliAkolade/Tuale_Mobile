import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/imports.dart';

class VibedPostController extends GetxController {
  var vibePost = [].obs;
  List more = [];

  final Api _api = Api();

  Future getVibedPosts() async {
    try {
      // var pageNum = 1;
      if (vibingPageNo == 1) {
        vibePost.value = await _api.getVibingPost(curatedPageNo);
         vibingPageNo = vibingPageNo + 1;
      } else {
        vibePost.value.clear();
        for (int i = 1; i <= vibingPageNo; i++) {
          more = await _api.getCuratedPost(i);
          print('before get cur${vibePost.value.length}');
          vibePost.value.addAll(more);
          print('after get cur${vibePost.value.length}');
        }
      }

      //  print(curatedPost.value[0]);
      update();
    } catch (e) {}
  }

  Future getMoreVibePosts() async {
   // vibingPageNo = vibingPageNo + 1;
    print('currentpageNoooooooooo${vibingPageNo}');

    try {
      print("before");
      print(vibePost.value.length);
      List more = await _api.getVibingPost(vibingPageNo);
      if (more.isEmpty) {
        vibingPageNo = vibingPageNo - 1;
        print('currentpageNoooooooooo${vibingPageNo}');
      } else {
       vibingPageNo = vibingPageNo + 1;
        print("addition");
        print(more.length);
        for (var i in more) {
          vibePost.value.add(i);
        }
        print(vibingPageNo);
        print("after");
        print(vibePost.value.length);
      }

      update();
      // curatedPost.refresh();

    } catch (e) {
    } finally {}
  }
}
