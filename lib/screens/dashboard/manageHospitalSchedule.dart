import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/components/calendarSchedule.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue50.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';

List<String> days = [
  'MONDAY',
  'TUESDAY',
  'WEDNESDAY',
  'THURSDAY',
  'FRIDAY',
  'SATURDAY',
  'SUNDAY',
];

class ManageHospitalSchedule extends StatefulWidget {
  ManageHospitalSchedule({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ManageHospitalScheduleState createState() => _ManageHospitalScheduleState();
}

class _ManageHospitalScheduleState extends State<ManageHospitalSchedule> {
  @override
  void initState() {
    super.initState();
    recallHistory();
  }

  List<dynamic> selections = [
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
  ];
  bool singleTimestamp = true;
  bool loading = false;
  String _title = '1hr booking interval';
  updateState(day, index) {
    if (selections[day][index] >= 0)
      setState(() => selections[day][index] = -1);
    else
      setState(() => selections[day][index] = index);
    print("$day $index");
  }

  void recallHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("mondayHospital"))
      setState(() => selections = [
            jsonDecode(prefs.getString("mondayHospital")),
            jsonDecode(prefs.getString("tuesdayHospital")),
            jsonDecode(prefs.getString("wednesdayHospital")),
            jsonDecode(prefs.getString("thursdayHospital")),
            jsonDecode(prefs.getString("fridayHospital")),
            jsonDecode(prefs.getString("saturdayHospital")),
            jsonDecode(prefs.getString("sundayHospital")),
          ]);
  }

  List<String> singleStepTimeline = [
    '8 AM',
    '9 AM',
    '10 AM',
    '11 AM',
    '12 PM',
    '1 PM',
    '2 PM',
    '3 PM',
    '4 PM',
    '5 PM',
    '6 PM',
    '7 PM',
    '8 PM',
  ];
  List<String> doubleStepTimeline = [
    '8 AM',
    '10 AM',
    '12 PM',
    '2 PM',
    '4 PM',
    '6 PM',
    '8 PM'
  ];

  Future saveSchedule() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("mondayHospital", jsonEncode(selections[0]));
    await prefs.setString("tuesdayHospital", jsonEncode(selections[1]));
    await prefs.setString("wednesdayHospital", jsonEncode(selections[2]));
    await prefs.setString("thursdayHospital", jsonEncode(selections[3]));
    await prefs.setString("fridayHospital", jsonEncode(selections[4]));
    await prefs.setString("saturdayHospital", jsonEncode(selections[5]));
    await prefs.setString("sundayHospital", jsonEncode(selections[6]));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: LoadingOverlay(
                isLoading: loading,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: sizer(false, 50, context), bottom: 100),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          BackButtonWhite(
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      HeaderText(
                                          title: 'Manage hospital schedule'),
                                      SizedBox(height: 10),
                                      SubText(
                                          isCenter: false,
                                          title:
                                              'Set your available days and times for the week'),
                                      SizedBox(height: 25),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: sizer(false, 16, context)),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(color: blue),
                                        ),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.only(
                                              left: 20, top: 7, right: 20),
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Color(0xffF3F4F8),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: DropdownButton<dynamic>(
                                            hint: Text(
                                              _title,
                                              style: TextStyle(
                                                  color: Color(0xff2254D3),
                                                  fontFamily: 'SofiaPro',
                                                  fontSize: sizer(
                                                      true, 16.0, context)),
                                            ),
                                            items: [
                                              '1hr booking interval',
                                              '2hr booking interval'
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
                                            onChanged: (value) {
                                              if (value ==
                                                  '1hr booking interval')
                                                setState(() =>
                                                    singleTimestamp = true);
                                              else
                                                setState(() =>
                                                    singleTimestamp = false);
                                            },
                                            isExpanded: true,
                                            style: TextStyle(
                                                color: Color(0xff828A95),
                                                fontFamily: 'SofiaPro',
                                                fontSize: 14),
                                            underline: SizedBox(),
                                            dropdownColor: Colors.white,
                                            iconDisabledColor:
                                                Color(0xff2254D3),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 20,
                                              color: Color(0xff2254D3),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(height: 5),
                              Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 7,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              CalendarSchedule(
                                                  selections: selections[index],
                                                  index: index,
                                                  day: days[index],
                                                  time: singleTimestamp
                                                      ? singleStepTimeline
                                                      : doubleStepTimeline,
                                                  callback: updateState)))
                            ]),
                      ),
                      Positioned(
                          bottom: 0,
                          child: Container(
                              height: 100,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 150,
                                      child: Text(
                                          'You can change your schedule for every week.',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff8E919C))),
                                    ),
                                    ButtonBlue50(
                                      title: 'SAVE SCHEDULE',
                                      onPressed: () {
                                        setState(() => loading = true);
                                        Future.delayed(Duration(seconds: 4),
                                            () {
                                          saveSchedule();
                                          setState(() => loading = false);
                                          Fluttertoast.showToast(
                                              msg: "Succesful");
                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  ])))
                    ])))));
  }
}
