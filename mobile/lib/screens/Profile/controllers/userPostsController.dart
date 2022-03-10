import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/screens/Profile/models/UserPost.dart';
import 'package:mobile/screens/imports.dart';

class UserPostsController extends GetxController {
  var posts = <PostDetails>[].obs;
  var isLoading = true.obs;
  final Api _api = Api();
  String? username;
  UserPostsController({this.username});

  @override
  onInit() {
    getProfilePosts(username!);
    super.onInit();
  }

  getProfilePosts(String username) async {
    try {
      posts.value = await _api.getUserProfilePosts(username);
    } catch (e) {
         print(e);
    } finally {
   
      isLoading.value = false;

      // update();
    }
  }
}
