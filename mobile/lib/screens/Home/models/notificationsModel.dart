import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';

class NotificationModel {
  String? type;
  String? username;
  String? likedPost;
  String? mediaType;
  String? id;

  NotificationModel({this.type = '', this.username = '', this.likedPost = '', this.mediaType = '', this.id = ''});
}
