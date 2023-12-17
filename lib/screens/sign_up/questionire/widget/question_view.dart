import '../../../../helpers/helpers.dart';
import '../../../../models/signup/responses/questionire_response.dart';

import 'dart:developer' as developer;

class QuestionView extends StatefulWidget {

  QuestionView({
    Key? key,
    required this.appTheme,
    required this.questionObj,
    required this.answerIdsInterests,
    required this.singleOptionAnswerId,
    required this.q1Controller, required this.q2Controller,

  }) : super(key: key);

  final IAppThemeData appTheme;

  QuestionsList questionObj;
  List<int> answerIdsInterests;
  List<int> singleOptionAnswerId;
  final TextController q1Controller;
  final TextController q2Controller;
  final TextController regularController = TextController();


  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(
        //   height: 27,
        // ),
        Container(
          // padding: EdgeInsets.only(left: 30),
          child: GeneralText(
            widget.questionObj.name,
            maxLines: 2,
            textAlign: TextAlign.left,
            style: widget.appTheme.typographies.interFontFamily.headline6
                .copyWith(
                    color: const Color(0xfffbeccb),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),

        widget.questionObj.type == "SINGLE_DROPDOWN"
            ? SingleOption(
                appTheme: widget.appTheme,
                answerList: widget.questionObj.answers,
                answersIds: widget.singleOptionAnswerId)
            : widget.questionObj.type == "MULTI_CHIP"
                ? MultiChipView(
                    answerIdsInterests: widget.answerIdsInterests,
                    appTheme: widget.appTheme,
                    answerList: widget.questionObj.answers)
                :
                // questionObj.type == "INPUT" ?
                InputField(appTheme: widget.appTheme,textValueController: widget.questionObj.id==5?widget.q1Controller:widget.questionObj.id==6?widget.q2Controller:widget.regularController,)
      ],
    );
  }
}

// class  extends StatefulWidget {
//   const ({Key? key}) : super(key: key);
//
//   @override
//   _State createState() => _State();
// }
//
// class _State extends State<> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class MultiChipView extends StatefulWidget {
  // const multiChipView({Key? key}) : super(key: key);

  MultiChipView({
    Key? key,
    required this.appTheme,
    required this.answerList,
    required this.answerIdsInterests,
  }) : super(key: key);

  final IAppThemeData appTheme;
  List<Answer> answerList;
  List<int> answerIdsInterests;

  @override
  _MultiChipViewState createState() => _MultiChipViewState();
}

class _MultiChipViewState extends State<MultiChipView> {
  Map<String, bool> selectedData = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, top: 4),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.5,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
        ),
        itemCount: widget.answerList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                setState(() {
                  if (selectedData.isEmpty) {
                    selectedData[widget.answerList[index].name] = true;
                  } else {
                    if (selectedData
                        .containsKey(widget.answerList[index].name)) {
                      if (selectedData[widget.answerList[index].name]!) {
                        selectedData[widget.answerList[index].name] = false;
                      } else {
                        selectedData[widget.answerList[index].name] = true;
                      }
                    } else {
                      selectedData[widget.answerList[index].name] = true;
                    }
                  }

                  widget.answerIdsInterests
                      .contains(widget.answerList[index].id)
                      ? widget.answerIdsInterests
                      .remove(widget.answerList[index].id)
                      : widget.answerIdsInterests.add(widget.answerList[index].id);
                  //  _selectedInterests.value.addAll(selectedData);
                  developer.log("$selectedData"' Here test ' "${widget.answerIdsInterests}");
                });
              },
              child: SizedBox(
                  height: 50,
                  child: ChipsWidget(
                    appTheme: widget.appTheme,
                    title: widget.answerList[index].name,
                    selected: selectedData != null &&
                            selectedData.isNotEmpty &
                                selectedData
                                    .containsKey(widget.answerList[index].name)
                        ? selectedData[widget.answerList[index].name]!
                        : false,
                  )));
        },
      ),
    );
  }
}

class InputField extends StatelessWidget {
  InputField({
    Key? key,
    required this.appTheme, required this.textValueController,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final TextController textValueController;


  @override
  Widget build(BuildContext context) {
    return GeneralTextInput(
        height: 80,
        controller: textValueController,
        inputType: InputType.text,
        isMultiline: true,
        backgroundColor: appTheme.colors.textFieldFilledColor,
        inputBorder: appTheme.focusedBorder,
        valueStyle: const TextStyle(color: Colors.white),
        hint: 'Please enter description here',
        hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
        onChanged: (newValue) {});
  }
}

class SingleOption extends StatefulWidget {
  SingleOption({
    Key? key,
    required this.appTheme,
    required this.answerList,
    required this.answersIds,
    this.title = '',
    this.selected = false,
    this.widthContainer = 130,
  }) : super(key: key);
  final IAppThemeData appTheme;
  List<Answer> answerList;
  List<int> answersIds;

  final String title;
  final bool selected;
  final double widthContainer;
  @override
  _SingleOptionState createState() => _SingleOptionState();
}

class _SingleOptionState extends State<SingleOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        child: ListView.builder(
            itemCount: widget.answerList.length,
            physics:
                const NeverScrollableScrollPhysics(), // BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(bottom: 9),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      color: widget.answersIds
                              .contains(widget.answerList[index].id)
                          ? const Color(0xfffee4a4)
                          : Colors.white),
                  padding: const EdgeInsets.all(12),
                  child: TextButton(
                      child: Row(
                        children: [
                          Image.asset(
                            widget.answersIds
                                    .contains(widget.answerList[index].id)
                                ? Resources.checkPNG
                                : Resources.ringPNG,
                            height: 22,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: GeneralText(
                              widget.answerList[index].name,
                              maxLines: 3,
                              textAlign: TextAlign.start,
                              style: widget.appTheme.typographies
                                  .interFontFamily.headline6
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      onPressed: () async {
                        setState(() {
                          widget.answersIds
                                  .contains(widget.answerList[index].id)
                              ? widget.answersIds
                                  .remove(widget.answerList[index].id)
                              : (widget.answersIds..clear())
                                  .add(widget.answerList[index].id);
                        });
                      }),
                ),
              );
            }));
  }
}
