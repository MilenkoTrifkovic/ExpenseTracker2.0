import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/models/transaction_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'new_record_providers.g.dart';

@riverpod
class NewRecordTotalAmount extends _$NewRecordTotalAmount {
  @override
  String build() => '';

  void addLastDigitTotalAmount(String digit) {
    state += digit;
  }

  void removeLastDigitTotalAmount() {
    state = state.substring(0, state.length - 1);
  }

  void setTotalAmount(double totalAmount) {
    state = totalAmount.toString();
  }
}

@riverpod
class NewRecordSelectedCategory extends _$NewRecordSelectedCategory {
  @override
  TransactionCategory build() => expenseCategories[0];
  void changeCategory(TransactionCategory newCategory) {
    state = newCategory;
  }
}
@riverpod
class NewRecordSelectedTransactionStatus extends _$NewRecordSelectedTransactionStatus {
  @override
  TransactionStatus build() => TransactionStatus.expense;
  void changeTransactionStatus(TransactionStatus newStatus) {
    state = newStatus;
  }
}
@riverpod
class NewRecordLoadingStatus extends _$NewRecordLoadingStatus {
  @override
  bool build() => false;
  void changeLoadingStatus(bool newStatus) {
    state = newStatus;
  }
}
@riverpod
class NewRecordSelectedDate extends _$NewRecordSelectedDate {
  @override
  DateTime build() =>  DateTime.now();
  void changeDateAndTime(DateTime newDateTime) {
    state = newDateTime;
  }
}
@riverpod
class NewRecordDescription extends _$NewRecordDescription {
  @override
  String build() =>  '';
  void changeDescription(String description) {
    state = description;
  }
}