import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/signup/responses/questionire_response.dart';
import 'package:chef/screens/sign_up/questionire/component/sign_up_questionire_screen_m.dart';
import 'package:chef/screens/sign_up/questionire/component/sign_up_questionire_screen_vm.dart';
import '../../../../helpers/color_helper.dart';
import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/question_view.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUpQuestionireScreen
    extends BaseView<SignUpQuestionireScreenViewModel> {
  SignUpQuestionireScreen({Key? key}) : super(key: key);

  List<SocialMediaHandles> handlesList = [];
  List<int> answersIds = [];
  List<int> answerIdsInterests = [];

  void loadQuestionList(
    List<QuestionsList> questionsList,
  ) {
    for (int i = 0; i < questionsList.length; i++) {
      developer.log(' Question id is ' '${questionsList[i].name}');
      // dropdownDetails[professionList[i].name] = professionList[i].id;
    }
  }

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    final appTheme = AppTheme.of(context).theme;
    initState();

    viewModel.loadQuestion(baseUrl: Api.baseURL, context: context);
    return BlocBuilder<SignUpQuestionireScreenViewModel,
            SignUpQuestionireScreenState>(
        bloc: viewModel,
        builder: (_, state) => state.when(
            loading: _loading,
            loaded: (questionsList) => _displayLoadedData(
                state: state,
                appTheme: appTheme,
                context: context,
                questionList: questionsList,
                screenSizeData: screenSizeData)));
  }

  Widget _loading() => const GeneralLoading();

  void initState() {
    if (handlesList.isNotEmpty) {
      handlesList.clear();
    }
    handlesList.addAll([
      SocialMediaHandles(
          socialMediaName: Strings.userProfileSocialMediaHandleInstagram,
          socialMediaIcon: "assets/images/icons/instagram_1.png",
          textController: viewModel.instagramController),
      SocialMediaHandles(
          socialMediaName: Strings.userProfileSocialMediaHandleFacebook,
          socialMediaIcon: "assets/images/icons/facebook.png",
          textController: viewModel.facebookController),
      SocialMediaHandles(
          socialMediaName: Strings.userProfileSocialMediaHandleTwitter,
          socialMediaIcon: "assets/images/icons/twitter.png",
          textController: viewModel.twitterController),
      SocialMediaHandles(
          socialMediaName: Strings.userProfileSocialMediaHandleTikTok,
          socialMediaIcon: "assets/images/icons/tiktok.png",
          textController: viewModel.tiktokController)
    ]);
    // super.initState();
  }

  Future<File?> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      // User cancelled the selection
      return null;
    }
  }

  Widget _displayLoadedData({
    state,
    appTheme,
    required BuildContext context,
    required List<QuestionsList> questionList,
    required ScreenSizeData screenSizeData,
  }) {
    final size = screenSizeData.size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: appTheme.colors.primaryBackground,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            margin: const EdgeInsets.only(left: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const SignUpLetsStartScreen()),
                    // );
                  },
                  child: SvgPicture.asset(
                    Resources.getSignInLeftArrow,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () {
                    viewModel.addModelsFromQuestions(
                        context: context,
                        completion: () {
                          viewModel.saveChef(
                              baseUrl: Api.baseURL,
                              context: context,
                              completion: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpLetsStartScreen()),
                                );
                              });
                        });
                  },
                  child: SvgPicture.asset(
                    Resources.getSignInRightArrow,
                    color: const Color(0xfff1c452),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 260,
                width: double.infinity,
                child: Image.asset(Resources.getSignUpQuestionireBgPng),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 27),
                //   alignment: Alignment.center,
                //  padding: const EdgeInsets.only(left: 29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralText(
                      Strings.questionireLabel,
                      textAlign: TextAlign.start,
                      style: appTheme.typographies.interFontFamily.headline4
                          .copyWith(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w500),
                      //style: appTheme.typographies.interFontFamily.headline4,
                    ),
                    // const SizedBox(
                    //   height: 27,
                    // ),
                    Container(
                      height: 900,
                      child: ListView.builder(
                          itemCount: questionList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          // BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return QuestionView(
                              q1Controller:
                                  viewModel.journeyQuestion1Controller,
                              q2Controller:
                                  viewModel.journeyQuestion2Controller,
                              answerIdsInterests: viewModel.answerIdsInterests,
                              singleOptionAnswerId:
                                  viewModel.answerIdSingleOption,
                              appTheme: appTheme,
                              questionObj: questionList[index],
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    socialMediaHandles(appTheme),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () async {
                        File? selectedImage = await getImageFromGallery();
                        // selectedImage != null
                        //     ? () async {
                        viewModel.updateSelectedImage(selectedImage);
                        List<int> bytes = await selectedImage!.readAsBytes();
                        String binaryString = bytes
                            .map(
                                (byte) => byte.toRadixString(2).padLeft(8, '0'))
                            .join();
                        developer
                            .log("this is converted image + $binaryString");
                        binaryString.isNotEmpty
                            ? viewModel.savePicture(
                                baseUrl: Api.baseURL,
                                context: context,
                                image: binaryString)
                            : null;
                        viewModel.isImageSelected = true;
                        //   }
                        // : Toaster.infoToast(
                        //     context: context,
                        //     message: "Please select picture");
                      },
                      child: Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GeneralText(
                              Strings.labelProfilePicture,
                              textAlign: TextAlign.center,
                              style: appTheme
                                  .typographies.interFontFamily.headline4
                                  .copyWith(
                                      color: appTheme.colors.primaryBackground,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                            ),
                            ValueListenableBuilder<File?>(
                              valueListenable: viewModel.selectedImageNotifier,
                              builder: (BuildContext context,
                                  File? selectedImage, Widget? child) {
                                if (selectedImage != null) {
                                  return CircleAvatar(
                                    radius: 25,
                                    backgroundImage: FileImage(selectedImage),
                                  );
                                } else {
                                  return Image.asset(
                                    Resources.userProfilePicPng,
                                    height: 47,
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget socialMediaHandles(IAppThemeData appTheme) {
    TextController _socialController = TextController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.userProfileSocialMediaLabel,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              color: const Color(0xfffbeccb),
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 12,
        ),
        GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              childAspectRatio: 2.9,
            ),
            itemCount: handlesList.length,
            //

            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xfff1c452), width: 2),
                    color: HexColor.fromHex("#4b4b52"),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Container(
                      height: 31,
                      padding: const EdgeInsetsDirectional.all(6),
                      decoration: BoxDecoration(
                          color: HexColor.fromHex("#4b4b52"),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        handlesList[index].socialMediaIcon ?? "",
                      ),
                    ),
                    Flexible(
                      child: GeneralTextInput(
                        controller: handlesList[index].textController ??
                            _socialController,
                        // height: 16,
                        valueStyle: appTheme.typographies.interFontFamily.body2R
                            .copyWith(
                          color: Colors.white,),
                        backgroundColor: HexColor.fromHex("#4b4b52"),
                        hint: handlesList[index].socialMediaName ?? "",
                        hintStyle: appTheme.typographies.interFontFamily.body2R
                            .copyWith(
                          color: Colors.white,
                        ),
                        inputBorder: appTheme.searchbarBorder,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}

class ChipsWidget extends StatelessWidget {
  const ChipsWidget({
    Key? key,
    required this.appTheme,
    required this.title,
    this.selected = false,
    this.widthContainer = 130,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final String title;
  final bool selected;
  final double widthContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
        // width: widthContainer,
        child: GeneralText(
          title.capitalize(),
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              color: selected ? Colors.black : Colors.white,
              fontSize: 15.0,
              fontWeight: selected ? FontWeight.bold : FontWeight.w500),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: appTheme.colors.textFieldBorderColor,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(
            30,
          ),
          color: selected
              ? appTheme.colors.textFieldBorderColor
              : Colors.transparent,
        ));
  }
}

class SocialMediaHandles {
  String? socialMediaName;
  String? socialMediaIcon;
  TextController? textController;

  SocialMediaHandles(
      {this.socialMediaIcon, this.socialMediaName, this.textController});
}
