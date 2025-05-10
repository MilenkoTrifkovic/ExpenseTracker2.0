import 'package:expense_tracker_2/models/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_categories_provider.g.dart';

abstract class CategoryNotifier {
  Future<void> updateTransactionCategoryConfidence(
      TransactionCategory category, double confidence);
  void sortListByConfidence();
}

@riverpod
class ExpenseCategories extends _$ExpenseCategories
    implements CategoryNotifier {
  @override
  FutureOr<List<TransactionCategory>> build() async {
    // Load initial todo list from the remote repository
    return Future.value(expenseCategories);
  }

  @override
  Future<void> updateTransactionCategoryConfidence(
      TransactionCategory expenseCategory, double confidence) async {
    state = state.whenData(
      (stateValue) {
        return stateValue.map(
          (e) {
            if (e.categoryName == expenseCategory.categoryName) {
              print(
                  'entered comparison between: ${e.categoryName} & ${expenseCategory.categoryName}');
            } else {
              print(
                  'Comparios in else{: ${e.categoryName} & ${expenseCategory.categoryName}');
            }
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
