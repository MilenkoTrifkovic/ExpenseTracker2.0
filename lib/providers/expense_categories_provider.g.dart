// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_categories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expenseCategoriesHash() => r'0d67f6a794934ba94f411115d0d49eed921f0833';

/// See also [ExpenseCategories].
@ProviderFor(ExpenseCategories)
final expenseCategoriesProvider = AutoDisposeAsyncNotifierProvider<
    ExpenseCategories, List<TransactionCategory>>.internal(
  ExpenseCategories.new,
  name: r'expenseCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpenseCategories
    = AutoDisposeAsyncNotifier<List<TransactionCategory>>;
String _$incomeCategoriesHash() => r'17211524080fd12a070171fee82288388c15e1a8';

/// See also [IncomeCategories].
@ProviderFor(IncomeCategories)
final incomeCategoriesProvider = AutoDisposeAsyncNotifierProvider<
    IncomeCategories, List<TransactionCategory>>.internal(
  IncomeCategories.new,
  name: r'incomeCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$incomeCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IncomeCategories
    = AutoDisposeAsyncNotifier<List<TransactionCategory>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
