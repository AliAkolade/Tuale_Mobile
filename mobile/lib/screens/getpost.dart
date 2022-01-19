import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import "package:flutter/material.dart";
import 'package:mobile/utils/userposts.dart';
import 'dart:convert';
//
class Post {

  Dio dio = Dio();

 Future getPost() async {

// Dio dio = new Dio();
dio.options.headers['content-Type'] = 'application/json';
dio.options.headers["authorization"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2MWQ5YTUyODcwYjEyZTFiMjZkOTQ2ZTMiLCJpYXQiOjE2NDIzNzg5MDUsImV4cCI6MTY0Mjk4MzcwNX0.gC7yLdgey1DHIXAuoca873EKUJDhZjbKImQ_IWWN7Wo";
var response = await dio.get("https://tuale-mobile-api.herokuapp.com/api/v1/posts?pageNumber=1");      

  
    if (response.statusCode == 200) {


  final Feed userpost = feedFromJson(response.data);
    // ignore: avoid_print
    print (userpost.posts);
   // return userpost;   

}
else {
  // ignore: avoid_print
  print (response.statusCode);
}
}




}
//