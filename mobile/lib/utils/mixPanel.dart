import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:mobile/utils/secrets.dart';

class MixPanelSingleton {
  static MixPanelSingleton _instance = MixPanelSingleton._();

  MixPanelSingleton._();

  static MixPanelSingleton get instance => _instance;
  late Mixpanel mixpanel;
  String distinctId = '';

  void someMethod() {}

  Future<void> initMixpanel() async {
    mixpanel = await Mixpanel.init(mixPanelToken, optOutTrackingDefault: false);
    distinctId = await mixpanel.getDistinctId() ?? '';
    mixpanel.identify(distinctId);
  }
}
