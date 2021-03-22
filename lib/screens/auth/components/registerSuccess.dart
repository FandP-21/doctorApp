import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/screens/auth/components/setNotifications.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import '../addPhoto.dart';

class RegisterSuccess extends StatefulWidget {
  RegisterSuccess({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterSuccessState createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(
                    top: sizer(false, 176, context),
                    bottom: sizer(false, 134, context),
                    left: 20,
                    right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/sendIcon.png',
                      width: 140,
                      height: 140,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 57),
                        child: Text('You’ve successfully created a THC account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff071232), fontSize: 16)),
                      ),
                    ),
                    ButtonBlue(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => SetNotifications()),
                          );
                        },
                        title: 'CONTINUE'),
                  ],
                ))));
  }
}
