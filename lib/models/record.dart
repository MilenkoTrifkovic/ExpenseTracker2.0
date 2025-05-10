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
  final TransactionCategory category;
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
        transaction: data['transaction'],
        category: TransactionCategory(
            categoryName: data['category_name'], icon: data['category_icon']),
        description: data['description'],
        price: data['price']);

    return transactionRecord;
  }
  factory TransactionRecord.fromJson(Map<String, dynamic> json) {
    final dateMap = json['date'] as Map<String, dynamic>;
    final date =
        DateTime.fromMillisecondsSinceEpoch(dateMap['_seconds'] * 1000);
    return TransactionRecord(
      date: date,
      transaction: json['transaction'],
      category: TransactionCategory(
          categoryName: json['category_name'], icon: json['category_icon']),
      description: json['description'],
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'].toDouble(),
    );
  }
}
