//viewing user postdetails model

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

  UserPostDetails(
      {this.id = "",
      this.avatar = "https://res.cloudinary.com/indersingh/image/upload/v1593464618/App/user_mklcpl.png",
      this.name = "",
      this.username = '',
      this.fans = 0,
      this.friends = 0,
      this.tualegiven = "",
      this.tcBalance = "",
      this.withdrawalBalance = '',
      this.email = ''});
}
