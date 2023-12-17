import 'dart:developer';
import 'dart:typed_data';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/sign_up/sign_up_screen_vm.dart';
import 'package:chef/screens/sign_up/town_helper.dart';
import 'package:chef/screens/sign_up/verify_phone_number.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../setup.dart';
import '../../ui_kit/helpers/dialog_helper.dart';
import '../sign_in/sign_in_screen_v.dart';

import 'dart:developer' as developer;
import '../sign_up/sign_up_screen_m.dart';
import 'city_town_helper.dart';

class SignUpScreen extends BaseView<SignUpScreenViewModel> {
  SignUpScreen({Key? key}) : super(key: key);

  final baseURLs = [
    // Api.prodURL,
    Api.baseURL,
    Api.devBaseURL,
  ];

  bool numberValidated = false;

  late List<DropdownMenuItem<String>> items = [];
  final TextController _nameController = TextController();
  final TextController _brandController = TextController();
  final TextController _mobileNumberController = TextController();
  final TextController _addressController = TextController();
  // final TextController _townController = TextController();
  // final TextController _cityController = TextController();

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    final appTheme = AppTheme.of(context).theme;
    return BlocBuilder<SignUpScreenViewModel, SignUpScreenState>(
        bloc: viewModel..loadCityList(baseUrl: Api.baseURL),
        builder: (_, state) => state.when(
            initialized: (fullName, brandName, mobileNumber, address) =>
                _initialized(),
            loading: _loading,
            loaded: (cityList) => _displayLoadedData(
                state: state,
                appTheme: appTheme,
                context: context,
                screenSizeData: screenSizeData)));
  }

  Widget _initialized() {
    return Container();
  }

  Widget _loading() => const GeneralLoading();

  Widget _displayLoadedData({
    state,
    appTheme,
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    final size = screenSizeData.size;
    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      bottomNavigationBar: displayAlreadySignIn(appTheme, context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  // screenSizeData.screenType == ScreenType.small ?
                  _buildMobileView(
                    context: context,
                    state: state,
                    appTheme: appTheme,
                    size: size,
                  ),
                  //     : _buildTabletView(
                  //   context: context,
                  //   state: state,
                  //   appTheme: appTheme,
                  //   size: size,
                  // ),
                ],
              )
              // child:
              ),
        ),
      ),
    );
  }

  Widget _buildMobileView({
    required BuildContext context,
    required SignUpScreenState state,
    required IAppThemeData appTheme,
    required Size size,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 41,
        ),
        _getStartedTitle(appTheme: appTheme),
        Center(
          child: GeneralText(
            Strings.signUpTitle,
            textAlign: TextAlign.center,
            style: appTheme.typographies.interFontFamily.headline4.copyWith(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 27,
        ),
        displayFullName(appTheme),
        const SizedBox(
          height: 24,
        ),
        displayBrandName(appTheme),
        const SizedBox(
          height: 24,
        ),
        displayMobileNumber(appTheme),
        const SizedBox(
          height: 24,
        ),
        // displayTownCity(appTheme),
        CityTownHelper(
          cityDropDown: viewModel.cityDropDown,
          cityResponse: viewModel.cityResponse,
          townDropDown: viewModel.townDropDown,
          cityTownInfo: viewModel.cityTownInfo,
          townController: viewModel.townController,
          cityController: viewModel.cityController,
        ),
        const SizedBox(
          height: 10,
        ),
        displayAddress(appTheme, context),
        const SizedBox(
          height: 10,
        ),
      ],
    );
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget displayFullName(IAppThemeData appTheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.signFullNameLabel,
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline4.copyWith(
              color: const Color(0xfffbeccb),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        GeneralTextInput(
            controller: _nameController,
            inputType: InputType.alphabetsOnly,
            backgroundColor: appTheme.colors.textFieldFilledColor,
            inputBorder: appTheme.focusedBorder,
            valueStyle: const TextStyle(color: Colors.white),
            hint: 'Enter name',
            hintStyle:
                TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),

            // valueStyle: valueStyle,
            onChanged: (newValue) {
              if (viewModel.verifyInputForm(
                  name: _nameController.text,
                  brandName: _brandController.text,
                  mobileNumber: _mobileNumberController.text,
                  address: _addressController.text,
                  town: viewModel.townController.text,
                  city: viewModel.cityController.text)) {
                viewModel.changeButton(true);
              } else {
                viewModel.changeButton(false);
              }
            }),
      ],
    );
  }

  Widget displayBrandName(IAppThemeData appTheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.signBrandNameLabel,
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline4.copyWith(
              color: const Color(0xfffbeccb),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        GeneralTextInput(
            controller: _brandController,
            inputType: InputType.text,
            backgroundColor: appTheme.colors.textFieldFilledColor,
            inputBorder: appTheme.focusedBorder,
            valueStyle: const TextStyle(color: Colors.white),
            hint: 'Enter brand name',
            hintStyle:
                TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (newValue) {
              if (viewModel.verifyInputForm(
                  name: _nameController.text,
                  brandName: _brandController.text,
                  mobileNumber: _mobileNumberController.text,
                  address: _addressController.text,
                  town: viewModel.townController.text,
                  city: viewModel.cityController.text)) {
                viewModel.changeButton(true);
              } else {
                viewModel.changeButton(false);
              }
            }),
      ],
    );
  }

  Widget displayMobileNumber(IAppThemeData appTheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.signMobileNumberLabel,
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              color: const Color(0xfffbeccb),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        GeneralTextInput(
            prefixText: "+92 ",
            controller: _mobileNumberController,
            inputType: InputType.digit,
            backgroundColor: appTheme.colors.textFieldFilledColor,
            inputBorder: appTheme.focusedBorder,
            valueStyle: const TextStyle(color: Colors.white),
            hint: 'Enter Mobile Number',
            hintStyle:
                TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            maxValue: 10,
            validator: (value) {
              // final phoneNumberRegex = RegExp(r'^3\d{10}$');

              if (value != null &&
                  value.isNotEmpty &&
                  int.parse(value[0]) != 3) {
                numberValidated = false;
                return 'Invalid phone number';
              } else if (value!.isNotEmpty && value.length != 10) {
                numberValidated = false;
                return 'Please enter your full number';
              } else {
                numberValidated = true;
                return null;
              }
            },
            onChanged: (newValue) {
              if (viewModel.verifyInputForm(
                  name: _nameController.text,
                  brandName: _brandController.text,
                  mobileNumber: _mobileNumberController.text,
                  address: _addressController.text,
                  town: viewModel.townController.text,
                  city: viewModel.cityController.text)) {
                viewModel.changeButton(true);
              } else {
                viewModel.changeButton(false);
              }
            }),
      ],
    );
  }

  Widget displayAddress(IAppThemeData appTheme, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.signAddressLabel,
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              color: const Color(0xfffbeccb),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        GeneralTextInput(
            controller: _addressController,
            inputType: InputType.text,
            suffix: InkWell(
              onTap: () {
                viewModel.getCurrentPosition(
                    context: context,
                    completion: () {
                      viewModel.getCurrentPosition(
                          context: context,
                          completion: () {
                            _addressController.text = viewModel.currentAddress;
                          });
                    });
              },
              child: Image.asset(
                Resources.locationIconPNG,
                height: 20,
              ),
            ),
            backgroundColor: appTheme.colors.textFieldFilledColor,
            inputBorder: appTheme.focusedBorder,
            valueStyle: const TextStyle(color: Colors.white),
            hint: 'Enter Address',
            hintStyle:
                TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (newValue) {
              if (viewModel.verifyInputForm(
                  name: _nameController.text,
                  brandName: _brandController.text,
                  mobileNumber: _mobileNumberController.text,
                  address: _addressController.text,
                  town: viewModel.townController.text,
                  city: viewModel.cityController.text)) {
                viewModel.changeButton(true);
              } else {
                viewModel.changeButton(false);
              }
            }),
      ],
    );
  }

  Widget displayAlreadySignIn(IAppThemeData appTheme, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
            child: GeneralText(
              Strings.signAlreadyUserLabel,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xfff7dc99),
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ValueListenableBuilder(
            builder: (context, value, _) {
              return InkWell(
                onTap: value == true
                    ? () {
                        //proceedVerification(context);
                        developer.log(
                            ' Here Collected data is ' + _nameController.text);
                        developer.log('Mobile Controller  ' +
                            _mobileNumberController.text);

                        developer
                            .log(' Brand Controller  ' + _brandController.text);

                        developer.log('Address is  ' + _addressController.text);
                        if (numberValidated) {
                          if (viewModel.verifyInput(
                            name: _nameController.text,
                            brandName: _brandController.text,
                            mobileNumber: _mobileNumberController.text,
                            address: _addressController.text,
                            town: viewModel.townController.text,
                            city: viewModel.cityController.text,
                            context: context,
                            baseUrl: baseURLs[0],
                          )) {
                            print(_mobileNumberController.text);
                            // displayVerificationDisplay(context);
                            displayVerificationDisplayBackup(context);
                          }
                        }
                      }
                    : null,
                child: ValueListenableBuilder(
                  valueListenable: viewModel.buttonEnabled,
                  builder: (context, value, _) {
                    return value == true
                        ? SvgPicture.asset(
                            Resources.getSignInRightArrow,
                          )
                        : SvgPicture.asset(
                            Resources.getRightArrow,
                          );
                  },
                ),
              );
            },
            valueListenable: viewModel.buttonEnabled,
          ),
        ],
      ),
    );
  }

  void displayVerificationDisplayBackup(BuildContext context) {
    //   void displayAttachmentPopUp() {
    final appTheme = AppTheme.of(context).theme;

    DialogHelper.show(
        // dcontext: context,
        title: 'Verification code',
        isDismissible: true,
        canDismiss: () {
          return true;
        },
        barrierLabel: 'Verification code',
        context: context,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
        body: FirebasePhoneAuthHandler(
          phoneNumber: "+92" + _mobileNumberController.text,
          signOutOnSuccessfulVerification: false,
          linkWithExistingUser: false,
          autoRetrievalTimeOutDuration: const Duration(seconds: 60),
          otpExpirationDuration: const Duration(seconds: 60),
          onCodeSent: () {
            log(VerifyPhoneNumberScreen.id, name: 'OTP sent!');
          },
          onLoginSuccess: (userCredential, autoVerified) async {
            log(
              VerifyPhoneNumberScreen.id,
              name: autoVerified
                  ? 'OTP was fetched automatically!'
                  : 'OTP was verified manually!',
            );

            // showSnackBar('Phone number verified successfully!');
            Toaster.infoToast(
                context: context,
                message: 'Phone number verified successfully!');
            log(
              VerifyPhoneNumberScreen.id,
              name: 'Login Success UID: ${userCredential.user?.uid}',
            );
            viewModel.saveChef(
              name: _nameController.text,
              brandName: _brandController.text,
              mobileNumber: _mobileNumberController.text,
              address: _addressController.text,
              town: viewModel.townController.text,
              city: viewModel.cityController.text,
              context: context,
              baseUrl: baseURLs[0],
            );
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   HomeScreen.id,
            //   (route) => false,
            // );
          },
          onLoginFailed: (authException, stackTrace) {
            log(
              VerifyPhoneNumberScreen.id,
              name: (authException.message)!,
              error: authException,
              stackTrace: stackTrace,
            );

            switch (authException.code) {
              case 'invalid-phone-number':
                // invalid phone number
                return Toaster.infoToast(
                    context: context, message: 'Invalid phone number!');
              case 'invalid-verification-code':
                // invalid otp entered
                return Toaster.infoToast(
                    context: context, message: 'The entered OTP is invalid!');
              // handle other error codes
              default:
                Toaster.infoToast(
                    context: context, message: 'Something went wrong!');
              // handle error further if needed
            }
          },
          onError: (error, stackTrace) {
            log(
              VerifyPhoneNumberScreen.id,
              error: error,
              stackTrace: stackTrace,
            );

            // showSnackBar('An error occurred!');
            Toaster.infoToast(context: context, message: 'An error occurred!');
          },
          builder: (context, controller) {
            return verificationDesign(context, controller);
          },
        ));
  }

  Widget verificationDesign(BuildContext context, controller) {
    final appTheme = AppTheme.of(context).theme;
    final TextController _otpController = TextController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GeneralText(
            Strings.verificationPopupTitle,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
                color: appTheme.colors.secondaryBackground,
                fontSize: 24,
                fontFamily: 'Poppins-Medium',
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 14,
          ),
          GeneralText(
            Strings.verificationPopupSubtitleForAuthPopUp +
                "" +
                _mobileNumberController.text,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: appTheme.typographies.interFontFamily.headline4.copyWith(
                color: appTheme.colors.secondaryBackground,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 34,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: PinCodeTextField(
              controller: _otpController,

              length: 6,
              cursorColor: appTheme.colors.secondaryBackground,

              textStyle: TextStyle(
                color: appTheme.colors.secondaryBackground,
              ),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                selectedColor: Color(0xfff1c452),
                disabledColor: Color(0xfff1c452),
                inactiveColor: Color(0xfff1c452),
                inactiveFillColor: Color(0xff35353C),
                activeColor: Color(0xff35353C),
                borderRadius: BorderRadius.circular(8),
                // fieldHeight: 58,
                fieldWidth: 39,
                selectedFillColor: Color(0xff35353C),
                activeFillColor: Color(0xff35353C),
              ),
              obscureText: false,
              keyboardType: TextInputType.number,

              enableActiveFill: true,
              // validator: (value) {
              //   String? validationText =getIt<Localization>().mtLocalized("otp_enterOTP");
              //       "Fields cannot be empty";
              //   if (value!.length == AppConstants.otpLength) {
              //     validationText = null;
              //   }
              //   return validationText;
              // },
              animationType: AnimationType.fade,
              animationDuration: const Duration(milliseconds: 300),
              //errorAnimationController: errorController, // Pass it here
              onChanged: (value) {
                if (viewModel.verifyInputForm(
                    name: _nameController.text,
                    brandName: _brandController.text,
                    mobileNumber: _mobileNumberController.text,
                    address: _addressController.text,
                    town: viewModel.townController.text,
                    city: viewModel.cityController.text)) {
                  viewModel.changeButton(true);
                } else {
                  viewModel.changeButton(false);
                }
              },

              onSubmitted: (enteredOtp) async {
                final verified = await controller.verifyOtp(enteredOtp);
                //var verified = false;
                if (verified) {
                  // number verify success
                  // will call onLoginSuccess handler
                  // viewModel.saveFoodie(name: name, mobileNumber: mobileNumber, age: age, gender: gender, professionId: professionId, context: context, baseUrl: baseUrl)

                  viewModel.saveChef(
                    name: _nameController.text,
                    brandName: _brandController.text,
                    mobileNumber: _mobileNumberController.text,
                    address: _addressController.text,
                    town: viewModel.townController.text,
                    city: viewModel.cityController.text,
                    context: context,
                    baseUrl: baseURLs[0],
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => SignUpScreen(
                  //         isVerified: true,
                  //       )),
                  // );
                } else {
                  // phone verification failed
                  // will call onLoginFailed or onError callbacks with the error
                }
              },
              appContext: context,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          GeneralButton.button(
            title: Strings.verificationPopupButton.toUpperCase(),
            styleType: ButtonStyleType.fill,
            width: 170,
            onTap: () {
              if (viewModel.verifyInput(
                name: _nameController.text,
                brandName: _brandController.text,
                mobileNumber: _mobileNumberController.text,
                address: _addressController.text,
                town: viewModel.townController.text,
                city: viewModel.cityController.text,
                context: context,
                baseUrl: baseURLs[0],
              )) {
                viewModel.saveChef(
                  name: _nameController.text,
                  brandName: _brandController.text,
                  mobileNumber: _mobileNumberController.text,
                  address: _addressController.text,
                  town: viewModel.townController.text,
                  city: viewModel.cityController.text,
                  context: context,
                  baseUrl: baseURLs[0],
                );
              }

              //  proceedVerification(context);
            },
          ),
          SizedBox(
            height: 22,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              displayVerificationDisplayBackup(context);
              Toaster.infoToast(
                  context: context, message: 'Verification Code Resent');
            },
            child: GeneralText(
              Strings.verificationPopupResendCode,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xfff7dc99),
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  Widget _getStartedTitle({required IAppThemeData appTheme}) {
    return Center(
      child: GeneralText(
        Strings.letsGetTitle,
        textAlign: TextAlign.center,
        style: appTheme.typographies.interFontFamily.headline4.copyWith(
            color: const Color(0xfff1c452),
            fontSize: 28,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _getStartedButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      title: Strings.getStartedButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => SignUpScreen()),
        // );
        //    viewModel.goToForgotPasswordScreen();
      },
    );
    GeneralText(
      Strings.getStartedButtonTitle,
      style: appTheme.typographies.interFontFamily.headline2,
    );
  }

  Future<dynamic> _showVerificationPopup(BuildContext context) async {
    final appTheme = AppTheme.of(context).theme;
    final TextController _otpController = TextController();

    return DialogHelper.show(
      context: context,
      // dialogType: GeneralComponentStyle.success,
      isDismissible: true,
      barrierLabel: '',

      // title: 'Verification\nCode',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GeneralText(
              Strings.verificationPopupTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  color: appTheme.colors.secondaryBackground,
                  fontSize: 24,
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 14,
            ),
            GeneralText(
              Strings.verificationPopupSubtitle,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: appTheme.colors.secondaryBackground,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 34,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: PinCodeTextField(
                controller: _otpController,

                length: 4,
                cursorColor: appTheme.colors.secondaryBackground,

                textStyle: TextStyle(
                  color: appTheme.colors.secondaryBackground,
                ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  selectedColor: Color(0xfff1c452),
                  disabledColor: Color(0xfff1c452),
                  inactiveColor: Color(0xfff1c452),
                  inactiveFillColor: Color(0xff35353C),
                  activeColor: Color(0xff35353C),
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 58,
                  fieldWidth: 65,
                  selectedFillColor: Color(0xff35353C),
                  activeFillColor: Color(0xff35353C),
                ),
                obscureText: false,
                keyboardType: TextInputType.number,

                enableActiveFill: true,
                // validator: (value) {
                //   String? validationText =getIt<Localization>().mtLocalized("otp_enterOTP");
                //       "Fields cannot be empty";
                //   if (value!.length == AppConstants.otpLength) {
                //     validationText = null;
                //   }
                //   return validationText;
                // },
                animationType: AnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                //errorAnimationController: errorController, // Pass it here
                onChanged: (value) {
                  if (viewModel.verifyInputForm(
                    name: _nameController.text,
                    brandName: _brandController.text,
                    mobileNumber: _mobileNumberController.text,
                    address: _addressController.text,
                    town: viewModel.townController.text,
                    city: viewModel.cityController.text,
                  )) {
                    viewModel.changeButton(true);
                  } else {
                    viewModel.changeButton(false);
                  }
                },
                onSubmitted: (value) {},
                appContext: context,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GeneralButton.button(
              title: Strings.verificationPopupButton.toUpperCase(),
              styleType: ButtonStyleType.fill,
              width: 170,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUpQuestionireScreen()),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                // );
                //    viewModel.goToForgotPasswordScreen();
              },
            ),
            SizedBox(
              height: 22,
            ),
            GeneralText(
              Strings.verificationPopupResendCode,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xfff7dc99),
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      // body: GBottomSheet<String>(
      //   bottomSheetTitle: Strings.chooseDateFormat,
      //   list: ['7878,87,876'],
      //   selectedItem: viewModel.getSelectedFormat(),
      //   bottomSheetType: BottomSheetType.dateFormat,
      // ),
    );
  }
}

class CityDisplay extends StatelessWidget {
  CityDisplay({
    Key? key,
    required this.appTheme,
    required this.townDropDown,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final dynamic townDropDown;

  final _signUpScreenViewModel = locateService<SignUpScreenViewModel>();
  var _myCity = '';

  @override
  Widget build(BuildContext context) {
    // return GeneralDropdown(
    //   name: 'Select',
    //   items: townDropDown,
    //   borderColor: appTheme.colors.textFieldBorderColor,
    //   // selectedItem: dropdownItems.first,
    //   style: appTheme.typographies.interFontFamily.headline6.copyWith(
    //       color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
    //   onChange: ({
    //     required String key,
    //     required dynamic value,
    //   }) {
    //     developer.log(' Key is ' + '${key}');
    //     developer.log(' Value is ' + '${value}');
    //
    //     //  viewModel.getCityId(value);
    //     //   viewModel.professionID = viewModel.dropdownDetails[value];
    //   },
    // );

    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: _myCity,
                  iconSize: 30,
                  icon: (null),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  hint: Text('Select State'),
                  onChanged: (String? newValue) {
                    //      setState(() {
                    _myCity = newValue!;
                    // _getCitiesList();
                    print(_myCity);
                    //   });
                  },
                  items: _signUpScreenViewModel.cityDropDown.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item),
                          value: item,
                          //value: item['id'].toString(),
                        );
                      }).toList() ??
                      [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TownDisplay extends StatelessWidget {
  const TownDisplay({
    Key? key,
    required this.appTheme,
    required this.townDropDown,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final dynamic townDropDown;

  @override
  Widget build(BuildContext context) {
    return GeneralDropdown(
      name: 'Select',
      items: townDropDown,
      borderColor: appTheme.colors.textFieldBorderColor,
      // selectedItem: dropdownItems.first,
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
      onChange: ({
        required String key,
        required dynamic value,
      }) {
        developer.log(' Key is ' + key);
        developer.log(' Value is ' + '${value}');

        //  viewModel.getCityId(value);
        //   viewModel.professionID = viewModel.dropdownDetails[value];
      },
    );
  }
}
