import 'package:mobile/screens/imports.dart';

class CurrentUserDetails {
  String? currentuserid;
  String? currentUserUsername;
  bool? unreadNotifications;
  List? friends;

  CurrentUserDetails(
      {
        this.friends,
        this.currentuserid = '',
      this.currentUserUsername = '',
      this.unreadNotifications = false});
}
