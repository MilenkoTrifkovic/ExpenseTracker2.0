import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'new_record_providers.g.dart';

@riverpod 
class TotalAmount extends _$TotalAmount {
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