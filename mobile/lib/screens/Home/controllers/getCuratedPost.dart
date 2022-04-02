import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/imports.dart';

class CuratedPostController extends GetxController {
  var curatedPost = [].obs;
  final Api _api = Api();
  int pageNo = 1;
  var isLoading = false.obs;
  var isCommentLoading = false.obs;
  int curatedNo = 2;
  List more = [];
  onInit() {
    getCuratedPosts();
    super.onInit();
  }

  // Future updatedb() async {
  //   try {
  //     while (curatedNo <= curatedPageNo) {
  //       List more = await _api.getCuratedPost(curatedNo);
  //       curatedPost.value.addAll(more);
  //       curatedNo++;
  //     }

  //     //  print(curatedPost.value[0]);
  //     update();
  //   } catch (e) {}
  // }

  Future getCuratedPosts() async {
    try {
      isCommentLoading.value = true;
      // var pageNum = 1;
      if (curatedPageNo == 1) {
        curatedPost.value = await _api.getCuratedPost(curatedPageNo);
       // curatedPageNo = curatedPageNo + 1;
      } else {
        curatedPost.value.clear();
        for (int i = 1; i <= curatedPageNo; i++) {
          more = await _api.getCuratedPost(i);
          more = await _api.getCuratedPost(i);
          print('before get cur${curatedPost.value.length}');
          curatedPost.value.addAll(more);
          print('after get cur${curatedPost.value.length}');
        }
      }

      //  print(curatedPost.value[0]);
      update();
    } catch (e) {
    } finally {
      isCommentLoading.value = false;
    }
  }

  Future getMoreCuratedPosts() async {
   curatedPageNo = curatedPageNo + 1;
    print('currentpageNoooooooooo${curatedPageNo}');
    isLoading.value = true;
    try {
      print("before");
      print(curatedPost.value.length);
      List more = await _api.getCuratedPost(curatedPageNo);
      if (more.isEmpty) {
        curatedPageNo = curatedPageNo - 1;
        print('currentpageNoooooooooo${curatedPageNo}');
      } else {
         // curatedPageNo = curatedPageNo + 1;
        print("addition");
        print(more.length);
        for (var i in more) {
          curatedPost.value.add(i);
        }
        print("after");
        print(curatedPost.value.length);
      }

      update();
      // curatedPost.refresh();

    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
