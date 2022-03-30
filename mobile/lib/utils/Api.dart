import 'dart:convert';
import 'dart:developer';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile/controller/loggedUserController.dart';
import 'package:mobile/models/currentUserdetails.dart';
import 'package:mobile/screens/Home/controllers/getCuratedPost.dart';
import 'package:mobile/screens/Home/controllers/getVibedPost.dart';
import 'package:mobile/screens/Home/models/notificationsModel.dart';

import 'package:mobile/screens/Discover/models/searchresultController.dart';
import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/screens/Leaderboard/models/leaderboardmodel.dart';
import 'package:mobile/screens/Profile/controllers/profileController.dart';
//import 'package:mobile/screens/Home/models/postsetails.dart';
import 'package:mobile/screens/Profile/models/UserPost.dart';
import 'package:mobile/screens/Profile/models/starredPostmodel.dart';
import 'package:mobile/screens/imports.dart';

class Api {
  static String? currentUserId;
  static String? currentUserUsername;

  String? accessCode;
  String? reference;
  String? tcpoints = '10';

  Future<List> getVibingPost(int pageNo) async {
    // int pageNo = 1;
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
            postText: postsResponses[i]['caption'] ?? "",
            noTuale: postsResponses[i]['tuales'].toList().length,
            noStar: postsResponses[i]['stars'].toList().length,
            noComment: postsResponses[i]['comments'].toList().length,
            username: postsResponses[i]['user']['username'],
            id: postsResponses[i]['_id'],
            tuales: postsResponses[i]['tuales'],
            stars: postsResponses[i]['stars'],
            comment: postsResponses[i]['comments'],
            isVerified: postsResponses[i]['user']['verified'],
            isTualed: checkGivingTuale(postsResponses[i]['tuales']),
            isStared: checkGivingStar(postsResponses[i]['stars']),
            mediaType: postsResponses[i]['mediaType'],
            userId: postsResponses[i]['user']['_id']));
      }
    }

    return posts;
  }

  Future<List> getCuratedPost(int pageNo) async {
    // int pageNo = 2;
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
    // debugPrint("before : $postsResponses");
    // log(postsResponses.toString());
    if (responseData['success'].toString() == 'true') {
      for (int i = 0; i < postsResponses.length; i++) {
        posts.add(PostDetails(
            userId: postsResponses[i]['user']['_id'],
            userProfilePic: postsResponses[i]['user']['avatar']['url'],
            time: postsResponses[i]['createdAt'],
            postMedia: postsResponses[i]['media']['url'],
            postText: postsResponses[i]['caption'] ?? "",
            noTuale: postsResponses[i]['tuales'].toList().length,
            noStar: postsResponses[i]['stars'].toList().length,
            noComment: postsResponses[i]['comments'].toList().length,
            username: postsResponses[i]['user']['username'],
            id: postsResponses[i]['_id'],
            tuales: postsResponses[i]['tuales'],
            stars: postsResponses[i]['stars'],
            comment: postsResponses[i]['comments'],
            isVerified: postsResponses[i]['user']['verified'],
            isTualed: checkGivingTuale(postsResponses[i]['tuales']),
            isStared: checkGivingStar(postsResponses[i]['stars']),
            mediaType: postsResponses[i]['mediaType']));
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
    List<starredPostModel> starredPost = [];
    // log(response.data.toString());
    var responseData = response.data;
    print(responseData);

    List<starredPostModel> getList() {
      for (var i in responseData['profile']['staredPosts']) {
        starredPost.add(starredPostModel(
            url: i['post']['media']['url'],
            mediaType: i['post']['mediaType'],
            id: i['post']['_id']));
      }
      debugPrint('starredpost $starredPost');
      return starredPost;
    }

    UserPostDetails info = UserPostDetails(
        id: responseData['profile']['user']['_id'].toString(),
        avatar: responseData['profile']['user']['avatar']['url'].toString(),
        name: responseData['profile']['user']['name'].toString(),
        username: responseData['profile']['user']['username'].toString(),
        fans: responseData['fansLength'],
        tualegiven: responseData['givenTuales'].toString(),
        friends: responseData['friendsLength'],
        isVerified: responseData['profile']['user']['verified'],
        tcBalance: responseData['profile']['user']['tcBalance'].toString(),
        withdrawalBalance:
            responseData['profile']['user']['walletBalance'].toString(),
        email: responseData['profile']['user']['email'].toString(),
        starredPosts: getList(),
        location: responseData['profile']['user']['country'],
        bio: responseData['profile']['bio'] ?? '');

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
          currentuserAvatarUrl:
              currentUser.data['user']["avatar"]["url"].toString(),
          currentuserAvatarPublicId:
              currentUser.data['user']["avatar"]["public_id"].toString(),
          currentuserName: currentUser.data['user']["name"].toString(),
          currentuserBio: currentUser.data["bio"].toString(),
          currentUserUsername: currentUser.data['user']["username"].toString(),
          unreadNotifications: currentUser.data['user']["unreadNotification"],
          noTuales: currentUser.data['user']["tcBalance"],
          friends: currentUser.data['userFollowStats']["friends"]);

      print("notify${currentUser.data['user']['unreadNotification']}");
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
          isVerified: responseData[i]['verified'],
        ));
      }
    }
    return searchResult;
  }

  Future<List<PostDetails>> getUserProfilePosts(String username) async {
    // Get Token
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.get(hostAPI + profilepost + username);
    List<PostDetails> result = [];

    // log(response.data.toString());
    var responseData = response.data;
    //  print(responseData);

    if (response.data['success'].toString() == 'true') {
      for (var i = 0; i < responseData['posts'].length; i++) {
        List postsResponses = responseData['posts'];
        result.add(PostDetails(
            userProfilePic: postsResponses[i]['user']['avatar']['url'],
            time: postsResponses[i]['createdAt'],
            postMedia: postsResponses[i]['media']['url'],
            postText: postsResponses[i]['caption'] ?? "",
            noTuale: postsResponses[i]['tuales'].toList().length,
            noStar: postsResponses[i]['stars'].toList().length,
            noComment: postsResponses[i]['comments'].toList().length,
            username: postsResponses[i]['user']['username'],
            id: postsResponses[i]['_id'],
            tuales: postsResponses[i]['tuales'],
            stars: postsResponses[i]['stars'],
            comment: postsResponses[i]['comments'],
            isVerified: postsResponses[i]['user']['verified'],
            isTualed: checkGivingTuale(postsResponses[i]['tuales']),
            isStared: checkGivingStar(postsResponses[i]['stars']),
            mediaType: postsResponses[i]['mediaType'],
            userId: postsResponses[i]['user']['_id']));
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

    if (response.data['success'].toString() == 'true') {
      print(responseData);
      for (var i = 0; i < responseData['notifications'].length; i++) {
        // if (responseData['notifications'][i]['post'] != null) {
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
                ? responseData['notifications'][i]['user']['_id']
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
        comment: [],
        isVerified: false,
        isTualed: false,
        isStared: false,
        mediaType: '',
        userId: '');

    // Get userdetails
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.get(hostAPI + 'post/' + id);
    print(response.data);
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
          id: responseData['post']['_id'],
          tuales: responseData['post']['tuales'],
          stars: responseData['post']['stars'],
          comment: responseData['post']['comments'],
          isVerified: responseData['post']['user']['verified'],
          isTualed: checkGivingTuale(responseData['post']['tuales']),
          isStared: checkGivingStar(responseData['post']['stars']),
          mediaType: responseData['post']['mediaType'],
          userId: responseData['post']['user']['_id']);
    }

    return details;
  }

  Future setNotificationToRead() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.post(hostAPI + 'notifications');

    // print(response.data);
  }

  Future vibeWithUser(String id, String username) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.post(hostAPI + vibing + id);
    if (response.statusCode == 200) {
      Get.put<ProfileController>(
        ProfileController(controllerusername: username),
      ).getProfileInfo(username);
      Get.find<LoggedUserController>().getLoggeduser();
    }
  }

  Future unvibeWithUser(String id, String username) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token') ?? '';

    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    Response response = await dio.put(hostAPI + unvibing + id);
    if (response.statusCode == 200) {
      Get.put<ProfileController>(
        ProfileController(controllerusername: username),
      ).getProfileInfo(username);
      Get.find<LoggedUserController>().getLoggeduser();
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
        return [responseData["success"], responseData["message"]];
      }
    } catch (e) {
      return [false, "Something got wrong"];
    }
    return [false, "Oh why??"];
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
        return [responseData["success"], responseData["message"]];
      }
    } catch (e) {
      return [false, "Something got wrong"];
    }
    return [false, "Oh why??"];
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
        return [responseData["success"], responseData["message"]];
      }
    } catch (e) {
      return [false, "Something got wrong"];
    }

    return [false, "Something got wrong"];
  }

  makeNewPost(
      String mediaType, String publicId, String url, String description) async {
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      String token = prefs.getString('token') ?? '';

      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      Response response = await dio.post(hostAPI + 'post/create', data: {
        'mediaType': mediaType,
        'media': {'public_id': publicId, 'url': url},
        'caption': description
      });
      var responseData = response.data;
      debugPrint("responseData : $responseData");
      if (response.statusCode == 200) {
        if (responseData["success"]) {
          (mediaType == 'image')
              ? MixPanelSingleton.instance.mixpanel.track("PostImage",
                  properties: {'User': prefs.getString('username') ?? ''})
              : MixPanelSingleton.instance.mixpanel.track("PostVideo",
                  properties: {'User': prefs.getString('username') ?? ''});
          MixPanelSingleton.instance.mixpanel.flush();

          return [responseData["success"], "Your post has been added"];
        } else {
          return [responseData["success"], responseData["message"]];
        }
      }
    } catch (e) {
      return [false, "Something got wrong"];
    }
  }

  updateUserProfil(String username, String fullname, String bio,
      String publicId, String url) async {
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      String token = prefs.getString('token') ?? '';

      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      Response response = await dio.put(hostAPI + 'profile/update', data: {
        'username': username,
        'name': fullname,
        'bio': bio,
        'avatar': {'public_id': publicId, 'url': url},
      });
      var responseData = response.data;
      debugPrint("responseData : $responseData");
      if (response.statusCode == 200) {
        return [responseData["success"], responseData["message"]];
      }
    } catch (e) {
      return [false, "Something got wrong"];
    }
  }

  updateUserPwd(String currentPwd, String newPwd) async {
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      String token = prefs.getString('token') ?? '';

      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      Response response =
          await dio.post(hostAPI + 'profile/password/update', data: {
        'currentPassword': currentPwd,
        'newPassword': newPwd,
      });
      var responseData = response.data;
      debugPrint("responseData : $responseData");
      if (response.statusCode == 200) {
        if (responseData["success"]) {
          return [responseData["success"], "Your post has been updated"];
        } else {
          return [responseData["success"], responseData["message"]];
        }
      }
    } catch (e) {
      return [false, "Something got wrong"];
    }
  }

  checkGivingTuale(tuales) {
    // return true if user already give tuale

    var userId =
        Get.find<LoggedUserController>().loggedUser.value.currentuserid;
    if (tuales.length == 0) {
      debugPrint('test1  : $tuales');

      return false;
    } else {
      if (tuales.any((item) => item["user"] == userId)) {
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

    var userId =
        Get.find<LoggedUserController>().loggedUser.value.currentuserid;
    if (stars.length == 0) {
      debugPrint('star-test');

      return false;
    } else {
      if (stars.any((item) => item["user"] == userId)) {
        return true;
      }
      return false;
    }
  }

  commentOnAPost(String postId, String comment) async {
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      String token = prefs.getString('token') ?? '';

      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      Response response = await dio
          .post(hostAPI + 'post/comment/' + postId, data: {'text': comment});

      if (response.statusCode == 200) {
        if (response.data['success']) {
          return [response.data["success"], 'comment sent'];
        } else {
          return [response.data["succes"], 'failed to comment'];
        }
      }
    } catch (e) {}
  }

  whichController() {
    if (Get.isRegistered<CuratedPostController>()) {
      return Get.find<CuratedPostController>();
    } else {
      return Get.find<VibedPostController>();
    }
  }

  getleaderboard() async {
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      String token = prefs.getString('token') ?? '';
      List leaderboard = [];
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      Response response = await dio.get(hostAPI + 'leaderboard');
      var responseData = response.data;
      if (response.statusCode == 200) {
        print('heyyyy');
        print(responseData['leaderboard']);
        for (var i in responseData['leaderboard']) {
          //
          //  print(i);

          leaderboard.add(LeaderboardModel(
              name: i['user']['name'],
              username: i['user']['username'],
              avatar: i['user']['avatar']['url'],
              id: i['user']['_id'],
              isVerified: i['user']['verified'],
              noTuales: i['givenTuales']));
        }

        return leaderboard;
      } else {
        return [responseData["success"], responseData["message"]];
      }
    } catch (e) {
      return [false, "Something got wrong"];
    }

    return [false, "Something got wrong"];
  }
}
