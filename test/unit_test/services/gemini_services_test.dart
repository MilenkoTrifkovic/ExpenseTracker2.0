import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/services/cloud_functions_services/gemini_cloud_function_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_gemini_services.dart';

void main() {
  final mockNotifier = MockCategoryNotifier();
  late MockHttpClient mockHttpClient;
  late GeminiServices mockGeminiServices;
  setUpAll(() {
    registerFallbackValue(
      TransactionCategory(categoryName: 'Dummy', icon: 'Dummy'),
    );
    registerFallbackValue(
      Uri(),
    );
  });
  setUp(() {
    mockHttpClient = MockHttpClient();
    mockGeminiServices = GeminiServices(httpClient: mockHttpClient);
  });
  group(
    'GeminiServices.determineCategory',
    () {
      test('returns a list of TransactionCategory when status is 200',
          () async {
        // Arrange

        when(() => mockHttpClient.post(any(),
            headers: any(named: 'headers'),
            body:
                any(named: 'body'))).thenAnswer((_) async => http.Response(
            '{"message": "Success", "data": [{"category": "Car", "confidence": 0.8}, {"category": "Travel", "confidence": 0.1}, {"category": "Miscellaneous", "confidence": 0.1}] }',
            200));

        when(() =>
                mockNotifier.updateTransactionCategoryConfidence(any(), any()))
            .thenAnswer((_) async {});
        when(() => mockNotifier.sortListByConfidence()).thenReturn(null);

        final result = await mockGeminiServices.determineCategory(
          description: 'food',
          categories: expenseCategories,
          categoryNotifier: mockNotifier,
        );
        // Assert
        expect(result, isA<List<TransactionCategory>>());

        // Act
      });
      test('throws an Exception Exeption if status code is not 200', () async {
        // Arrange
        const mockSuccessJson =
            '{"message": "Success", "data": [{"category": "Car", "confidence": 0.8}, {"category": "Travel", "confidence": 0.1}, {"category": "Miscellaneous", "confidence": 0.1}]}';

        when(() => mockHttpClient.post(any(),
                headers: any(named: 'headers'), body: any(named: 'body')))
            .thenAnswer((_) async => http.Response(mockSuccessJson, 201));

        when(() =>
                mockNotifier.updateTransactionCategoryConfidence(any(), any()))
            .thenAnswer((_) async {});
        when(() => mockNotifier.sortListByConfidence()).thenReturn(null);

        await expectLater(
          () => mockGeminiServices.determineCategory(
            categories: expenseCategories,
            categoryNotifier: mockNotifier,
            description: 'food',
          ),
          throwsException,
        );

        // Act
      });
    },
  );
}
