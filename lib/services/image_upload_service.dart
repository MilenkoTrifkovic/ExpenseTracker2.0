import 'package:dio/dio.dart';

class ImageUploadService {
  final Dio _dio = Dio(); // Single instance of Dio

  ImageUploadService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) {
        print("❌ DioError: ${e.message}");
        handler.next(e);
      },
    ));
  }

  Future<bool> uploadProfileImage(String imagePath, String filename) async {
    try {
      FormData formData = FormData.fromMap({
        "name": "John Doe",
        "email": "johndoe@example.com",
        "profile_picture":
            await MultipartFile.fromFile(imagePath, filename: filename),
      });

      Response response = await _dio.post(
        'https://example.com/upload',
        data: formData,
      );

      if (response.statusCode == 200) {
        print("✅ Image uploaded successfully: ${response.data}");
        return true;
      } else {
        print("⚠️ Upload failed: ${response.statusCode}");
        return false;
      }
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      return false;
    } catch (e) {
      print("❌ Unexpected error: $e");
      return false;
    }
  }
}
