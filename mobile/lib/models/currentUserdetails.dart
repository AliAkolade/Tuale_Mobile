import 'package:mobile/screens/imports.dart';

class CurrentUserDetails {
  String? currentuserid;
  String? currentuserAvatarUrl;
  String? currentuserAvatarPublicId;
  String? currentuserName;
  String? currentUserUsername;
  String? currentuserBio;
  bool? unreadNotifications;
  List? friends;

  CurrentUserDetails({
      this.friends,
      this.currentuserid = '',
      this.currentuserAvatarUrl = '',
      this.currentuserAvatarPublicId = '',
      this.currentuserName = '',
      this.currentUserUsername = '',
      this.currentuserBio = '',
      this.unreadNotifications = false
  });
}
