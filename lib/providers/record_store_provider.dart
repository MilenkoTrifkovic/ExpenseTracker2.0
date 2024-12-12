import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'record_store_provider.g.dart';

class RecordStore {
  static final List<TransactionRecord> transactionRecords = [];

  static void fetchRecords() async {
    if (transactionRecords.isEmpty) {
      final snapshot = await FirestoreService.getUserRecords();
      for (var record in snapshot.docs) {
        transactionRecords.add(record
            .data()); //The .data() method extracts the data from the QueryDocumentSnapshot and returns it as a Map<String, dynamic>
      }
    }
  }
}

@riverpod
class RecordsNotifier extends _$RecordsNotifier {
  @override
  Set<TransactionRecord> build() {
    return {};
  }

  void fetchAllRecords() async {
    QuerySnapshot<TransactionRecord> snapshot =
        await FirestoreService.getUserRecords();
    for (var doc in snapshot.docs) {
      state = {
        ...state,
        TransactionRecord(
            transaction: doc.data().transaction,
            category: doc.data().category,
            description: doc.data().description,
            price: doc.data().price,
            date: doc.data().date)
      };
    }
  }
}
