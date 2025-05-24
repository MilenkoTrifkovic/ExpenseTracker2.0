import 'dart:convert';

import 'package:expense_tracker_2/config/enviorment.dart';
import 'package:expense_tracker_2/models/account_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

/// A service that handles communication between the app and the backend API.
///
/// Uses Firebase Authentication to obtain an ID token for authorized requests,
/// and sends HTTP requests to the App Engine endpoints defined in
/// [Environment.appEngineApiUrl].
class BackendService {
  static Future<String> getToken() async {
    String token;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      token = await user.getIdToken() as String;
      // Use the token
    } else {
      throw Exception('User is not authenticated');
    }
    return token;
  }

  /// Retrieves all expense records for the currently authenticated user.
  ///
  /// Sends a GET request to `<apiUrl>/user/getUserRecords` with an
  /// `Authorization` header containing the Firebase ID token.
  ///
  /// Returns the raw response body as a [String].
  ///
  /// Throws an exception if the HTTP call fails.
  static Future<String> getUserRecords() async {
    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': token,
    };

    // Make a GET request with headers
    final response = await http.get(
        Uri.parse('${Environment.appEngineApiUrl}user/getUserRecords'),
        headers: headers);
    return response.body;
  }

  /// Saves or updates the user’s account information.
  ///
  /// Sends a POST request to `<apiUrl>/user/saveUserInfo` with a JSON body
  /// derived from [accountInfo]. Includes an `Authorization` header with the
  /// Firebase ID token.
  ///
  /// Returns the server’s `message` field on success'
  ///
  /// Throws an exception if the HTTP call fails.
  static Future<String> saveUserInfo(AccountInfo accountInfo) async {
    final token = await getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    final body = jsonEncode(accountInfo.toJson());

    final response = await http.post(
        Uri.parse('${Environment.appEngineApiUrl}user/saveUserInfo'),
        headers: headers,
        body: body);

    if (response.statusCode != 200) {
      throw Exception('Failed to save user info: ${response.body}');
    }

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return responseData['message'];
  }

  /// Checks whether the authenticated user has saved account information.
  ///
  /// Sends a GET request to `<apiUrl>/user/checkUserInfo` with an
  /// `Authorization` header. If the response’s `data` field is not null and
  /// `success` is true, returns an [AccountInfo] constructed from the
  /// server’s JSON. Otherwise throws an exception.
  static Future<AccountInfo?> checkUserInfo() async {
    final token = await getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token!,
    };
    final response = await http.get(
        Uri.parse('${Environment.appEngineApiUrl}user/checkUserInfo'),
        headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch user info: ${response.body}');
    }
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    if (responseData['success'] != true && response.statusCode == 200) {
      // throw Exception('User info not found');
      return null;
    }
    final Map<String, dynamic> userData = responseData['data'];
    return AccountInfo(
        firstName: userData['first_name'],
        lastName: userData['last_name'],
        yearOfBirth: userData['year_of_birth'],
        address: userData['address'],
        phoneNumber: userData['phone_number']);
  }
}
