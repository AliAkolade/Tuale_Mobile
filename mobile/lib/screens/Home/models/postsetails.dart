class PostDetails {
  final String id;
  final String username;
  final String userProfilePic;
  final String time;
  final String postMedia;
  final String postText;
  final int noTuale;
  final int noStar;
  final int noComment;

  const PostDetails(
      {required this.id,
      required this.userProfilePic,
      required this.time,
      required this.postMedia,
      required this.postText,
      required this.noTuale,
      required this.noStar,
      required this.noComment,
      required this.username});
}