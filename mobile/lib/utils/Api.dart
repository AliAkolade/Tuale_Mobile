import 'dart:developer';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mobile/models/currentUserdetails.dart';
import 'package:mobile/models/searchData.dart';
import 'package:mobile/screens/Discover/models/searchresultController.dart';
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
    );

    // if (responseData['success'].toString() == 'true') {
    //   for (int i = 0; i < postsResponses.length; i++) {

    //   }

    // }

    return info;
  }

  Future getCurrentUserId() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;

    Response currentUser = await dio.get(hostAPI + currentuser);

    // log(response.data.toString());

    currentUserId = currentUser.data['user']["_id"].toString();

    return currentUserId;
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
}
