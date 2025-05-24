import 'package:flutter/foundation.dart';

class Environment {
  static const String appEngineApiUrl =
      kReleaseMode ? 'appEngineLink' : 'http://10.0.2.2:8080/';
  static const String CloudFunctionApiCategoryChooser =
      'https://us-central1-expense-tracker-455519.cloudfunctions.net/nodejs-http-function-gemini';
}
