import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/utils/Api.dart';
//import 'package:mobile/screens/imports.dart';

class OnePostController extends GetxController {
  String? id;
  OnePostController({this.id});
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
    tuales: [],
    stars: [],
    isVerified: false,
    isTualed: false,
    isStared: false,
    mediaType: '',
    comment: [], userId: '',
  ).obs;
  final Api _api = Api();
  var isLoading = true.obs;

  @override
  onInit() {
    getOnePost(id!);
    super.onInit();
  }

  getOnePost(String id) async {
    try {
      PostDetails details = await _api.getOnePost(id);

      postdetails.update((postdetails) {
        postdetails!.id = details.id;
        postdetails.username = details.username;
        postdetails.userProfilePic = details.userProfilePic;
        postdetails.noComment = details.noComment;
        postdetails.noStar = details.noStar;
        postdetails.noTuale = details.noTuale;
        postdetails.isStared = details.isStared;
        postdetails.isTualed = details.isTualed;
        postdetails.postMedia = details.postMedia;
        postdetails.time = details.time;
           postdetails.comment = details.comment;
            postdetails.userId = details.userId;
        postdetails.postText = details.postText;
      });
      print('nostarcontrol${postdetails.value.noStar}');
      postdetails.refresh();
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
