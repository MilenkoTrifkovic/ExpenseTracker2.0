import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';

// class MockAuthServices extends Mock implements FirebaseAuth{
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}
// }