import 'dart:convert';
import 'dart:developer';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/models/currentUserdetails.dart';
import 'package:mobile/screens/Home/models/notificationsModel.dart';

import 'package:mobile/screens/Discover/models/searchresultController.dart';
import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/screens/Profile/controllers/profileController.dart';
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
  //  log(response.data.toString());
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
            id: postsResponses[i]['_id'],
            tuales: postsResponses[i]['tuales'],
            stars: postsResponses[i]['stars'],
            isTualed: checkGivingTuale(postsResponses[i]['tuales']),
            isStared: checkGivingStar(postsResponses[i]['stars']),
            mediaType: postsResponses[i]['mediaType']
        ));
      }
    }

    return posts;
  }

  Future<List> getCuratedPost() async {
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
        await dio.get(hostAPI + getAllPosts + pageNo.toString());
  //  log(response.data.toString());
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
            id: postsResponses[i]['_id'],
            tuales: postsResponses[i]['tuales'],
            stars: postsResponses[i]['stars'],
            isTualed: checkGivingTuale(postsResponses[i]['tuales']),
            isStared:  checkGivingStar(postsResponses[i]['stars']),
            mediaType: postsResponses[i]['mediaType']
        ));
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
    List starredPost = [];
    // log(response.data.toString());
    var responseData = response.data;
    print(responseData);
    List getList() {
      for (var i in responseData['profile']['staredPosts']) {
        starredPost.add(i['post']['media']['url']);
      }
      return starredPost;
    }

    getList();
    UserPostDetails info = UserPostDetails(
      id: responseData['profile']['user']['_id'].toString(),
      avatar: responseData['profile']['user']['avatar']['url'].toString(),
      name: responseData['profile']['user']['name'].toString(),
      username: responseData['profile']['user']['username'].toString(),
      fans: responseData['fansLength'],
      tualegiven: responseData['givenTuales'].toString(),
      friends: responseData['friendsLength'],
      tcBalance: responseData['profile']['user']['tcBalance'].toString(),
      withdrawalBalance:
          responseData['profile']['user']['walletBalance'].toString(),
      email: responseData['profile']['user']['email'].toString(),
      starredPosts: getList(),
    );

    // if (responseData['success'].toString() == 'true') {
    //   for (int i = 0; i < postsResponses.length; i++) {

    //   }

    // }
    print(info.starredPosts);
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
          friends: currentUser.data['userFollowStats']["friends"]);

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
    //  print(responseData);

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
    //  print(responseData);
    if (response.data['success'].toString() == 'true') {
      for (var i = 0; i < responseData['notifications'].length; i++) {
        //   print(i);
        notification.add(NotificationModel(
            type: responseData['notifications'][i]['type'],
            username: responseData['notifications'][i]['user']['username'],
            likedPost: responseData['notifications'][i]['type'] == 'newFan'
                ? ""
                : responseData['notifications'][i]['post']['media']['url'],
            mediaType: responseData['notifications'][i]['type'] == 'newFan'
                ? ''
                : responseData['notifications'][i]['post']['mediaType'],
            id: responseData['notifications'][i]['type'] == 'newFan'
                ? ''
                : responseData['notifications'][i]['post']['_id']));
      }
    }
    // print(notification.length);
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
      tuales: [],
      stars: [],
      isTualed: false,
      isStared: false,
      mediaType: ''
    );

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.get(hostAPI + 'post/' + id);

    if (response.statusCode == 200) {
      //  print(response.data);
      var responseData = response.data;
      details = PostDetails(
          userProfilePic: responseData['post']['user']['avatar']['url'],
          time: responseData['post']['user']['createdAt'],
          postMedia: responseData['post']['media']['url'],
          postText: responseData['post']['caption'],
          noTuale: responseData['post']['tuales'].toList().length,
          noStar: responseData['post']['stars'].toList().length,
          noComment: responseData['post']['comments'].toList().length,
          username: responseData['post']['user']['username'],
          id: responseData['post']['user']['_id'],
          tuales: responseData['post']['tuales'],
          stars: responseData['post']['stars'],
          isTualed: checkGivingTuale(responseData['post']['tuales']),
          isStared: checkGivingStar(responseData['post']['stars']),
          mediaType: responseData['post']['mediaType']
      );
    }

    return details;
  }

  Future setNotificationToRead() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.post(hostAPI + vibing);

    // print(response.data);
  }

  Future vibeWithUser(String id, String username, String tag) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.post(hostAPI + vibing + id);
    if (response.statusCode == 200) {
      Get.find<ProfileController>(tag: tag).getProfileInfo(username);
      Get.find<LoggedUserController>().getLoggeduser();
      Get.put<ProfileController>(
              ProfileController(
                  controllerusername: Get.find<LoggedUserController>()
                      .loggedUser
                      .value
                      .currentUserUsername!),
              tag: 'myprofile')
          .getProfileInfo(Get.find<LoggedUserController>()
              .loggedUser
              .value
              .currentUserUsername!);
    }
  }

  Future unvibeWithUser(String id, String username, String tag) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.put(hostAPI + unvibing + id);
    if (response.statusCode == 200) {
      Get.find<ProfileController>(tag: tag).getProfileInfo(username);
      Get.find<LoggedUserController>().getLoggeduser();
      Get.put<ProfileController>(
              ProfileController(
                  controllerusername: Get.find<LoggedUserController>()
                      .loggedUser
                      .value
                      .currentUserUsername!),
              tag: 'myprofile')
          .getProfileInfo(Get.find<LoggedUserController>()
              .loggedUser
              .value
              .currentUserUsername!);
    }
  }

  addTuale(String id) async {
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      String token = prefs.getString('token') ?? '';

      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      Response response = await dio.post(hostAPI + 'post/tuale/' + id);
      var responseData = response.data;
      if (response.statusCode == 200) {
        return [responseData["success"],responseData["message"]];
      }
    } catch (e) {
      return [false,"Something got wrong"];
    }
    return [false,"Oh why??"];
  }

  startPost(String id) async {
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      String token = prefs.getString('token') ?? '';

      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      Response response = await dio.post(hostAPI + 'post/star/' + id);
      var responseData = response.data;
      if (response.statusCode == 200) {
        return [responseData["success"],responseData["message"]];
      }
    } catch (e) {
      return [false,"Something got wrong"];
    }
    return [false,"Oh why??"];
  }

  unStartPost(String id) async {
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      String token = prefs.getString('token') ?? '';

      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      Response response = await dio.put(hostAPI + 'post/unstar/' + id);
      var responseData = response.data;
      if (response.statusCode == 200) {
        return [responseData["success"],responseData["message"]];
      }
    } catch (e) {
      return [false,"Something got wrong"];
    }
    return [false,"Oh why??"];
  }

  checkGivingTuale(tuales) {
    // return true if user already give tuale
    var userId =  Get.find<LoggedUserController>().loggedUser.value.currentuserid;
    if(tuales.length == 0 ) {
      debugPrint('test1  : $tuales');
      return false;
    }
    else{
      if (tuales.any((item) => item["user"] ==  userId)) {
        return true;
      }
      return false;
      /*for (int i = 0; i < tuales.length; i++) {
        if(userId  == tuales[i]["user"]) return true;
        return false;
      }*/
    }
  }

  checkGivingStar(stars) {
    // return true if user already give star
    var userId =  Get.find<LoggedUserController>().loggedUser.value.currentuserid;
    if(stars.length == 0 ) {
      debugPrint('star-test');
      return false;
    }
    else{
      if (stars.any((item) => item["user"] ==  userId)) {
        return true;
      }
      return false;
    }
  }
}
