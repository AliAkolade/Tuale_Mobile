import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/utils/Api.dart';
//import 'package:mobile/screens/imports.dart';

class OnePostController extends GetxController {
  var postdetails = PostDetails(
    noComment: 0,
    noStar: 0,
    noTuale: 0,
    username: '',
    id: "",
    postText: '',
    postMedia: '',
    time: '',
    userProfilePic: '',
  );
  final Api _api = Api();

  getOnePost(String id) async {
    try {
       postdetails = await _api.getOnePost(id);

      //  // postdetails.update((postdetails) {
      //     postdetails.id = details.id;
      //     postdetails.username = details.username;
      //     postdetails.userProfilePic = details.userProfilePic;
      //     postdetails.noComment = details.noComment;
      //     postdetails.noStar = details.noStar;
      //     postdetails.postMedia = details.postMedia;
      //     postdetails.time = details.time;
      //   });

      //postdetails.refresh();
      update();
    } catch (e) {}
  }
}
