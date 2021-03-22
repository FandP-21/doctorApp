import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/emptyData.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/models/appointment.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/dashboard/appointment/appointmentDetails.dart';
import 'package:thcDoctorMobile/screens/dashboard/patients/medicalRecords.dart';
import 'package:thcDoctorMobile/screens/dashboard/patients/patientVitals.dart';

class Overview extends StatefulWidget {
  Overview({this.title, this.patientInfo, this.scaffoldKey});
  final String title;
  final PatientInfo patientInfo;
  var scaffoldKey;

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  List<dynamic> upcomingAppointment = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    this._offlineData();
  }

  Future _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(
        widget.patientInfo.user.name + 'DoctorUpcomingAppointment')) {
      setState(() {
        upcomingAppointment = jsonDecode(prefs.getString(
            widget.patientInfo.user.name + 'DoctorUpcomingAppointment'));
        loading = false;
      });
    } else {
      setState(() => loading = true);
    }
    this.patientUpcominAppointments();
  }

  Future<Null> patientUpcominAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    try {
      var response = await http.post(
        url + 'upcoming-appointment/',
        headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        },
        body: {"doctor": id, "patient": widget.patientInfo.id.toString()},
      );

      print(response.body);
      setState(() => upcomingAppointment = jsonDecode(response.body));
      prefs.setString(
          widget.patientInfo.user.name + 'DoctorUpcomingAppointment',
          response.body);
    } on SocketException {
      widget.scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('No Internet Connection!',
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    }
    setState(() => loading = false);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              'GENERAL DIAGNOSIS',
              style: TextStyle(color: Color(0xff8E919C), fontSize: 14),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color(0xffDDE8FC),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                '${widget.patientInfo.diagnosis[0].generalDiagnosis ?? 'N/A'}',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: sizer(true, 16, context),
                  color: Color(0xff364354),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'UPCOMING EVENT',
              style: TextStyle(color: Color(0xff8E919C), fontSize: 14),
            ),
            SizedBox(height: 12),
            loading || upcomingAppointment.length == 0
                ? SizedBox(height: 20)
                : SizedBox(),
            loading
                ? CenterLoader()
                : upcomingAppointment.length > 0
                    ? ListView.builder(
                        itemCount: upcomingAppointment.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) =>
                            upcomingBox(Appointment.fromJson(
                                upcomingAppointment[index])))
                    : EmptyData(
                        title: 'No appointments currently', isButton: false),
            SizedBox(
              height: 23,
            ),
            Material(
                color: Color(0xff2254D3),
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientVitals(
                                  patientInfo: widget.patientInfo,
                                ))),
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'View Vitals',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_right,
                              color: Colors.white, size: 32)
                        ],
                      ),
                    ))),
            SizedBox(height: 5),
            Material(
                color: Color(0xff2254D3),
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicalRecords())),
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'View medical data',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_right,
                              color: Colors.white, size: 32)
                        ],
                      ),
                    ))),
                      SizedBox(height: 20),
          ]),
    );
  }

  Widget upcomingBox(Appointment appointment) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffF3F4F8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${appointment.startTime} - ${appointment.endTime} (${appointment.estimatedDuration})',
              style: TextStyle(color: Color(0xff2254D3), fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              appointment.callRecording ? videoBox() : SizedBox(),
              urgentBox(),
              Spacer(),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.50),
                decoration: BoxDecoration(
                  color: Color(0xffDFE8FC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Icon(Icons.arrow_forward,
                        size: 16, color: Color(0xff2254D3))),
              )
            ])
          ],
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AppointmentDetails(
                    isPrevious: false,
                    appointment: appointment,
                  ))),
    );
  }

  Widget urgentBox() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.50),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 111, 79, 0.2),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Icon(Icons.error, size: 20, color: Color(0xffFF6F4F)),
        SizedBox(width: 5),
        Text('Urgent',
            style: TextStyle(
                color: Color(0xffFF6F4F),
                fontSize: 14,
                fontWeight: FontWeight.w500))
      ]),
    );
  }

  Widget videoBox() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 9),
        margin: EdgeInsets.only(right: 5.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(135, 79, 255, 0.21),
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Center(
            child: Icon(Icons.videocam, size: 25, color: Color(0xff874FFF))));
  }
}
