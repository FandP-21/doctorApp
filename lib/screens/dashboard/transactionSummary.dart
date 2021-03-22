import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';

class TransactionSummary extends StatefulWidget {
  TransactionSummary({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TransactionSummaryState createState() => _TransactionSummaryState();
}

class _TransactionSummaryState extends State<TransactionSummary> {
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
                        HeaderText(title: 'Transaction Summary'),
                        SizedBox(height: 35),
                        SubText(
                          title: 'Description',
                          isCenter: false,
                        ),
                        SizedBox(height: 3),
                        Text(
                          'An apt description would be nice',
                          style: TextStyle(
                              color: Color(0xff071232),
                              fontSize: sizer(true, 18, context)),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SubText(
                                    title: 'Amount',
                                    isCenter: false,
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    'NGN 2,500',
                                    style: TextStyle(
                                        color: Color(0xff071232),
                                        fontSize: sizer(true, 18, context)),
                                  ),
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SubText(
                                    title: 'Date',
                                    isCenter: false,
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    '16 July, 2020',
                                    style: TextStyle(
                                        color: Color(0xff071232),
                                        fontSize: sizer(true, 18, context)),
                                  ),
                                ]),
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SubText(
                                    title: 'Status',
                                    isCenter: false,
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    'Successful',
                                    style: TextStyle(
                                        color: Color(0xff22D389),
                                        fontSize: sizer(true, 18, context)),
                                  ),
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SubText(
                                    title: 'Payment Method',
                                    isCenter: false,
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Mastercard',
                                        style: TextStyle(
                                            color: Color(0xff071232),
                                            fontSize: sizer(true, 18, context)),
                                      ),
                                      Container(
                                        width: 5,
                                        height: 5,
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        '3878',
                                        style: TextStyle(
                                            color: Color(0xff071232),
                                            fontSize: sizer(true, 18, context)),
                                      ),
                                    ],
                                  ),
                                ]),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SubText(
                                    title: 'Payment Reference',
                                    isCenter: false,
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    'DSJKQFDKF29392',
                                    style: TextStyle(
                                        color: Color(0xff071232),
                                        fontSize: sizer(true, 18, context)),
                                  ),
                                ]),
                          ],
                        ),
                      ]),
                )))));
  }
}
