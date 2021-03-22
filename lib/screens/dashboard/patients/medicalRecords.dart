import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';

class MedicalRecords extends StatefulWidget {
  MedicalRecords({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MedicalRecordsState createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                      top: sizer(false, 50, context),
                      left: sizer(true, 20, context),
                      right: sizer(true, 20, context)),
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
                        SizedBox(height: sizer(false, 15, context)),
                        HeaderText(title: 'Medical Records'),
                        SizedBox(height: 35),
                        Container(
                            margin: EdgeInsets.only(
                                bottom: sizer(false, 10, context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                    child: recordBox('Patient profile',
                                        'Updated 12/08/2020')),
                                SizedBox(width: 10.0),
                                Expanded(
                                    child: recordBox('Patient history',
                                        'Updated 12/08/2020')),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                bottom: sizer(false, 10, context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                    child: recordBox(
                                        'Diagnosis', 'Updated 12/08/2020')),
                                SizedBox(width: 10.0),
                                Expanded(
                                    child: recordBox(
                                        'Prescriptions', 'Updated 12/08/2020')),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                bottom: sizer(false, 10, context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                    child: recordBox(
                                        'Examinations', 'Updated 12/08/2020')),
                                SizedBox(width: 10.0),
                                Expanded(
                                    child: recordBox('Investigation Results',
                                        'Updated 12/08/2020')),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                bottom: sizer(false, 10, context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                    child: recordBox(
                                        'Test Results', 'Updated 12/08/2020')),
                                SizedBox(width: 10.0),
                                Expanded(
                                    child: recordBox(
                                        'Notes', 'Updated 12/08/2020')),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                bottom: sizer(false, 10, context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                    child: recordBox(
                                        'Logs', 'Updated 12/08/2020')),
                                SizedBox(width: 10.0),
                                Opacity(
                                    opacity: 0,
                                    child: Expanded(
                                        child: recordBox('Patient history',
                                            'Updated 12/08/2020'))),
                              ],
                            )),
                      ]),
                )))));
  }

  Widget recordBox(String title, String date) {
    return Container(
      height: 106,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          color: Color(0xffF3F4F8), borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Column(
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context),
                      fontWeight: FontWeight.w500)),
              Text(date,
                  style: TextStyle(color: Color(0xff8E919C), fontSize: 12)),
            ],
          ),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 45.02,
                  height: 37.13,
                  decoration: BoxDecoration(
                      color: Color(0xff2254D3),
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(45.02 / 2),
                          bottomRight: const Radius.circular(10))),
                  child: Center(
                      child: Icon(Icons.arrow_forward,
                          color: Colors.white, size: 11)),
                )
              ])
        ],
      ),
    );
  }
}
