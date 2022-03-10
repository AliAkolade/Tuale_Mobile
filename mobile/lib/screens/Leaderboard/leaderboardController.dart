import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/screens/imports.dart';

class LeaderboardController extends GetxController {
  var leaderboard = [].obs;
  var isLoading = true.obs;
  final Api _api = Api();

  onInit() {
    getLeaderBoard();
    super.onInit();
  }

  getLeaderBoard() async {
    try {
      leaderboard.value = await _api.getleaderboard();
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    
    }
  }
}
