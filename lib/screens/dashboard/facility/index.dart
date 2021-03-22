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
import 'package:thcDoctorMobile/components/searchTextInput.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'chooseFacility.dart';

class FacilityIndex extends StatefulWidget {
  FacilityIndex({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FacilityIndexState createState() => _FacilityIndexState();
}

class _FacilityIndexState extends State<FacilityIndex> {
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
                        HeaderText(title: 'Rent a facility'),
                        SizedBox(
                          height: 5,
                        ),
                        SubText(
                            isCenter: false,
                            title: 'Book a facility at a hospital for use.'),
                        SizedBox(height: 45),
                        Text(
                          'Select a hospital',
                          style:
                              TextStyle(color: Color(0xff245DE8), fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        SearchTextInput(hintText: 'Search'),
                        SizedBox(height: 5),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (BuildContext context, int index) =>
                                  hospital('Lagoon hospitals')),
                        )
                      ]),
                ))));
  }

  Widget hospital(String name) {
    return Material(
        color: Colors.white,
        child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ChooseFacility(title: name)));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xffF3F4F8), width: 0.8))),
              child: Text(name,
                  style: TextStyle(color: Color(0xff071232), fontSize: 16)),
            )));
  }
}
