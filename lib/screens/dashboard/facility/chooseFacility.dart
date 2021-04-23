import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/emptyData.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/skillsBox.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/models/facilitydata.dart';
import 'package:thcDoctorMobile/models/hospital.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'bookFacility.dart';
import 'package:http/http.dart' as http;

class ChooseFacility extends StatefulWidget {
  ChooseFacility({Key key, this.hospital}) : super(key: key);
  final Hospital hospital;

  @override
  _ChooseFacilityState createState() => _ChooseFacilityState();
}

class _ChooseFacilityState extends State<ChooseFacility> {
  bool value = false;
  bool hospitalsLoading = false;

  List<dynamic> facilityitem = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchHospitals();
    }
  }

  Future fetchHospitals() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    setState(() => hospitalsLoading = true);

    var response = await http
        .get(url + 'facility/' + widget.hospital.id.toString(), headers: {
      "Content-Type": "application/json",
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    setState(() => hospitalsLoading = false);
    print(response.body);
    setState(() => {
          facilityitem = jsonDecode(response.body),
          print('====facilityitem' + facilityitem.length.toString()),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingOverlay(
            child: SafeArea(
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
                              height: 8,
                            ),
                            SubText(
                                isCenter: false,
                                title:
                                    'Book a facility at a hospital for use.'),
                            SizedBox(height: 45),
                            Text(
                              'Choose a facility to rent at ${widget.hospital.user.username}',
                              style: TextStyle(
                                  color: Color(0xff245DE8), fontSize: 16),
                            ),
                            SizedBox(height: 23),
                            Expanded(
                              child: facilityitem.length > 0
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: facilityitem.length,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        return CheckListTile(
                                            facility: FacilityData.fromJson(
                                                facilityitem[index]));
                                      })
                                  : hospitalsLoading
                                      ? SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.only(top: 80),
                                          child: EmptyData(
                                              title: 'No Facility available',
                                              isButton: false)),
                            ),
                            SizedBox(height: 20),
                            ButtonBlue(
                              title: 'SEND BOOKING REQUEST',
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BookFacility()));
                              },
                            ),
                            SizedBox(height: 20),
                          ]),
                    ))),
            isLoading: hospitalsLoading));
  }
}

class CheckListTile extends StatefulWidget {
  final FacilityData facility;
  CheckListTile({@required this.facility});

  @override
  _CheckListTileState createState() => _CheckListTileState();
}

class _CheckListTileState extends State<CheckListTile> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xffF3F4F8), width: 0.8))),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    if (value == false)
                      setState(() => value = true);
                    else
                      setState(() => value = false);
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                        color: value ? blue : Color.fromRGBO(223, 232, 252, 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.all(10),
                    child: Checkbox(
                      onChanged: (val) => {},
                      value: value,
                      activeColor: blue,
                      checkColor: Colors.white,
                    ),
                  )),
              SizedBox(width: sizer(true, 17, context)),
              Text(widget.facility.facilityName,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context))),
              Spacer(),
              SizedBox(width: 82.8),
              SkillsBox(
                title: widget.facility.pricePerHour,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                borderRadius: BorderRadius.circular(20),
              )
            ]));
  }
}
