import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import "package:flutter/material.dart";
import 'package:mobile/utils/userposts.dart';
//
class Post {
  Future getPost() async {

 Map<String, String> requestHeaders = {
       'Content-type': 'application/json',
       'Accept': 'application/json',
       'authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2MWI0ZjM0MWE3OGExMTc3ZTQ5NzU5ZmEiLCJpYXQiOjE2NDA3OTE3NzcsImV4cCI6MTY0MTM5NjU3N30.WrYRlTiXjbDwgNSlG4aQC17Og7iYcRA4OB5D4e6vabo'
     };
  

  final response = await http.get(
    
    Uri.parse("https://tuale-mobile-api.herokuapp.com/api/v1/posts?pageNumber=1",),
    headers: requestHeaders
    
    ); 
    if (response.statusCode == 200) {
  final UserPosts userpost = userPostsFromJson(response.body);
    // ignore: avoid_print
    print (userpost);
    return userpost;   

}
else {
  // ignore: avoid_print
  print (response.statusCode);
}
}




}
//