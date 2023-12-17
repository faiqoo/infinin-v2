import '../constants/api.dart';

class MenuHelper {
  int selectedMealId = 0;
  int selectedDishId = 0;

  String selectedBaseDishName = "";
  String selectedBaseMealNameCategory = "";
  String selectedDishName = '';
  String givenDescription = '';

  double givenPrice = 0.0;
  int dishServingNoOfPerson = 0;

  String getValidUrlForImages(String imagePath) {
    String baseUrl = Api.baseURL;
    baseUrl = baseUrl
        .replaceAll("feyst-service", "feyst-media")
        .replaceAll(":8080", '');
    baseUrl = baseUrl + imagePath;
    return baseUrl;
  }
}
