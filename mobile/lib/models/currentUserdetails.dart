import 'package:mobile/screens/imports.dart';

class CurrentUserDetails {
  String? currentuserid;
  String? currentuserAvatar;
  String? currentuserName;
  String? currentUserUsername;
  bool? unreadNotifications;
  List? friends;

  CurrentUserDetails({
      this.friends,
      this.currentuserid = '',
      this.currentuserAvatar = '',
      this.currentuserName = '',
      this.currentUserUsername = '',
      this.unreadNotifications = false
  });
}
