import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/backButtonBlack.dart';
import 'package:thcDoctorMobile/components/mediumText.dart';
import 'package:thcDoctorMobile/components/searchTextInput.dart';

class Call extends StatefulWidget {
  Call({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CallState createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff245DE8),
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(children: <Widget>[
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset('assets/images/firstDoctor.png',
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.50),
                        Image.asset('assets/images/secondDoctor.png',
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.50),
                      ]),
                  Positioned(
                      top: sizer(null, 77, context),
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Icon(Icons.arrow_back,
                              color: Colors.white, size: 20))),
                  Positioned(
                      bottom: 30,
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                          child: Icon(Icons.mic,
                                              color: Color(0xff245de8),
                                              size: 24))),
                                  Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                          child: Icon(Icons.call_end,
                                              color: Colors.white, size: 24))),
                                  Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                          child: Icon(Icons.videocam,
                                              color: Color(0xff245de8),
                                              size: 24))),
                                ],
                              ))))
                ]))));
  }
}
