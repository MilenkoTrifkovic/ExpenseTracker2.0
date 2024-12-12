import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore
      .instance; 

  static Future<void> addRecord(TransactionRecord record) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    // Reference to the user's document in the "records" collection
    final userDocRef = _firestore.collection('records').doc(user.uid);
    // Reference to the "userRecords" subcollection inside the user's document
    final userRecordsRef = userDocRef.collection('userRecords').withConverter(
          fromFirestore: TransactionRecord.fromFirestore,
          toFirestore: (TransactionRecord t, _) => t.toFirestore(),
        );

    // Add a new record to the subcollection
    await userRecordsRef.add(record);
  }
  static Future<QuerySnapshot<TransactionRecord>> getUserRecords() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    // Reference to the user's document in the "records" collection
    final userDocRef = _firestore.collection('records').doc(user.uid);
    // Reference to the "userRecords" subcollection inside the user's document
    final userRecordsRef = userDocRef.collection('userRecords').withConverter(
          fromFirestore: TransactionRecord.fromFirestore,
          toFirestore: (TransactionRecord t, _) => t.toFirestore(),
        );
    return userRecordsRef
        .get(); // This fetches all data from the database, applies a converter, and then calls .get()
  }
}
