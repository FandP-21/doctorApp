import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/screens/dashboard/createHealthAlert.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Alerts extends StatefulWidget {
  Alerts({this.key, this.title, @required this.patientInfo}) : super(key: key);
  final String title;
  final GlobalKey<ScaffoldState> key;
  final PatientInfo patientInfo;

  @override
  _AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  List<dynamic> vitalsHistory = [];

  Future fetchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => vitalsHistory = jsonDecode(
        prefs.getString("alertsFor" + widget.patientInfo.user.email)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: sizer(false, 28, context), left: 20, right: 20),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            vitalsHistory.length > 0 ? SizedBox() : SizedBox(height: 50),
            vitalsHistory.length > 0
                ? SizedBox()
                : Image.asset(
                    'assets/images/alertsIcon.png',
                    width: 100,
                    height: 100,
                  ),
            vitalsHistory.length > 0
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        child:
                            Text("You've not setup any alerts for this patient",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff071232),
                                  fontSize: sizer(true, 16, context),
                                  fontWeight: FontWeight.w300,
                                )))),
            vitalsHistory.length > 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: vitalsHistory.length,
                    itemBuilder: (BuildContext context, int index) => Container(
                        width: double.infinity,
                        height: 100,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: blue.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(vitalsHistory[index]["title"],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: blue,
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "Max: " +
                                        jsonDecode(vitalsHistory[index]
                                                ["alerts"])[0]
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: blue,
                                    )),
                                Text(
                                    "Min: " +
                                        jsonDecode(vitalsHistory[index]
                                                ["alerts"])[1]
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: blue,
                                    )),
                              ],
                            )
                          ],
                        )),
                  )
                : SizedBox(),
            SizedBox(height: 70),
            ButtonBlue(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateHealthAlert(
                            callback: fetchHistory,
                            patientInfo: widget.patientInfo))),
                title: 'SETUP ALERTS'),
          ]),
    );
  }
}
