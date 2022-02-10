//viewing user postdetails model

class UserPostDetails {
  final String? id;
  final String? avatar;
  final String? name;
  final String? username;
  final String? fans;
  final String? friends;
  final String? tualegiven;
  final String? tcBalance;
  final String? withdrawalBalance;

  UserPostDetails(
      {
        this.tcBalance,
        this.withdrawalBalance,
        this.id,
      this.avatar,
      this.name,
      this.username,
      this.fans,
      this.friends,
      this.tualegiven});
}
