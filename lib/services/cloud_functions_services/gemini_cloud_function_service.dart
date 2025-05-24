import 'dart:convert';

import 'package:expense_tracker_2/config/enviorment.dart';
import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/providers/expense_categories_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class GeminiServices {
  final http.Client httpClient;

  GeminiServices({required this.httpClient});

  /// Determines the most likely categories for a given transaction description.
  ///
  /// Sends the provided description and category options to an external service,
  /// resets all confidences to zero, then updates and sorts each category
  /// based on the returned confidence scores.
  ///
  /// - **categoryNotifier**: The notifier to update the transaction categories.
  /// - **description**: The transaction description to classify.
  /// - **categories**: List of possible categories to consider.
  ///
  /// Returns the updated list of categories (with confidence scores) on success,
  /// or `null` if the HTTP call did not return status code 200.
  ///
  /// Throws an [Exception] if an error occurs during the HTTP request
  /// or JSON processing.
  Future<List<TransactionCategory>?> determineCategory({
    required CategoryNotifier categoryNotifier,
    required String description,
    required List<TransactionCategory> categories,
  }) async {
    try {
      //options is a list of all categories names
      List<String> options = [];

      for (var element in categories) {
        options.add(element.categoryName);
      }

      final response = await httpClient.post(
        Uri.parse(Environment.CloudFunctionApiCategoryChooser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{'message': description, 'options': options}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];
        // Resets all categories confidence to 0
        for (var element in categories) {
          await categoryNotifier.updateTransactionCategoryConfidence(
              element, 0);
        }

        for (var element in categories) {
          for (var elementData in data) {
            if (elementData['category'] == element.categoryName) {
              await categoryNotifier.updateTransactionCategoryConfidence(
                  element, elementData['confidence']);
              categoryNotifier.sortListByConfidence();
            }
          }
        }
        return categories;
      }
      throw Exception('Status code: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to determine category: ${e.toString()}');
    }
  }

  /// This function is used to extract a transaction record from a receipt image stored in Google Cloud Storage.
  /// It takes a `gsutilURI` string as input and returns a `TransactionRecord` object.
  /// It sends a POST request to a specified function URL with the `gsutilURI` in the request body
  /// It returns a `TransactionRecord` if response is successful, otherwise throws an exception.
  static Future<TransactionRecord?> extractRecordFromReciept(
      String gsutilURI) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token == null || token.isEmpty) {
      throw Exception('Token is null or empty');
    }
    String functionUrl =
        'https://nodejs-reciept-reader-vertex-gemini2-75814891396.us-central1.run.app';
    try {
      final response = await http.post(
        Uri.parse(functionUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{"gsutilURI": gsutilURI.trim()}),
        // body: jsonEncode(<String, dynamic>{'imageURI': 'gs://expense-tracker-455519.firebasestorage.app/uploads/temp/reciepts/45974dc3-e51d-4460-b634-8fd8f49d2ed1.jpg'}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final date = DateTime.parse(responseData['date']);
        final description = responseData['description'];
        final totalAmount = responseData['totalAmount'];
        return TransactionRecord(
          date: date,
          transaction: 'expense',
          category: TransactionCategory(
            categoryName: "",
            icon: "",
          ),
          description: description,
          price: totalAmount.toDouble(),
        );
      }
    } catch (e) {
      throw Exception('Failed to extract record: ${e.toString()}');
    }
  }
}
