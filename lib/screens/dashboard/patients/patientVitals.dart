import 'dart:io';
import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/buttonBlack.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';
import 'package:thcDoctorMobile/models/vitals.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientVitals extends StatefulWidget {
  PatientVitals({Key key, @required this.patientInfo}) : super(key: key);
  final PatientInfo patientInfo;
  @override
  _PatientVitalsState createState() => _PatientVitalsState();
}

class _PatientVitalsState extends State<PatientVitals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
                top: 50,
                left: sizer(true, 20, context),
                right: sizer(true, 20, context)),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: [
                    BackButtonWhite(onPressed: () => {}),
                    SizedBox(),
                  ]),
                  SizedBox(height: 25),
                  HeaderText(title: 'Patient Vitals'),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        threeDataVitalBox('BP', widget.patientInfo.bp, 'mm/Hg',
                            'good', width(47, true, context)),
                        threeDataVitalBox(
                            'Weight',
                            widget.patientInfo.weight ?? 'N/A',
                            'Kg',
                            '',
                            width(39, true, context),
                            Color.fromRGBO(34, 84, 211, 1)),
                      ],
                    ),
                  ),
                  Container(
                      margin:
                          EdgeInsets.only(bottom: sizer(false, 16, context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          threeDataVitalBox(
                              'BMI',
                              widget.patientInfo.weight != null
                                  ? (int.parse(widget.patientInfo.weight) /
                                          ((int.parse(widget
                                                      .patientInfo.height) /
                                                  100) *
                                              (int.parse(widget
                                                      .patientInfo.height) /
                                                  100)))
                                      .toStringAsFixed(2)
                                  : 'N/A',
                              '',
                              'underweight',
                              width(56, true, context),
                              Color.fromRGBO(255, 111, 79, 1)),
                          SizedBox(width: 16.0),
                          threeDataVitalBoxLinear(
                              'Height',
                              widget.patientInfo.height ?? 'N/A',
                              'cm',
                              '',
                              width(30, true, context),
                              Color.fromRGBO(34, 84, 211, 1)),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: sizer(false, 16, context),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        threeDataVitalBox(
                            'BloodOxygen',
                            widget.patientInfo.bloodOxygen,
                            '%',
                            'good',
                            width(56, true, context)),
                        SizedBox(width: 16.0),
                        threeDataVitalBoxLinear(
                            'Pulse',
                            widget.patientInfo.pulse,
                            'bpm',
                            '',
                            width(30, true, context)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: sizer(false, 16, context),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        threeDataVitalBox(
                            'Temperature',
                            widget.patientInfo.temperature,
                            'DegC',
                            'good',
                            width(90, true, context)),
                      ],
                    ),
                  ),
                ])),
      ),
    );
  }

  Widget threeDataVitalBox(
      String title, String value, String unit, String quality, double width,
      [Color color]) {
    return Container(
      width: width,
      height: 100,
      padding: EdgeInsets.symmetric(
          horizontal: sizer(true, 14, context), vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xffF3F4F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: black,
                    fontSize: pixel16,
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.clip,
                softWrap: true,
              ),
              SizedBox(height: 5),
              Text(
                unit,
                style: TextStyle(
                    color: Color(0xff8E919C),
                    fontSize: pixel16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                value != null && value != '' ? value.toString() : 'N/A',
                style: TextStyle(
                    color: color ?? Color(0xff22D389),
                    fontSize: pixel36,
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              quality != null && quality != ''
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xffDFE8FC),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        quality,
                        style: TextStyle(
                          color: Color(0xff2254D3),
                          fontSize: sizer(true, 14, context),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Widget threeDataVitalBoxLinear(
      String title, String value, String unit, String quality, double width,
      [Color color]) {
    return Container(
      width: width,
      height: 100,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: sizer(true, 14, context), vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xffF3F4F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: black,
                fontSize: pixel16,
                height: 1.0,
                fontWeight: FontWeight.w500),
          ),
          Text(
            value != null && value != '' ? value.toString() : 'N/A',
            style: TextStyle(
                color: color ?? Color(0xff22D389),
                fontSize: pixel36,
                height: 1.2,
                fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            unit,
            style: TextStyle(
                color: Color(0xff8E919C),
                fontSize: pixel12,
                height: 1.0,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
