import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonRed.dart';
import 'package:thcDoctorMobile/components/authTextInput.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:http/http.dart' as http;
import 'package:thcDoctorMobile/models/patientInfo.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CreateHealthAlert extends StatefulWidget {
  CreateHealthAlert(
      {Key key,
      this.title,
      @required this.patientInfo,
      @required this.callback})
      : super(key: key);
  final String title;
  final PatientInfo patientInfo;
  final VoidCallback callback;

  @override
  _CreateHealthAlertState createState() => _CreateHealthAlertState();
}

class _CreateHealthAlertState extends State<CreateHealthAlert> {
  @override
  void initState() {
    super.initState();
    print(widget.patientInfo);
  }

  final TextEditingController alert = new TextEditingController();
  final TextEditingController min = new TextEditingController();
  String _title = 'Blood Pressure';
  bool loading = false;

  Future<dynamic> createAlert() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    Map<String, dynamic> body = {};
    if (!prefs.containsKey("alertsFor" + widget.patientInfo.user.email))
      prefs.setString("alertsFor" + widget.patientInfo.user.email, "[]");

    if (_title == 'Blood Pressure')
      setState(() => body = {"bp_alert": alert.text});
    else if (_title == 'Blood Oxygen')
      setState(() => body = {"blood_oxygen_alert": alert.text});
    else if (_title == 'Temperarture')
      setState(() => body = {"temperature_alert": alert.text});
    else if (_title == 'Body Mass Index')
      setState(() => body = {"bmi_alert": alert.text});
    setState(() => loading = true);
    var response = await http.patch(
        url + "patient-list/${widget.patientInfo.id}/",
        body: body,
        headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        });
    setState(() => loading = false);
    print(jsonDecode(response.body));
    Map<String, dynamic> newBody = {
      "title": "$_title",
      "alerts": "[${alert.text}, ${min.text}]"
    };
    List<dynamic> json = jsonDecode(
        prefs.getString("alertsFor" + widget.patientInfo.user.email));
    json.add(newBody);
    print(json);
    await prefs.setString(
        "alertsFor" + widget.patientInfo.user.email, jsonEncode(json));
    Fluttertoast.showToast(msg: "Succesful!");
    widget.callback();
    Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(children: <Widget>[
                  LoadingOverlay(
                      isLoading: loading,
                      child: SingleChildScrollView(
                          child: Padding(
                        padding: EdgeInsets.only(
                            top: sizer(false, 50, context),
                            left: 20,
                            right: 20),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  BackButtonWhite(
                                    onPressed: () {},
                                  ),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 11),
                                      decoration: BoxDecoration(
                                        color: Color(0xffF3F4F8),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                          child: Image.asset(
                                              'assets/images/file.png',
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.contain))),
                                ],
                              ),
                              SizedBox(height: 15),
                              HeaderText(title: 'Create health alert'),
                              SizedBox(height: 7),
                              SubText(
                                  title: "Monitor your patient’s vitals.",
                                  isCenter: false),
                              SizedBox(height: 26),
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
                                      'Blood Pressure',
                                      'Blood Oxygen',
                                      'Temperarture',
                                      'Body Mass Index',
                                    ].map((value) {
                                      return DropdownMenuItem<dynamic>(
                                        value: value,
                                        child: Text(value),
                                        onTap: () {
                                          setState(() => _title = value);
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
                              SizedBox(height: 30),
                              Container(
                                  height: 1,
                                  decoration:
                                      BoxDecoration(color: Color(0xffF3F4F8))),
                              SizedBox(height: 40),
                              AuthTextInput(
                                  hintText: 'Maximum blood pressure',
                                  controller: alert),
                              SizedBox(height: 13),
                              AuthTextInput(hintText: 'Minimum blood pressure', controller: min),
                            ]),
                      ))),
                  Positioned(
                      bottom: 30,
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: ButtonRed(
                                title: 'CREATE',
                                onPressed: createAlert,
                              ))))
                ]))));
  }
}
