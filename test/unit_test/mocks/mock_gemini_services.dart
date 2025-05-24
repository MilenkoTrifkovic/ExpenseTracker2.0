import 'package:expense_tracker_2/providers/expense_categories_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockCategoryNotifier extends Mock implements CategoryNotifier {}
