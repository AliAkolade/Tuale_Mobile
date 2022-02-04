import 'dart:developer';

import 'package:mobile/screens/imports.dart';

class Api {


 static String? currentUserId;
  Future<List> getVibingPost() async {
    int pageNo = 1;
    List posts = [];

    // Get Token
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get Posts
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response =
        await dio.get(hostAPI + getVibingPosts + pageNo.toString());
    log(response.data.toString());
    var responseData = response.data;
    List postsResponses = responseData['posts'];
    if (responseData['success'].toString() == 'true') {
      for (int i = 0; i < postsResponses.length; i++) {
        posts.add(PostDetails(
            userProfilePic: postsResponses[i]['user']['avatar']['url'],
            time: postsResponses[i]['createdAt'],
            postMedia: postsResponses[i]['media']['url'],
            postText: postsResponses[i]['caption'],
            noTuale: postsResponses[i]['tuales'].toList().length,
            noStar: postsResponses[i]['stars'].toList().length,
            noComment: postsResponses[i]['comments'].toList().length,
            username: postsResponses[i]['user']['username'], id: ''));
      }
    }

    return posts;
  }

  Future<UserPostDetails> getUserProfile(String username) async {
    // Get Token
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.get(hostAPI + userpost + username);


    // log(response.data.toString());
    var responseData = response.data;
 


    UserPostDetails info = UserPostDetails(

      id:responseData['profile']['_id'].toString(), 
      avatar: responseData['profile']['user']['avatar']['url'].toString(),
      name: responseData['profile']['user']['name'].toString(),
      username: responseData['profile']['user']['username'].toString(),
      fans: responseData['fansLength'].toString(),
      tualegiven: responseData['givenTuales'].toString(),
      friends: responseData['friendsLength'].toString(),
    );
    
    // if (responseData['success'].toString() == 'true') {
    //   for (int i = 0; i < postsResponses.length; i++) {

    //   }

    // }

    return info;
  }

    Future getCurrentUserId () async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
 
    Response currentUser = await dio.get(hostAPI + currentuser );

    // log(response.data.toString());
    
   currentUserId = currentUser.data['user']["_id"].toString();


      return currentUserId;

  }

}
