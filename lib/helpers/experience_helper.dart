import 'dart:convert';
// import '../../../models/home/experience_list_response.dart' as experienceData;
// import '../screens/home/schedule_model.dart';

class ExperienceHelper {
  late String scheduleId;
  // DaysGroup daysGroup = DaysGroup(
  //     scheduledDate: DateTime(1900 - 12 - 12), dayOfMonth: 0, hours: []);
  // late Hour hourSelected;
  //late experienceData.T selectedExperienceDetail;
  String noteAdded = '';
  String selectedCategory = 'Couple';
  int numberOfPerson = 4;

   String? titleExperience='';
   String? experienceDetails='';
   double? priceExperience=0.0;
   int? personExperience=0;
   String? locationExperience='';
   String? subHostName='';
   String? subHostMobileNumber='';

   String? mainCourseMeal='';
   String? mainFoodMeal='';

   String? dishName='';
   String? dishDescription='';
   double? dishPrice=0.0;
   int? dishServingNoOfPerson=0;
   String? address="";

  // final selectedWowFactors = {};
  final selectedPerferencesFactors = {};

  final selectedWowFactors = {};

  ExperienceHelper updateChecklist({
    required ExperienceHelper checkList,
    //required List<CheckListItem> itemList,
  }) {
    return ExperienceHelper();
  }

  ExperienceHelper updateOrderHelperItem({
    required ExperienceHelper checkListItem,
    required Map<String, dynamic> value,
  }) {
    return ExperienceHelper();
  }

  void displayData() {}

  // String
}
