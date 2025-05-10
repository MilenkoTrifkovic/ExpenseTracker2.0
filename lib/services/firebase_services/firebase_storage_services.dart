import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final storageRef = FirebaseStorage.instance.ref();

  /// Uploads a receipt image file to Firebase Cloud Storage and returns URI as a string.
  ///
  /// Takes a [File] and returns a [Future<String>] containing the `gs://` URI of the uploaded file.
  ///
  /// Example URI format: `gs://your-bucket-name/uploads/temp/receipts/uuid.jpg`
  Future<String> uploadRecieptToCloudStorage(File file) async {
    try {
      final uniqueFileName =
          const Uuid().v4(); // like 'd290f1ee-6c54-4b01-90e6-d701748f0851'
      final photoRef =
          storageRef.child("uploads/temp/receipts/$uniqueFileName.jpg");
      await photoRef.putFile(file);

      final String gsutilURI = 'gs://${photoRef.bucket}/${photoRef.fullPath}';
      return gsutilURI;
    } catch (e) {
      throw Exception('Upload failed: $e');
    }
  }
}
