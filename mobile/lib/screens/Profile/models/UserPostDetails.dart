//viewing user postdetails model

class UserPostDetails {
  String? id;
  String? avatar;
  String? name;
  String? username;
  String? fans;
  String? friends;
  String? tualegiven;
  String? tcBalance;
  String? withdrawalBalance;
  String? email;

  UserPostDetails(
      {this.id = "",
      this.avatar = '',
      this.name = "",
      this.username = '',
      this.fans = '',
      this.friends = "",
      this.tualegiven = "",
      this.tcBalance = "",
      this.withdrawalBalance = '',
      this.email = ''});
}
