import 'dart:convert';

import 'package:expense_tracker_2/models/account_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class BackendService {
  static Future<String> getUserRecords() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final headers = {
      'Content-Type': 'application/json', // Specifies the content type
      if (token != null) 'Authorization': token, // Adds an auth token if needed
    };

    // Make a GET request with headers
    final response = await http.post(
        Uri.parse('https://vital-range-448621-q8.uc.r.appspot.com/user/getUserRecords'),
        // Uri.parse(
            // 'http://localhost:8080/user/getUserRecords'),
            // 'http://10.0.2.2:8080/user/getUserRecords'), //Android Emulator requires 10.0.2.2 format
        headers: headers);
    return response.body;
    // throw Exception("Custom Error");
    // return Text("Returned Widget!");
  }

  static Future<String> saveUserInfo(AccountInfo accountInfo) async {
    final String? token;
    try {
      token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token == null) {
        return "User is not Authenticated";
      }
    } catch (e) {
      return 'Something went wrong $e';
    }
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    final body = jsonEncode(accountInfo.toJson());

    // final response = await http.post(Uri.parse('http://localhost:8080/user/saveUserInfo'), headers: headers, body: body);
    // final response = await http.post(Uri.parse('http://10.0.2.2:8080/user/saveUserInfo'), headers: headers, body: body);
    final response = await http.post(Uri.parse('https://vital-range-448621-q8.uc.r.appspot.com/saveUserInfo'), headers: headers, body: body);
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return responseData['message'];
  }
  static Future<AccountInfo?> checkUserInfo()async{
    
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token!,
    };
    final response = await http.post(Uri.parse('https://vital-range-448621-q8.uc.r.appspot.com/user/checkUserInfo'), headers: headers);
    // final response = await http.post(Uri.parse('http://localhost:8080/user/checkUserInfo'), headers: headers);
    // final response = await http.post(Uri.parse('http://10.0.2.2:8080/user/checkUserInfo'), headers: headers);
    final Map<String,dynamic> responseData = jsonDecode(response.body);
    if(responseData['data'] == null){
      return null;
    }
    final Map<String,dynamic> userData = responseData['data'];
    if(responseData['success']){
      return AccountInfo(
        firstName: userData['first_name'], 
        lastName: userData['last_name'], 
        yearOfBirth: userData['year_of_birth'], 
        address: userData['address'], 
        phoneNumber: userData['phone_number']);
        
    }else{return null;}
  }
  
  
}
