import 'dart:developer';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mobile/models/currentUserdetails.dart';
import 'package:mobile/screens/Home/models/notificationsModel.dart';
import 'package:mobile/models/searchData.dart';
import 'package:mobile/screens/Discover/models/searchresultController.dart';
import 'package:mobile/screens/Home/models/postsetails.dart';
//import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/screens/Profile/models/UserPost.dart';
import 'package:mobile/screens/imports.dart';

class Api {
  static String? currentUserId;
  static String? currentUserUsername;

  String? accessCode;
  String? reference;
  String? tcpoints = '10';

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
            username: postsResponses[i]['user']['username'],
            id: ''));
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
      id: responseData['profile']['user']['_id'].toString(),
      avatar: responseData['profile']['user']['avatar']['url'].toString(),
      name: responseData['profile']['user']['name'].toString(),
      username: responseData['profile']['user']['username'].toString(),
      fans: responseData['fansLength'].toString(),
      tualegiven: responseData['givenTuales'].toString(),
      friends: responseData['friendsLength'].toString(),
      tcBalance: responseData['profile']['user']['tcBalance'].toString(),
      withdrawalBalance:
          responseData['profile']['user']['walletBalance'].toString(),
      email: responseData['profile']['user']['email'].toString(),
      starredPosts: responseData['profile']['staredPosts'],
    );

    // if (responseData['success'].toString() == 'true') {
    //   for (int i = 0; i < postsResponses.length; i++) {

    //   }

    // }

    return info;
  }

  Future<CurrentUserDetails> getCurrentUserId() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;

    Response currentUser = await dio.get(hostAPI + currentuser);

    if (currentUser.statusCode == 200) {
      CurrentUserDetails loggedUser = CurrentUserDetails(
        currentuserid: currentUser.data['user']["_id"].toString(),
        currentUserUsername: currentUser.data['user']["username"].toString(),
        unreadNotifications:
            currentUser.data['user']["name"].toString() == 'true'
                ? true
                : false,
      );

      return loggedUser;
    }

    return CurrentUserDetails();
  }

  Future<List<String?>> getAccessCode(amount) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;

    Response response = await dio.get(hostAPI + payment + amount);

    accessCode = response.data["access_code"];
    reference = response.data["reference"];
    var req = [accessCode, reference];

    return req;
  }

  Future verifyTransaction(String reference) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;

    Response response =
        await dio.put(hostAPI + verify, data: {'reference': reference});

    if (response.statusCode == 200) {
      // print(response.data);
      print("Payment verified");
    } else {
      print('error');
    }
  }

  Future<List<SearchResultModel>> getSearchResults(searchItem) async {
    List<SearchResultModel> searchResult = [];
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;

    Response response = await dio.get(hostAPI + search + searchItem);
    List responseData = response.data['results'];

    if (response.data['success'].toString() == 'true') {
      for (var i = 0; i < responseData.length; i++) {
        searchResult.add(SearchResultModel(
          avatar: responseData[i]['avatar']['url'],
          name: responseData[i]['name'],
          usernames: responseData[i]['username'],
          isVerified: responseData[i]['isVerified'] == 'true' ? true : false,
        ));
      }
    }
    return searchResult;
  }

  Future<List<UserPost>> getUserProfilePosts(String username) async {
    // Get Token
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.get(hostAPI + profilepost + username);
    List<UserPost> result = [];

    // log(response.data.toString());
    var responseData = response.data;
    print(responseData);

    if (response.data['success'].toString() == 'true') {
      for (var i = 0; i < responseData['posts'].length; i++) {
        result.add(UserPost(postUrl: responseData['posts'][i]['media']['url']));
      }
    }

    // if (responseData['success'].toString() == 'true') {
    //   for (int i = 0; i < postsResponses.length; i++) {

    //   }

    // }

    return result;
  }

  Future<List<NotificationModel>> getNotifications() async {
    // Get Token
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.get(hostAPI + notifications);
    var responseData = response.data;
    List<NotificationModel> notification = [];
    print(responseData);
    if (response.data['success'].toString() == 'true') {
      for (var i = 0; i < responseData['notifications'].length; i++) {
        print(i);
        notification.add(NotificationModel(
            type: responseData['notifications'][i]['type'],
            username: responseData['notifications'][i]['user']['username'],
            likedPost: responseData['notifications'][i]['type'] == 'newFan' ? "" :  responseData['notifications'][i]['post']['media']['url'] ,
            mediaType: responseData['notifications'][i]['type'] == 'newFan' ? '' : responseData['notifications'][i]['post']['mediaType'] ,
            id: responseData['notifications'][i]['type'] == 'newFan' ? '' : responseData['notifications'][i]['post']['_id'] 
            
            ));
      }
    }
    print(notification.length);
    return notification;
  }

  Future<PostDetails> getOnePost(String id) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';
    PostDetails details = PostDetails(
      noComment: 0,
      noStar: 0,
      noTuale: 0,
      username: '',
      id: "",
      postText: '',
      postMedia: '',
      time: '',
      userProfilePic: '',
    );

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.get(hostAPI + 'post/' + id);

    if (response.statusCode == 200) {
      var responseData = response.data;
      PostDetails details = PostDetails(
          userProfilePic: responseData['post']['user']['avatar']['url'],
          time: responseData['post']['user']['createdAt'],
          postMedia: responseData['post']['media']['url'],
          postText: responseData['post']['caption'],
          noTuale: responseData['post']['tuales'].toList().length,
          noStar: responseData['post']['stars'].toList().length,
          noComment: responseData['post']['comments'].toList().length,
          username: responseData['post']['user']['username'],
          id: responseData['post']['user']['_id']);
    }
    return details;
  }
}
