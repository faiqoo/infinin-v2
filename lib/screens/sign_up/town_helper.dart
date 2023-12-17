import 'package:chef/screens/sign_in/sign_in_screen_vm.dart';
import 'package:chef/screens/sign_up/sign_up_screen_vm.dart';
import 'package:chef/setup.dart';

import '../../helpers/helpers.dart';

import 'dart:developer' as developer;

class TownHelper extends StatefulWidget {
  const TownHelper({required List<String> townDropDown, Key? key})
      : _townDropDown = townDropDown,
        super(key: key);

  final List<String> _townDropDown;
  // const CityTownHelper({Key? key})
  //     :
  //
  //       //  _cityDropDown = cityDropDown,
  //       super(key: key);

//  final _cityDropDown;

  @override
  _TownHelperState createState() => _TownHelperState();
}

class _TownHelperState extends State<TownHelper> {
  var _myTown = '';

  final _signUpScreenViewModel = locateService<SignUpScreenViewModel>();

  @override
  void initState() {
    developer.log(' Data of City Drop Down is ' +
        '${_signUpScreenViewModel.cityDropDown}');
    _myTown = widget._townDropDown.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return displayCityList();
  }

  Widget displayCityList() {
    // return Container(
    //   padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
    //   color: Colors.white,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: <Widget>[
    //       Expanded(
    //         child: DropdownButtonHideUnderline(
    //           child: ButtonTheme(
    //             alignedDropdown: true,
    //             child: DropdownButton<String>(
    //               value: _myCity,
    //               iconSize: 30,
    //               icon: (null),
    //               style: const TextStyle(
    //                 color: Colors.black54,
    //                 fontSize: 16,
    //               ),
    //               hint: const GeneralText('Select City'),
    //               onChanged: (String? newValue) {
    //                 setState(() {
    //                   _myCity = newValue!;
    //                   // _getCitiesList();
    //                   print(_myCity);
    //                 });
    //               },
    //               items: _signUpScreenViewModel.cityDropDown.map((item) {
    //                     return DropdownMenuItem(
    //                       child: GeneralText(item),
    //                       value: item,
    //                       //value: item['id'].toString(),
    //                     );
    //                   }).toList() ??
    //                   [],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          value: _myTown,
          iconSize: 30,
          icon: (null),
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          hint: const GeneralText('Select Town'),
          onChanged: (String? newValue) {
            setState(() {
              _myTown = newValue!;
              // _getCitiesList();
              print(_myTown);
            });
          },
          // items: _signUpScreenViewModel.cityDropDown.map((item) {
          items: widget._townDropDown.map((item) {
                developer.log(' Item Town is ' + '${item}');
                return DropdownMenuItem<String>(
                  child: GeneralText(item.toString()),
                  value: item.toString(),
                  // child: Text('test'),
                  // value: 'hello',
                  //value: item['id'].toString(),
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
