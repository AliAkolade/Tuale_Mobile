//viewing user postdetails model

import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/screens/Profile/controllers/profileController.dart';
import 'package:mobile/screens/Profile/models/starredPostmodel.dart';

class UserPostDetails {
  String? id;
  String? avatar;
  String? name;
  String? username;
  int? fans;
  int? friends;
  String? tualegiven;
  String? tcBalance;
  String? withdrawalBalance;
  String? email;
  List<starredPostModel>? starredPosts;
  String? bio;
  String? location;

  UserPostDetails(
      {this.id = "",
      this.starredPosts,
      this.avatar =
          "https://res.cloudinary.com/indersingh/image/upload/v1593464618/App/user_mklcpl.png",
      this.name = "",
      this.username = '',
      this.fans = 0,
      this.friends = 0,
      this.tualegiven = "",
      this.tcBalance = "",
      this.withdrawalBalance = '',
      this.email = '', 
      this.bio = '',
      this.location = ''

      });
}
