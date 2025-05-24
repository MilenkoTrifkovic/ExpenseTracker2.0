import 'package:expense_tracker_2/models/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_categories_provider.g.dart';

/// An abstract class that defines a common interface for both
/// [ExpenseCategories] and [IncomeCategories] providers.
///
/// It includes methods to:
/// - Update the confidence score of a specific [TransactionCategory]
/// - Sort the current category list based on confidence values
abstract class CategoryNotifier {
  /// Updates the confidence level of the given [TransactionCategory].
  ///
  /// [category] - The category to update.
  /// [confidence] - The new confidence score to assign.
  Future<void> updateTransactionCategoryConfidence(
      TransactionCategory category, double confidence);

  /// Sorts the category list in descending order of confidence.
  void sortListByConfidence();
}

/// A Riverpod provider that manages a list of expense categories,
/// represented by [TransactionCategory] objects.
///
/// Implements [CategoryNotifier] to support updating and sorting
/// categories by confidence scores.
@riverpod
class ExpenseCategories extends _$ExpenseCategories
    implements CategoryNotifier {
  @override
  FutureOr<List<TransactionCategory>> build() async {
    return Future.value(expenseCategories);
  }

  @override
  Future<void> updateTransactionCategoryConfidence(
      TransactionCategory expenseCategory, double confidence) async {
    state = state.whenData(
      (stateValue) {
        return stateValue.map(
          (e) {
            final newValue = e.categoryName == expenseCategory.categoryName
                ? e.updateTransactionCategory(newConfidence: confidence)
                : e;
            return newValue;
          },
        ).toList();
      },
    );
  }

  @override
  Future<void> sortListByConfidence() async {
    state = state.whenData(
      (value) {
        value.sort((a, b) => (b.confidence ?? double.minPositive)
            .compareTo(a.confidence ?? double.minPositive));
        return value;
      },
    );
  }
}

/// A Riverpod provider that manages a list of income categories,
/// represented by [TransactionCategory] objects.
///
/// Similar to [ExpenseCategories], it supports initialization, confidence
/// updates, and sorting.
@riverpod
class IncomeCategories extends _$IncomeCategories implements CategoryNotifier {
  @override
  FutureOr<List<TransactionCategory>> build() async {
    // Load initial todo list from the remote repository
    return Future.value(incomeCategories);
  }

  @override
  Future<void> updateTransactionCategoryConfidence(
      TransactionCategory incomeCategory, double confidence) async {
    state = state.whenData(
      (stateValue) {
        final newList = stateValue.map(
          (e) {
            return e.categoryName == incomeCategory.categoryName
                ? e.updateTransactionCategory(newConfidence: confidence)
                : e;
          },
        ).toList();

        newList.sort((a, b) => (b.confidence ?? double.minPositive)
            .compareTo(a.confidence ?? double.minPositive));
        return newList;
      },
    );
  }

  @override
  Future<void> sortListByConfidence() async {
    state = state.whenData(
      (value) {
        value.sort((a, b) => (b.confidence ?? double.minPositive)
            .compareTo(a.confidence ?? double.minPositive));
        return value;
      },
    );
  }
}
