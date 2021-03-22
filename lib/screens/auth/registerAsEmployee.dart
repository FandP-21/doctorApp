import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/authEmailInput.dart';
import 'package:thcDoctorMobile/components/authPhoneInput.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'components/registerHospitalSuccess.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/provider/user.dart';

class RegisterAsEmployee extends StatefulWidget {
  RegisterAsEmployee(
      {Key key,
      @required this.hospitalName,
      @required this.hospitalId,
      @required this.independent,
      @required this.passedPhoneNumber,
      @required this.passedEmail,
      @required this.practice})
      : super(key: key);
  final String hospitalName;
  final bool independent;
  final bool practice;
  final String passedPhoneNumber;
  final String passedEmail;
  final int hospitalId;

  @override
  _RegisterAsEmployeeState createState() => _RegisterAsEmployeeState();
}

class _RegisterAsEmployeeState extends State<RegisterAsEmployee> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool loading = false;
  String otp;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController email = new TextEditingController();
  final TextEditingController staffNumber = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> setEmployeeStaffNumber() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    setState(() => loading = true);
    var response = await http.patch(url + 'doctor/' + id + '/', body: {
      "employee_staff_number": staffNumber.text,
    }, headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    print(jsonDecode(response.body));
    setState(() => loading = false);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterHospitalSuccess(
              independent: widget.independent,
              passedPhoneNumber: widget.passedPhoneNumber,
              practice: widget.practice,
              title: widget.hospitalName),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: LoadingOverlay(
          child: SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: sizer(false, 100, context),
                          left: 20,
                          right: 20,
                          bottom: 30),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            HeaderText(title: 'Register as employee'),
                            SizedBox(height: 5),
                            SubText(
                              title:
                                  'Please enter your work email and staff number to register as an employee of Cedar group hospital.',
                              isCenter: false,
                            ),
                            SizedBox(height: sizer(false, 96, context)),
                            new Form(
                              key: _formKey,
                              autovalidate: _autoValidate,
                              child: customForm(),
                            )
                          ])))),
          isLoading: loading,
        ));
  }

  Widget customForm() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
              child: AuthEmailInput(hintText: 'Work email', controller: email),
            ),
            Container(
              margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
              child: AuthPhoneInput(
                  hintText: 'Employee/Staff number', controller: staffNumber),
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(height: 10),
        ButtonBlue(onPressed: setEmployeeStaffNumber, title: 'CONTINUE'),
      ],
    ));
  }
}
