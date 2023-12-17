import 'package:chef/screens/sign_in/sign_in_screen_vm.dart';
import 'package:chef/screens/sign_up/sign_up_screen_vm.dart';
import 'package:chef/setup.dart';

import '../../helpers/helpers.dart';

import 'dart:developer' as developer;

import '../../models/signup/responses/city_response.dart';

class CityTownHelper extends StatefulWidget {
  const CityTownHelper(
      {required List<String> cityDropDown,
      required CityResponse cityResponse,
      required List<String> townDropDown,
      required Map<String, List<String>> cityTownInfo,
      required TextController townController,
      required TextController cityController,
      Key? key})
      : _cityDropDown = cityDropDown,
        _cityResponse = cityResponse,
        _townDropDown = townDropDown,
        _cityTownInfo = cityTownInfo,
        _townController = townController,
        _cityController = cityController,
        super(key: key);

  final List<String> _cityDropDown;
  final List<String> _townDropDown;
  final CityResponse _cityResponse;
  final Map<String, List<String>> _cityTownInfo;
  final TextController _townController;
  final TextController _cityController;
  // const CityTownHelper({Key? key})
  //     :
  //
  //       //  _cityDropDown = cityDropDown,
  //       super(key: key);

//  final _cityDropDown;

  @override
  _CityTownHelperState createState() => _CityTownHelperState();
}

class _CityTownHelperState extends State<CityTownHelper> {
  var _myCity = '';
  var _myTown = '';

  List<String> townData = [];

  final _signUpScreenViewModel = locateService<SignUpScreenViewModel>();
  final appTheme = locateService<IAppThemeData>();

  @override
  void initState() {
    _myCity = widget._cityDropDown.first;
    _myTown = widget._cityTownInfo.isNotEmpty
        ? widget._cityTownInfo[_myCity]!.first
        : '';
    townData =
        widget._cityTownInfo.isNotEmpty ? widget._cityTownInfo[_myCity]! : [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return displayCityList();
  }

  Widget displayCityList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralText(
                Strings.signCityLabel,
                textAlign: TextAlign.center,
                style: appTheme.typographies.interFontFamily.headline4.copyWith(
                    color: const Color(0xfffbeccb),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              displayCity(),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralText(
                Strings.signTownLabel,
                textAlign: TextAlign.center,
                style: appTheme.typographies.interFontFamily.headline4.copyWith(
                    color: const Color(0xfffbeccb),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              widget._cityTownInfo.isNotEmpty ? displayTown() : Container(),
            ],
          ),
        ),
      ],
    );
  }

  Widget displayCity() {
    return GeneralDropdown(
        items: widget._cityDropDown,
        name: 'Select City',
        initialValue: '',
        hintWidget: const Text(
          'Select City',
          style: TextStyle(color: Colors.white),
        ),
        borderColor: appTheme.colors.textFieldBorderColor,
        style: appTheme.typographies.interFontFamily.headline6.copyWith(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        onChange: ({
          required String key,
          required dynamic value,
        }) {
          setState(() {
            _myCity = value!;
            widget._cityController.text = _myCity;
            townData = widget._cityTownInfo.isNotEmpty
                ? widget._cityTownInfo[_myCity]!
                : [];
            _myTown = townData.isNotEmpty ? townData.first : 'F 7';
          });
        });
  }

  Widget displayTown() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: SizedBox(
                height: 53.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appTheme.colors.textFieldBorderColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _myTown,
                        dropdownColor: Colors.grey,
                        iconEnabledColor: appTheme.colors.textFieldBorderColor,
                        iconSize: 25,
                        icon: (null),
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                        hint: Text(
                          'Select Town',
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _myTown = newValue!;
                            widget._townController.text = _myTown;
                          });
                        },
                        items: townData.map((item) {
                              return DropdownMenuItem(
                                child: Text(item),
                                value: item.toString(),
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                  ),
                )),
          )
        ]);
  }
}
