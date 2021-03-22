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
import 'package:thcDoctorMobile/components/backButtonWhite.dart';

class LinkedDevices extends StatefulWidget {
  LinkedDevices({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LinkedDevicesState createState() => _LinkedDevicesState();
}

class _LinkedDevicesState extends State<LinkedDevices> {
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
                child: new SingleChildScrollView(
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
                          ],
                        ),
                        SizedBox(height: 20),
                        HeaderText(title: 'Linked devices'),
                        SizedBox(height: 38),
                        phoneBox('IPHONE XR'),
                        phoneBox('SAMSUNG S8'),
                        phoneBox('SAMSUNG S8'),
                        phoneBox('SAMSUNG S8')
                      ]),
                )))));
  }

  Widget phoneBox(String title) {
    return Container(
        height: 58,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: EdgeInsets.only(bottom: sizer(false, 13, context)),
        decoration: BoxDecoration(
          color: Color(0xffF3F4F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/deviceIcon.png',
                height: 25,
              ),
              SizedBox(
                width: 18.5,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(title,
                      style:
                          TextStyle(color: Color(0xff071232), fontSize: 16))),
              Spacer(),
              Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: Color(0xff436dda),
                  child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Color(0xfff4e3e3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.delete,
                            size: 20,
                            color: Color(0xffFF6F4F),
                          ))))
            ]));
  }
}
