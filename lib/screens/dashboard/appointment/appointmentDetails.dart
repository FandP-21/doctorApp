import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/skillsBox.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/models/doctor.dart';
import 'package:thcDoctorMobile/models/appointment.dart';
import 'package:thcDoctorMobile/models/hospital.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/components/accountListItem.dart';
import 'package:thcDoctorMobile/screens/dashboard/dashboardBody.dart';

class AppointmentDetails extends StatefulWidget {
  AppointmentDetails(
      {Key key, this.title, this.appointment, @required this.isPrevious})
      : super(key: key);
  final String title;
  final Appointment appointment;
  final bool isPrevious;

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  bool upcoming = true;

  @override
  void initState() {
    super.initState();
  }

  void cancelAppointment() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    var response = await http.patch(url + "session-request/$id/", body: {
      'description': 'decline'
    }, headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    print(jsonDecode(response.body));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
        ),
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.78,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                left: sizer(true, 20, context),
                right: sizer(true, 20, context),
                top: 50,
                bottom: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  HeaderText(title: 'Manage appointent'),
                  SizedBox(height: 28),
                  AccountListItem(
                      title: 'Cancel appointment',
                      last: false,
                      onPressed: () {
                        cancelAppointment();
                        Navigator.pop(context);
                      }),
                ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String day = widget.appointment.date.split('-')[2];
    String month = months[int.parse(widget.appointment.date.split('-')[1])];
    String year = widget.appointment.date.split('-')[0];

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: new SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: sizer(false, 48, context),
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
                      Text('Details',
                          style: TextStyle(
                              color: Color(0xff071232),
                              fontSize: sizer(true, 18, context),
                              fontWeight: FontWeight.w700)),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 11),
                          decoration: BoxDecoration(
                            color: Color(0xffF3F4F8),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                              child: Image.asset(
                                  'assets/images/appointmentBlue.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain))),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text('Video Consultation',
                      style: TextStyle(
                          color: Color(0xff071232),
                          fontSize: pixel24,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 25),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      widget.appointment.patient != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                  widget.appointment.patient != null
                                      ? widget.appointment.patient.photo
                                      : '',
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50))
                          : Container(),
                      SizedBox(width: sizer(true, 12, context)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widget.appointment.patient != null
                              ? Text(widget.appointment.patient.user.name,
                                  style: TextStyle(
                                      color: Color(0xff071232),
                                      fontWeight: FontWeight.w500,
                                      fontSize: sizer(true, 16.0, context)))
                              : Text(''),
                        ],
                      ),
                      Spacer(),
                      videoBox(),
                    ],
                  ),
                  SizedBox(height: sizer(false, 30, context)),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffDFE8FC), width: 1)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 11),
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F4F8),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                    child: Image.asset(
                                        'assets/images/appointmentBlue.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain)),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    day + ' ' + month + ' ' + year,
                                    style: TextStyle(
                                      color: Color(0xff071232),
                                      fontSize: sizer(true, 16.0, context),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  widget.appointment.preferredTime != null
                                      ? Text(
                                          widget.appointment.preferredTime
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: Color(0xff8E919C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : Container(),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: sizer(false, 10, context)),
                        Divider(
                          thickness: 1.5,
                        ),
                        SizedBox(height: sizer(false, 10, context)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF3F4F8),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                      child: Image.asset(
                                          'assets/images/locationIcon.png',
                                          width: 19,
                                          height: 19,
                                          fit: BoxFit.contain))),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    widget.appointment.hospital != null &&
                                            widget.appointment.hospital.bio !=
                                                null
                                        ? widget.appointment.hospital.bio
                                        : '',
                                    style: TextStyle(
                                      color: Color(0xff071232),
                                      fontSize: sizer(true, 16.0, context),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    widget.appointment.hospital != null &&
                                            widget.appointment.hospital
                                                    .officeAddress !=
                                                null
                                        ? widget
                                            .appointment.hospital.officeAddress
                                        : '',
                                    style: TextStyle(
                                      color: Color(0xff8E919C),
                                      fontSize: sizer(true, 14, context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: sizer(false, 10, context)),
                        Divider(
                          thickness: 1.5,
                        ),
                        SizedBox(height: sizer(false, 10, context)),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 13),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.all(11),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF3F4F8),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                        child: Image.asset(
                                            'assets/images/period.png',
                                            width: 24,
                                            height: 24,
                                            fit: BoxFit.contain))),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                        widget.appointment.estimatedDuration !=
                                                null
                                            ? widget
                                                .appointment.estimatedDuration
                                            : '',
                                        style: TextStyle(
                                          color: Color(0xff071232),
                                          fontSize: sizer(true, 16.0, context),
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizer(false, 41, context),
                  ),
                  Text(
                    'Details',
                    style: TextStyle(
                        color: Color(0xff071232),
                        fontSize: sizer(true, 20, context),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  widget.appointment.description != null
                      ? Text(
                          widget.appointment.description,
                          style: TextStyle(
                              color: black,
                              fontSize: pixel16,
                              fontWeight: FontWeight.w300),
                        )
                      : Container(),
                  SizedBox(
                    height: 30,
                  ),
                  widget.isPrevious
                      ? SizedBox()
                      : Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: ButtonBlue(
                              title: 'MANAGE APPOINTMENT',
                              onPressed: () {
                                displayBottomSheet(context);
                              },
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 1.0,
      color: Color(0xffDFE8FC),
    );
  }
}

Widget videoBox() {
  return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Color.fromRGBO(135, 79, 255, 0.21),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Icon(Icons.videocam, size: 30, color: Color(0xff874FFF))));
}
