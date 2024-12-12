import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_2/models/category.dart';

class TransactionRecord {
  TransactionRecord({
    required this.transaction,
    required this.date,
    required this.category,
    required this.description,
    required this.price,
  });
  final DateTime date;
  final String transaction;
  final Category category;
  final String description;
  final double price;

  Map<String, dynamic> toFirestore() {
    return {
      'transaction': transaction,
      'category_name': category.categoryName,
      'category_icon': category.icon,
      'description': description,
      'price': price,
      'date': date
    };
  }

  factory TransactionRecord.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    TransactionRecord transactionRecord = TransactionRecord(
        date: (data!['date'] as Timestamp).toDate(),
        transaction: data!['transaction'],
        category: Category(
            categoryName: data!['category_name'], icon: data['category_icon']),
        description: data!['description'],
        price: data['price']);

    return transactionRecord;
  }
}
