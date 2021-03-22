import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class SetOneOffConsultancyPlan extends StatefulWidget {
  SetOneOffConsultancyPlan({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SetOneOffConsultancyPlanState createState() =>
      _SetOneOffConsultancyPlanState();
}

class _SetOneOffConsultancyPlanState extends State<SetOneOffConsultancyPlan> {
  @override
  void initState() {
    super.initState();
  }

  String _title = 'Select Currency';

  Future saveOptions() {
    Fluttertoast.showToast(msg: "Saved");
    Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(
                    top: sizer(false, 50, context),
                    left: 20,
                    right: 20,
                    bottom: 30),
                child: Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                BackButtonWhite(
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            HeaderText(title: 'Hourly Plan'),
                            SizedBox(height: 10),
                            SubText(
                                isCenter: false,
                                title: 'View and manage your hourly plan'),
                            SizedBox(height: 38),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 16, context)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: blue),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 20, top: 7, right: 20),
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F4F8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButton<dynamic>(
                                  hint: Text(
                                    _title,
                                    style: TextStyle(
                                        color: Color(0xff2254D3),
                                        fontFamily: 'SofiaPro',
                                        fontSize: sizer(true, 16.0, context)),
                                  ),
                                  items: [
                                    "Pounds",
                                    "Euro",
                                    "Dollar",
                                    "Naira",
                                    "Cedi",
                                    "Rand",
                                  ].map((value) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value,
                                      child: Text(value),
                                      onTap: () {
                                        setState(() {
                                          _title = value;
                                        });
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) => {},
                                  isExpanded: true,
                                  style: TextStyle(
                                      color: Color(0xff828A95),
                                      fontFamily: 'SofiaPro',
                                      fontSize: 14),
                                  underline: SizedBox(),
                                  dropdownColor: Colors.white,
                                  iconDisabledColor: Color(0xff2254D3),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Color(0xff2254D3),
                                  ),
                                ),
                              ),
                            ),
                            textfield('Session duration'),
                            textfield('Price per hour'),
                            SizedBox(height: 38),
                          ],
                        ),
                        ButtonBlue(
                          title: 'SAVE OPTIONS',
                          onPressed: saveOptions,
                        ),
                      ]),
                ))));
  }

  Widget textfield(suffix) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: TextFormField(
          onSaved: (text) {},
          style: TextStyle(
              color: Color(0xff071232),
              fontWeight: FontWeight.w500,
              fontSize: sizer(true, 16, context)),
          cursorColor: Color(0xff245DE8),
          decoration: InputDecoration(
            // suffixIcon: SkillsBox(title:suffix),
            contentPadding: EdgeInsets.all(20.0),
            fillColor: Color(0xffF3F4F8),
            hintText: suffix,
            hintStyle: TextStyle(color: Color(0xff828A95), fontSize: 16),
            errorMaxLines: 5,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1.5,
                color: Color(0xff245DE8),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
          ),
          validator: (val) {
            if (val.length == 0) {
              return "Password is required";
            }
          },
        ));
  }
}
