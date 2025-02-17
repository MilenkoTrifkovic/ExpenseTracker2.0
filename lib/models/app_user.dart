// class AppUser {
//   AppUser({required this.email, required this.uid, required this.token});

//   final String email;
//   final String uid;
//   final String token;
// }
class AppUser {
  AppUser({required this.email, required this.uid});

  final String email;
  final String uid;
  static late final String token;
  
}