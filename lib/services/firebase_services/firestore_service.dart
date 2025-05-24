import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A service class to interact with Firestore for handling user-specific records.
///
/// This class provides functionality to add and fetch user transaction records
/// in Firestore. It uses the Firebase Authentication instance to identify the
/// current user and perform operations on their records.
class FirestoreService {
  // Firestore instance used to interact with the Firestore database.
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Gets the current authenticated user from FirebaseAuth.
  ///
  /// Throws an exception if the user is not logged in.
  ///
  /// Returns:
  ///   [User] - The current Firebase user.
  static User get _currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not logged in');
    return user;
  }

  /// Provides a reference to the "userRecords" subcollection of the current user's document.
  ///
  /// This reference is used for performing operations like adding or fetching records.
  ///
  /// Returns:
  ///   [CollectionReference<TransactionRecord>] - A Firestore collection reference with a
  ///   converter to automatically convert Firestore documents to [TransactionRecord] objects.
  static CollectionReference<TransactionRecord> get _userRecordsRef {
    final userDocRef = _firestore.collection('records').doc(_currentUser.uid);
    return userDocRef.collection('userRecords').withConverter(
          fromFirestore: TransactionRecord.fromFirestore,
          toFirestore: (TransactionRecord t, _) => t.toFirestore(),
        );
  }

  /// Adds a new transaction record to the current user's "userRecords" subcollection.
  ///
  /// This method will throw an exception if the user is not logged in.
  ///
  /// [record] - The transaction record to be added.
  ///
  /// Returns:
  ///   [Future<void>] - Completes once the record is successfully added.
  static Future<void> addRecord(TransactionRecord record) async {
    await _userRecordsRef.add(record);
  }

  /// Fetches all transaction records for the current user from Firestore.
  ///
  /// This method will throw an exception if the user is not logged in.
  ///
  /// Returns:
  ///   [Future<QuerySnapshot<TransactionRecord>>] - A future that resolves to a snapshot
  ///   containing the user's transaction records.
  static Future<QuerySnapshot<TransactionRecord>> getUserRecords() {
    return _userRecordsRef.get();
  }
  //add more methods to interact with Firestore as needed
  //fetch records by date, delete records, etc.
}
