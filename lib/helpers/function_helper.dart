import '../constants/api.dart';

class FunctionHelper {
  static String getValidUrlForImages(String imagePath) {
    String baseUrl = Api.baseURL;
    baseUrl = baseUrl
        .replaceAll("feyst-service", "feyst-media")
        .replaceAll(":8080", '');
    baseUrl = baseUrl + imagePath;
    return baseUrl;
  }
}
