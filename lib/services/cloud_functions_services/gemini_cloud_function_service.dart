import 'dart:convert';

import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/models/transaction_type.dart';
import 'package:expense_tracker_2/providers/expense_categories_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class GeminiServices {
  /// This function is used to determine the category of a transaction based on its description.
  Future<List<TransactionCategory>?> determineCategory({
    required CategoryNotifier expenseNotifier,
    required CategoryNotifier incomeNotifier,
    required TransactionStatus transactionStatus,
    required String description,
    required List<TransactionCategory> categories,
  }) async {
    final CategoryNotifier categoryNotifier =
        transactionStatus == TransactionStatus.expense
            ? expenseNotifier
            : incomeNotifier;
    try {
      List<String> options = [];

      for (var element in categories) {
        options.add(element.categoryName);
      }

      final response = await http.post(
        Uri.parse(
            'https://us-central1-expense-tracker-455519.cloudfunctions.net/nodejs-http-function-gemini'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{'message': description, 'options': options}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];
        categories.forEach(
          (element) async {
            print(
                "This elemnt is from gemini before Updating ${element.categoryName}, confidence: ${element.confidence}");
            await categoryNotifier.updateTransactionCategoryConfidence(
                element, 0);
          },
        );
        categoryNotifier.sortListByConfidence();

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
    } catch (e) {
      throw Exception('Failed to determine category: ${e.toString()}');
    }
    return null;
  }
  /// This function is used to extract a transaction record from a receipt image stored in Google Cloud Storage.
  /// It takes a `gsutilURI` string as input and returns a `TransactionRecord` object.
  /// It sends a POST request to a specified function URL with the `gsutilURI` in the request body
  /// It returns a `TransactionRecord` if response is successful, otherwise throws an exception.
  static Future<TransactionRecord?> extractRecordFromReciept(String gsutilURI) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    print("UUUUUUUUUUUUUUUUUUUUUUUUUUUU This is the token: $token");
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
