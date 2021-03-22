import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/screens/dashboard/consultancyRates/setMonthlyPlan.dart';
import 'package:thcDoctorMobile/screens/dashboard/consultancyRates/setOneOffPlan.dart';
import 'package:thcDoctorMobile/screens/dashboard/consultancyRates/setYearlyPlan.dart';
import 'package:thcDoctorMobile/screens/dashboard/index.dart';

class ConsultancyIndex extends StatefulWidget {
  ConsultancyIndex({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ConsultancyIndexState createState() => _ConsultancyIndexState();
}

class _ConsultancyIndexState extends State<ConsultancyIndex> {
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
                        SizedBox(height: 15),
                        HeaderText(title: 'Consltancy Rates'),
                        SizedBox(height: 10),
                        SubText(
                            isCenter: false,
                            title: 'Manage your consultancy rates.'),
                        SizedBox(height: 60),
                        Text(
                          'Available Rate Plans',
                          style: TextStyle(
                              color: Color(0xff245DE8),
                              fontSize: sizer(true, 16, context),
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 15),
                        rateWidget('Monthly', false, false,
                            SetMonthlyConsultancyPlan()),
                        rateWidget(
                            'Yearly',
                            true,
                            false,
                            SetYearlyConsultancyPlan(),
                            "NGN 25,000",
                            true,
                            "300 Sessions"),
                        rateWidget(
                            'One-time',
                            true,
                            true,
                            SetOneOffConsultancyPlan(),
                            "NGN 5,000 per session",
                            false),
                      ]),
                )))));
  }

  Widget rateWidget(String title, bool isRateSet, bool last, Widget route,
      [String rate, bool isSplit, String suffix]) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Material(
            // color: Color(0xfff3f4f8),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => route),
                  );
                },
                child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    decoration: BoxDecoration(
                        color: white,
                        border: Border(
                            bottom: last
                                ? BorderSide.none
                                : BorderSide(
                                    color: Color(0xffF3F4F8), width: 0.8))),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(title,
                                    style: TextStyle(
                                      fontSize: sizer(true, 16, context),
                                      color: Color(0xff071232),
                                    )),
                                SizedBox(height: 8),
                                !isRateSet
                                    ? SubText(
                                        isCenter: false, title: 'Rate not set')
                                    : Row(
                                        children: [
                                          Text(rate,
                                              style: TextStyle(
                                                fontSize:
                                                    sizer(true, 16, context),
                                                color: Color(0xff2254D3),
                                                fontWeight: FontWeight.normal,
                                              )),
                                          isSplit
                                              ? Container(
                                                  height: 5,
                                                  width: 5,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 7),
                                                  decoration: BoxDecoration(
                                                    color: blue,
                                                    shape: BoxShape.circle,
                                                  ),
                                                )
                                              : SizedBox(),
                                          isSplit
                                              ? Text(suffix,
                                                  style: TextStyle(
                                                    fontSize: sizer(
                                                        true, 16, context),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xff2254D3),
                                                  ))
                                              : SizedBox(),
                                        ],
                                      ),
                              ]),
                          Spacer(),
                          Material(
                            color: Color(0xffF3F4F8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F4F8),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                    child: Icon(Icons.chevron_right,
                                        size: 24, color: Color(0xff091118))),
                              ),
                            ),
                          ),
                        ])))));
  }
}
