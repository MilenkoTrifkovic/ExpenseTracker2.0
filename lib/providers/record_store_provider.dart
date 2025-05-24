import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/services/firebase_services/firestore_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'record_store_provider.g.dart';

/// A [RecordsNotifier] is a Riverpod state notifier that manages a set of
/// [TransactionRecord] objects fetched from Firestore.
///
/// It starts with an empty set and provides a method to fetch all user
/// transaction records from the Firestore database.
@riverpod
class RecordsNotifier extends _$RecordsNotifier {
  @override
  Set<TransactionRecord> build() {
    return {};
  }

  /// Fetches all transaction records for the current user from Firestore.
  ///
  /// This method retrieves the data using [FirestoreService.getUserRecords],
  /// maps the Firestore documents into [TransactionRecord] instances, and
  /// updates the state with the new records.
  Future<void> fetchAllRecords() async {
    // Fetch new records from Firestore
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
    List<TransactionRecord> records = newRecords.toList();
    records.sort((a, b) => b.date.compareTo(a.date));
    Set<TransactionRecord> sortedRecords = records.toSet();
  // Update the state with the new set of records
    state = sortedRecords;
  }
}
