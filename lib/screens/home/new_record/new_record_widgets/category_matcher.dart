import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/models/transaction_type.dart';
import 'package:expense_tracker_2/providers/expense_categories_provider.dart';
import 'package:expense_tracker_2/services/cloud_functions_services/gemini_cloud_function_service.dart';

class CategoryMatcher {
  final CategoryNotifier expenseNotifier;
  final CategoryNotifier incomeNotifier;

  CategoryMatcher(
      {required this.expenseNotifier, required this.incomeNotifier});

  Future<void> categoryMatch(
      {required TransactionStatus transactionStatus,
      required String description,
      required Future<List<TransactionCategory>> incomeCategories,
      required Future<List<TransactionCategory>> expenseCategories}) async {
    final GeminiServices gemini = GeminiServices();
    final categories = transactionStatus == TransactionStatus.expense
        ? await expenseCategories
        : await incomeCategories;
    await gemini.determineCategory(
        expenseNotifier: expenseNotifier,
        incomeNotifier: incomeNotifier,
        transactionStatus: transactionStatus,
        description: description,
        categories: categories);
  }
}
