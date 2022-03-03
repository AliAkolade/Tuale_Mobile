class PostDetails {
  String id;
  String username;
  String userProfilePic;
  String time;
  String postMedia;
  String postText;
  int noTuale;
  int noStar;
  int noComment;
  List tuales;
  List stars;
  bool isTualed;
  bool isStared;
  List? comment;

  PostDetails(
      {required this.id,
      required this.userProfilePic,
      required this.time,
      required this.postMedia,
      required this.postText,
      required this.noTuale,
      required this.noStar,
      required this.noComment,
      required this.username,
      required this.tuales,
      required this.stars,
      required this.isTualed,
      required this.isStared,
      required this.comment});
}
