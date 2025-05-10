import 'dart:convert';

import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/services/backend_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'records_future_provider_from_backend.g.dart';

@riverpod
Future<List<TransactionRecord>> historyRecordsProvider(Ref ref) async {
  List<TransactionRecord> loadedRecords = [];
  String jsonRecords = await BackendService.getUserRecords();
  List<dynamic> jsonList = jsonDecode(jsonRecords);
  loadedRecords =
      jsonList.map((json) => TransactionRecord.fromJson(json)).toList();
  return loadedRecords;
}
