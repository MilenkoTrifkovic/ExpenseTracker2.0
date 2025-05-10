import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/services/firebase_services/firestore_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'record_store_provider.g.dart';

@riverpod
class RecordsNotifier extends _$RecordsNotifier {
  @override
  Set<TransactionRecord> build() {
    return {};
  }

  Future<void> fetchAllRecords() async {
    // Fetch new records
    QuerySnapshot<TransactionRecord> snapshot =
        await FirestoreService.getUserRecords();

    // Use a local variable to collect records
    final newRecords = <TransactionRecord>{};

    for (var doc in snapshot.docs) {
      newRecords.add(TransactionRecord(
        transaction: doc.data().transaction,
        category: doc.data().category,
        description: doc.data().description,
        price: doc.data().price,
        date: doc.data().date,
      ));
    }

    // Update state once to prevent unnecessary rebuilds
    state = newRecords;
  }
}
