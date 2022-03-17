import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile/screens/Discover/models/searchresultController.dart';
import 'package:mobile/screens/imports.dart';

class SearchController extends GetxController {
  var searchresult = <SearchResultModel>[];
  var isLoading = false.obs;

  Api _api = Api();

  void isEmpty() {
    searchresult.clear();
    print(searchresult);
    update();
  }

  void getSearch(String searchParam) async {
    try {
      isLoading.value = true;
      searchresult = await _api.getSearchResults(searchParam);
      update();
    } catch (e) {
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
