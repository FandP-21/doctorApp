import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/emptyData.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/models/appointment.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/dashboard/appointment/appointmentDetails.dart';
import 'package:thcDoctorMobile/screens/dashboard/medicalGuide/medicalGuide.dart';
import 'package:thcDoctorMobile/screens/dashboard/patients/patientRequests.dart';
import 'package:thcDoctorMobile/screens/dashboard/prescription/prescriptionRequest.dart';

List<String> months = [
  'JANUARY',
  'FEBRUARY',
  'MARCH',
  'APRIL',
  'MAY',
  'JUNE',
  'JULY',
  'AUGUST',
  'SEPTEMBER',
  'OCTOBER',
  'NOVEMBER',
  'DECEMBER'
];

List<String> monthsLower = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

List<String> monthsStripped = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sept',
  'Oct',
  'Nov',
  'Dec'
];

class DashboardBody extends StatefulWidget {
  DashboardBody({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime today = new DateTime.now();
  bool loading = true;
  List<dynamic> doctorAppointments = [];
  bool offline = false;
  @override
  void initState() {
    super.initState();
    this._offlineData();
  }

  Future _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("doctorAppointment")) {
      setState(() {
        doctorAppointments = jsonDecode(prefs.getString("doctorAppointment"));
        loading = false;
      });
    } else {
      setState(() => loading = true);
    }

    fetchAppointments();
  }

  Future<Null> fetchAppointments() async {
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
        body: {"doctor": id},
      );

      print(response.body);
      setState(() => doctorAppointments = jsonDecode(response.body));
      prefs.setString("doctorAppointment", response.body);
    } on SocketException {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "No internet connection!",
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    setState(() => loading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(
        () => offline = Provider.of<UserModel>(context, listen: false).offline);
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
            child: SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset('assets/images/sun.png',
                            width: 28, height: 28),
                        SizedBox(height: 3),
                        HeaderText(
                            title:
                                'Hello Dr. ${Provider.of<UserModel>(context, listen: false).name},')
                      ],
                    ),
                    Stack(alignment: Alignment.topRight, children: [
                      Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(11),
                          decoration: BoxDecoration(
                              color: Color(0xffDFE8FC),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset("assets/images/pin.png")),
                      Container(
                        height: 8,
                        width: 8,
                        margin: EdgeInsets.only(top: 12, right: 6),
                        decoration: BoxDecoration(
                            color: red,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: white,
                              width: 0.8,
                            )),
                      )
                    ])
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 20, right: 15),
                  decoration: BoxDecoration(
                      color: Color(0xffF3F4F8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Go offline',
                          style:
                              TextStyle(color: Color(0xff2254D3), fontSize: 15),
                        ),
                        GestureDetector(
                            onTap: () {
                              if (offline == true)
                                Provider.of<UserModel>(context, listen: false)
                                    .setOffline(false);
                              else
                                Provider.of<UserModel>(context, listen: false)
                                    .setOffline(true);
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  Provider.of<UserModel>(context).offline
                                      ? 'assets/images/on.png'
                                      : 'assets/images/off.png',
                                  height: 32,
                                )))
                      ]),
                ),
                SizedBox(height: 15),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    child:
                        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                      iconBox('Medical Guide', 'assets/images/guide.png', () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => MedicalGuide()),
                        );
                      }),
                      SizedBox(width: sizer(true, 10, context)),
                      iconBox('Prescriptions',
                          'assets/images/dashboardPrescriptions.png', () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) =>
                                  PrescriptionRequests(title: 'Jesse')),
                        );
                      }),
                      SizedBox(width: sizer(true, 10, context)),
                      iconBox(
                          'New Patients', 'assets/images/dashboardPatients.png',
                          () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => PatientRequests(title: 'Jesse')),
                        );
                      }),
                      SizedBox(width: sizer(true, 10, context)),
                    ])),
                SizedBox(height: 21),
                Text(
                  'TODAY, ${months[today.month - 1]} ${today.day}',
                  style: TextStyle(
                      color: Color(0xff8E919C),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 21),
                loading || doctorAppointments.length == 0
                    ? SizedBox(height: 40)
                    : SizedBox(),
                loading
                    ? CenterLoader()
                    : doctorAppointments.length > 0
                        ? ListView.builder(
                            itemCount: doctorAppointments.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) =>
                                appointmentBox(Appointment.fromJson(
                                    doctorAppointments[index])))
                        : EmptyData(
                            title: 'No appointments currently',
                            isButton: false,
                          ),
              ]),
        ))));
  }

  Widget appointmentBox(Appointment appointment) {
    return GestureDetector(
      child: Container(
          height: 83,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
            color: Color(0xffF3F4F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(appointment.patient.photo,
                        fit: BoxFit.cover, width: 45, height: 45)),
              ),
              SizedBox(width: 15),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    appointment.patient.user.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color(0xff071232),
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    appointment.startTime + ' - ' + appointment.endTime,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xff8E919C), fontSize: 16),
                  )
                ],
              )),
              Spacer(),
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 5.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 111, 79, 0.2),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Icon(Icons.error, size: 25, color: Color(0xffFF6F4F)),
                ]),
              ),
              SizedBox(width: 10),
              Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(135, 79, 255, 0.21),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Image.asset(
                    "assets/images/video.png",
                    height: 25,
                  ))
            ],
          )),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppointmentDetails(
                      isPrevious: false,
                      appointment: appointment,
                    )));
      },
    );
  }

  Widget iconBox(name, image, onPressed) {
    return Material(
      color: Color(0xff2254D3),
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width * 0.28,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                  decoration: BoxDecoration(
                    color: Color(0xff3563d7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset(image, width: 34, height: 34),
                  ),
                ),
                SizedBox(height: 10),
                Text(name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500))
              ],
            ),
          )),
    );
  }
}
