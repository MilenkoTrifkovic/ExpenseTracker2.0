// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_store_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recordsNotifierHash() => r'ed73336f0bf55f31d0764ad54b0b061b2494005d';

/// A [RecordsNotifier] is a Riverpod state notifier that manages a set of
/// [TransactionRecord] objects fetched from Firestore.
///
/// It starts with an empty set and provides a method to fetch all user
/// transaction records from the Firestore database.
///
/// Copied from [RecordsNotifier].
@ProviderFor(RecordsNotifier)
final recordsNotifierProvider = AutoDisposeNotifierProvider<RecordsNotifier,
    Set<TransactionRecord>>.internal(
  RecordsNotifier.new,
  name: r'recordsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recordsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RecordsNotifier = AutoDisposeNotifier<Set<TransactionRecord>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
