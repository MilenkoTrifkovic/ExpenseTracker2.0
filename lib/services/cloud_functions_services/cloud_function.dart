
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class CloudFunction {
  static
      //  Future<Album>
      fetchAlbum() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token == null || token.isEmpty) {
      throw Exception('Token is null or empty');
    }
    final response = await http.get(
        Uri.parse(
            'https://europe-west10-ultimate-retina-446415-n5.cloudfunctions.net/token-test'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('This is a body response: ${response.body}');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
