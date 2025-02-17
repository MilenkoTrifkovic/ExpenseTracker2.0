import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class BackendService {
  static Future<String> getUserRecords() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    // print("this is a token $token");

    final headers = {
      'Content-Type': 'application/json', // Specifies the content type
      if (token != null) 'Authorization': token, // Adds an auth token if needed
    };

    // Make a GET request with headers
    final response = await http.post(
        // Uri.parse('https://vital-range-448621-q8.uc.r.appspot.com/getUserRecords'),//Android Emulator requires 10.0.2.2 format
        Uri.parse('http://localhost:8080/user/getUserRecords'),//Android Emulator requires 10.0.2.2 format
        headers: headers);
      print(response.body);
      return response.body;
      // throw Exception("Custom Error");
    // return Text("Returned Widget!");
  }
}
