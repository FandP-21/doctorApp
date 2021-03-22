import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class ResendCodeTimer extends StatefulWidget {
  ResendCodeTimer(
      {Key key,
      @required this.start,
      @required this.loading,
      @required this.resendToken})
      : super(key: key);
  final bool loading;
  final Function resendToken;
  final int start;

  @override
  _ResendCodeTimerState createState() => _ResendCodeTimerState();
}

class _ResendCodeTimerState extends State<ResendCodeTimer> {
//   Timer _timer;
// int widget.start = 60;
  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  @override
  void dispose() {
//  _timer.cancel();
    super.dispose();
  }

  pad(int n) {
    return (n < 10) ? ("0" + n.toString()) : n.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.loading) {
      //    startTimer();
    }
    return Material(
        color: Color(0xffE7EEFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          // side: BorderSide(color: Colors.red)
        ),
        child: GestureDetector(
            onTap: widget.start < 1
                ? () {
                    widget.resendToken();
                  }
                : null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color:
                    widget.start > 1 ? Color(0xffE7EEFF) : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.start > 1 ? 'RESEND CODE IN ' : 'RESEND CODE',
                    style: TextStyle(
                        color: Color(0xff245DE8),
                        fontSize: sizer(true, 14.0, context),
                        fontWeight: FontWeight.w700),
                  ),
                  widget.start > 1
                      ? Text('00:' + pad(widget.start),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: sizer(true, 14.0, context),
                              fontWeight: FontWeight.w700))
                      : Container(),
                  SizedBox(width: 10),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Color(0xff245DE8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                        child: Icon(
                      Icons.keyboard_arrow_right,
                      size: 10.0,
                      color: Colors.white,
                    )),
                  )
                ],
              ),
            )));
  }
}
