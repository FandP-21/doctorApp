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

class MenuDropdown extends StatefulWidget {
  MenuDropdown({Key key, @required this.title, this.onPressed})
      : super(key: key);
  final String title;
  final GestureTapCallback onPressed;

  @override
  _MenuDropdownState createState() => _MenuDropdownState();
}

class _MenuDropdownState extends State<MenuDropdown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            color: Colors.transparent,
            //       color: Color(0xff245DE8),
            child: GestureDetector(
                onTap: widget.onPressed,
                child: Container(
                    margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
                    padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffF3F4F8),
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
                              style: TextStyle(
                                  color: Color(0xff2254D3), fontSize: 16)),
                          Icon(Icons.keyboard_arrow_down,
                              size: 20, color: Color(0xff2254D3))
                        ])))));
  }
}
