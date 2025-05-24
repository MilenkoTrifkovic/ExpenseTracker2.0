import 'dart:convert';

import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/services/backend_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'records_future_provider_from_backend.g.dart';

/// Provides a list of `TransactionRecord` objects representing the user's transaction history.
///
/// This asynchronous provider fetches the raw JSON records from the backend service,
/// decodes them into Dart objects, and sorts them by date in descending order
/// (newest transactions first).
///
/// Error Handling:
/// If an exception occurs during fetching or decoding (e.g., network issues or invalid JSON),
/// the provider catches the exception and returns an empty list instead of failing.
///
/// Usage example:
/// ```dart
/// final history = await ref.watch(historyRecordsProvider.future);
/// ```
///
/// Returns:
/// - A `Future<List<TransactionRecord>>` containing the sorted transaction records,
///   or an empty list if an error occurs.
@riverpod
Future<List<TransactionRecord>> historyRecordsProvider(Ref ref) async {
  try {
    String jsonRecords = await BackendService.getUserRecords();
    List<dynamic> jsonList = jsonDecode(jsonRecords);
    List<TransactionRecord> loadedRecords =
        jsonList.map((json) => TransactionRecord.fromJson(json)).toList();
    loadedRecords.sort((a, b) => b.date.compareTo(a.date));
    return loadedRecords;
  } on Exception catch (e) {
    return [];
  }
}
