import 'package:dio/dio.dart';

class ImageUploadService {
  final Dio _dio = Dio(); // Single instance of Dio

  ImageUploadService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) {
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
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }
}
