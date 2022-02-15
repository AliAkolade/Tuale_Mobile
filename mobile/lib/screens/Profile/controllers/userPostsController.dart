import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/Profile/models/UserPost.dart';
import 'package:mobile/screens/imports.dart';

class UserPostsController extends GetxController {
  var posts = <UserPost>[].obs;
  var isLoading = true.obs;
  final Api _api = Api();

  getProfilePosts(String username) async {
    try {
      posts.value = await _api.getUserProfilePosts(username);
    } catch (e) {
    } finally {
      isLoading.value = false;
     print(posts);
      update();
    }
  }
}
