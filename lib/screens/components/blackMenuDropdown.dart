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

class BlackMenuDropdown extends StatefulWidget {
  BlackMenuDropdown({Key key, @required this.title, this.onPressed})
      : super(key: key);
  final String title;
  final GestureTapCallback onPressed;

  @override
  _BlackMenuDropdownState createState() => _BlackMenuDropdownState();
}

class _BlackMenuDropdownState extends State<BlackMenuDropdown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            //   color: Colors.transparent,
            color: Color(0xff0C1941),
            child: GestureDetector(
                onTap: widget.onPressed,
                child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xff0C1941),
                      borderRadius: BorderRadius.circular(10.0),
                      // border: Border(
                      //     bottom: BorderSide(
                      //         color: Color(0xffF3F4F8), width: 0.8))
                    ),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.title,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Icon(Icons.keyboard_arrow_down,
                              size: 20, color: Colors.white)
                        ])))));
  }
}
