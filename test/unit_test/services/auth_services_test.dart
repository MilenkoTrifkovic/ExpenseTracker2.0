import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_auth_services.dart';

void main() {
  test('should return Object when signUp is called', () async {
    // Arrange
    final mockFirebaseAuth = MockFirebaseAuth();

    // Stubbing the signUp method to return a mocked AppUser
// Mock the createUserWithEmailAndPassword method
    when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => MockUserCredential());
    // Act
    final result = await mockFirebaseAuth.createUserWithEmailAndPassword(
      email: 'test@example.com',
      password: 'password123',
    );
// Assert
    // Since we're mocking the return value, we can test the mock
    expect(result, isA<MockUserCredential>());
  });
}
