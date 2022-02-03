import 'dart:developer';


import 'package:mobile/screens/imports.dart';



class Api {
      Future <List> getVibingPost() async{

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
              username: postsResponses[i]['user']['username']));
       
      }
     
   
    }


 return posts;

      }


  Future  getUserProfile( String username) async {

       // Get Token
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response =
        await dio.get(hostAPI + userpost + username);
   // log(response.data.toString());
    var responseData = response.data;
     
    UserPostDetails info = UserPostDetails(
       avatar: responseData['profile']['user']['avatar']['url'].toString(), 
       name: responseData['profile']['user']['name'].toString(), 
        username: responseData['profile']['user']['username'].toString(), 
          fans: responseData['followersLength'].toString(), 
           tualegiven: responseData['givenTuales'].toString(), 

     );
     print(info.avatar);

    // if (responseData['success'].toString() == 'true') {
    //   for (int i = 0; i < postsResponses.length; i++) {
       
       
    //   }
     
   
    // }





  }




}

