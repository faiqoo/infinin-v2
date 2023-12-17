import 'dart:io';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/signup/requests/questionire_request.dart'
    as questionirerequest;

import '../../../../models/signup/requests/save_chef_request.dart' as save_chef_request;

import 'package:chef/models/signup/responses/questionire_response.dart';

import 'package:chef/screens/sign_up/questionire/component/sign_up_questionire_screen_m.dart'
    as signupquestion;

import 'dart:developer' as developer;

import '../../../../models/signup/requests/save_chef_request.dart';
import '../../../../models/signup/responses/question_answer_response.dart';


@injectable
class SignUpQuestionireScreenViewModel
    extends BaseViewModel<signupquestion.SignUpQuestionireScreenState> {
  SignUpQuestionireScreenViewModel({
    required INavigationService navigation,
    required INetworkService network,
    required IStorageService storage,
    required ApplicationService appService,
  })  : _navigation = navigation,
        _network = network,
        _storage = storage,
        _appService = appService,
        super(const signupquestion.Loading());

  final INavigationService _navigation;
  final INetworkService _network;
  final IStorageService _storage;
  final ApplicationService _appService;

  List<QuestionsList> questionsResponseData = [];

  List<int> answerIdsInterests = [];
  List<int> answerIdSingleOption = [];

List<ChefQuestionAnswers> chefQuestionAnswersList = [];
  SocialHandles? socialHandles;

  ValueNotifier<File?> selectedImageNotifier = ValueNotifier<File?>(null);

  final TextController journeyQuestion1Controller = TextController();
  final TextController journeyQuestion2Controller = TextController();
  final TextController facebookController = TextController();
  final TextController instagramController = TextController();
  final TextController twitterController = TextController();
  final TextController tiktokController = TextController();


  bool isImageSelected = false;
  void updateSelectedImage(File? image) {
    if (image != null) {
      selectedImageNotifier.value = image;
      isImageSelected = true;
    }
  }

  Future<void> loadQuestion({
    required String baseUrl,
    required BuildContext context,
  }) async {
    final url = InfininHelpers.getRestApiURL(baseUrl + Api.questionListAPI);
    final questionsDataRequest = questionirerequest.QuestionireRequest(
      t: questionirerequest.T(category: "CHEF_PROFILE"),
    ).toJson();
    final response = await _network.post(
      path: url,
      data: questionsDataRequest,
    );

    final currentQuestionirData = questionireResponseFromJson(response.body);
    developer.log(' Current Questionnaire Data ' '${response.body}');
    questionsResponseData = currentQuestionirData.t;
    emit(signupquestion.Loaded(currentQuestionirData.t));

    // emit(Loaded(currentQuestionirData.t));
  }


  Future<void> saveChef({
    required String baseUrl,
    required BuildContext context,
    Function? completion,
  }) async {
    final url = InfininHelpers.getRestApiURL(baseUrl + Api.saveChef);

    final saveChefRequest = save_chef_request.SaveChefRequest(
      userId: _appService.state.userInfo?.t.id,
      t: save_chef_request.T(chefQuestionAnswers: chefQuestionAnswersList,socialHandles: socialHandles),
    ).toJson();
    final response = await _network.post(
      path: url,
      data: saveChefRequest,
    );
    developer.log("$saveChefRequest");
    // final currentQuestionirData = questionireResponseFromJson(response.body);
    if (response != null) {
      developer
          .log(' Response of Save Chef is  ' '${response.body}');
      ChefQuestionAnswerResponse chefQuestionAnswerResponse = chefQuestionAnswerResponseFromJson(response.body);
      Toaster.infoToast(
          context: context, message: chefQuestionAnswerResponse.message.toString());
      completion!();
    } else {
      Toaster.infoToast(context: context, message: 'Error in calling the Api');
    }
  }


  Future<void> savePicture({
    required String baseUrl,
    required BuildContext context,
    required String image,
    Function? completion,
  }) async {
    final url = InfininHelpers.getRestApiURL(baseUrl + "chef/profile-image/${_appService.state.userInfo!.t.id}");

    final savePicRequest = {
      "image":image,
    };
    developer.log("this is savePicReq""$savePicRequest");

    final response = await _network.post(
      path: url,
      data: savePicRequest,
    );

    if (response != null) {
      developer
          .log(' Response of Save Pic is  ' '${response.body}');
      // ChefQuestionAnswerResponse chefQuestionAnswerResponse = chefQuestionAnswerResponseFromJson(response.body);
      Toaster.infoToast(
          context: context, message: response.message);
      completion!();
    } else {
      Toaster.infoToast(context: context, message: 'Error in calling the Api');
    }
  }

  void addModelsFromQuestions({Function? completion, required BuildContext context}){
    if(answerIdsInterests.isNotEmpty&&answerIdSingleOption.isNotEmpty&&journeyQuestion1Controller.text.isNotEmpty&&journeyQuestion2Controller.text.isNotEmpty){
      chefQuestionAnswersList.add(ChefQuestionAnswers(answerIds: answerIdsInterests, chefId: _appService.state.userInfo!.t.id,id: 7,inputAnswer: '',questionId: 7));
      chefQuestionAnswersList.add(ChefQuestionAnswers(answerIds: answerIdSingleOption,id: 4,inputAnswer: '',chefId: _appService.state.userInfo!.t.id,questionId: 4));
      chefQuestionAnswersList.add(ChefQuestionAnswers(id: 5,inputAnswer: journeyQuestion1Controller.text,chefId: _appService.state.userInfo!.t.id,answerIds: [],));
      chefQuestionAnswersList.add(ChefQuestionAnswers(id: 6,inputAnswer: journeyQuestion2Controller.text,chefId: _appService.state.userInfo!.t.id,answerIds: [],));
      socialHandles = SocialHandles(facebook: facebookController.text,instagram: instagramController.text,tiktok: tiktokController.text,twitter: twitterController.text);
      completion!();
    }else{
      Toaster.errorToast(context: context, message: 'Please fill all the fields');
    }
  }

  bool isValidUrl(String url) => Uri.tryParse(url)?.hasAbsolutePath ?? false;

  String updateUrl(String url) {
    if (!url.endsWith('/')) {
      url += '/';
    }
    if (!url.endsWith(Api.client)) {
      url += Api.client;
    }
    return url;
  }

  void loading() => emit(const signupquestion.Loading());
}
