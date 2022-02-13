import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile/screens/imports.dart';

class PaymentReqController extends GetxController {
  String accessCode = '';
  String reference = '';

  final Api _api = Api();

  Future<List<String?>> getAccessCode(amount) async {
    var req = await _api.getAccessCode(amount);

    return req;
  }
}
