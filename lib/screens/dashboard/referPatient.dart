import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/multiInput.dart';
import 'package:thcDoctorMobile/components/authSelectInput.dart';
import 'package:thcDoctorMobile/components/authTextInput.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import '../components/checkListItem.dart';

class ReferPatient extends StatefulWidget {
  ReferPatient({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ReferPatientState createState() => _ReferPatientState();
}

class _ReferPatientState extends State<ReferPatient> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(children: <Widget>[
                  new SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.only(
                        top: sizer(false, 50, context), left: 20, right: 20),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    borderRadius: BorderRadius.circular(10.0),
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
                          HeaderText(title: 'Refer patient'),
                          SizedBox(height: 5),
                          Text('Refer Kalu to a hospital, pharmacy or lab',
                              style: TextStyle(
                                  color: Color(0xff071232), fontSize: 16)),
                          SizedBox(height: 26),
                          AuthSelectInput(hintText: 'Select hospital'),
                          SizedBox(height: 10),
                          AuthSelectInput(hintText: 'Select institution'),
                          SizedBox(height: 10),
                          MultiInput(hintText: 'Enter a reason for referral'),
                          SizedBox(height: 10),
                          CheckListItem(title: 'Share consultant notes')
                        ]),
                  )),
                  Positioned(
                      bottom: 30,
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: ButtonBlue(
                                title: 'REFER PATIENT',
                                onPressed: () {},
                              ))))
                ]))));
  }
}
