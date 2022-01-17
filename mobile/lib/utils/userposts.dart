// To parse this JSON data, do
//
//     final userPosts = userPostsFromJson(jsonString);

import 'dart:convert';

UserPosts userPostsFromJson(String str) => UserPosts.fromJson(json.decode(str));

String userPostsToJson(UserPosts data) => json.encode(data.toJson());

class UserPosts {
    UserPosts({
        this.success,
        this.posts,
    });

    bool? success;
    List<Post>? posts;

    factory UserPosts.fromJson(Map<String, dynamic> json) => UserPosts(
        success: json["success"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
    };
}

class Post {
    Post({
        this.media,
        this.id,
        this.user,
        this.caption,
        this.tuales,
        this.stars,
        this.comments,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    Media? media;
    String? id;
    User? user;
    String? caption;
    List<dynamic>? tuales;
    List<dynamic>? stars;
    List<dynamic>? comments;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        media: Media.fromJson(json["media"]),
        id: json["_id"],
        user: User.fromJson(json["user"]),
        caption: json["caption"],
        tuales: List<dynamic>.from(json["tuales"].map((x) => x)),
        stars: List<dynamic>.from(json["stars"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "media": media!.toJson(),
        "_id": id,
        "user": user!.toJson(),
        "caption": caption,
        "tuales": List<dynamic>.from(tuales!.map((x) => x)),
        "stars": List<dynamic>.from(stars!.map((x) => x)),
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

class Media {
    Media({
        this.publicId,
        this.url,
    });

    String? publicId;
    String? url;

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        publicId: json["public_id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "public_id": publicId,
        "url": url,
    };
}

class User {
    User({
        this.avatar,
        this.tcBalance,
        this.id,
        this.name,
        this.dateOfBirth,
        this.email,
        this.username,
        this.phoneNumber,
        this.interests,
        this.unreadMessage,
        this.unreadNotification,
        this.verified,
        this.walletBalance,
        this.tpBalance,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.expiretoken,
        this.resettoken,
    });

    Media? avatar;
    int? tcBalance;
    String? id;
    String? name;
    DateTime? dateOfBirth;
    String? email;
    String? username;
    String? phoneNumber;
    List<dynamic>? interests;
    bool? unreadMessage;
    bool? unreadNotification;
    bool? verified;
    int? walletBalance;
    int? tpBalance;
    String? role;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    DateTime? expiretoken;
    String? resettoken;

    factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: Media.fromJson(json["avatar"]),
        tcBalance: json["tcBalance"],
        id: json["_id"],
        name: json["name"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        email: json["email"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
        interests: List<dynamic>.from(json["interests"].map((x) => x)),
        unreadMessage: json["unreadMessage"],
        unreadNotification: json["unreadNotification"],
        verified: json["verified"],
        walletBalance: json["walletBalance"],
        tpBalance: json["tpBalance"],
        role: json["role"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        expiretoken: DateTime.parse(json["expiretoken"]),
        resettoken: json["resettoken"],
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar!.toJson(),
        "tcBalance": tcBalance,
        "_id": id,
        "name": name,
        "dateOfBirth": dateOfBirth!.toIso8601String(),
        "email": email,
        "username": username,
        "phoneNumber": phoneNumber,
        "interests": List<dynamic>.from(interests!.map((x) => x)),
        "unreadMessage": unreadMessage,
        "unreadNotification": unreadNotification,
        "verified": verified,
        "walletBalance": walletBalance,
        "tpBalance": tpBalance,
        "role": role,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "expiretoken": expiretoken!.toIso8601String(),
        "resettoken": resettoken,
    };
}
