import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:intl/intl.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/models/appointment.dart';
import 'package:thcDoctorMobile/screens/dashboard/appointment/appointmentDetails.dart';
import 'package:thcDoctorMobile/screens/dashboard/dashboardBody.dart';

class Schedule extends StatefulWidget {
  Schedule({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime today = new DateTime.now();
  List<int> arrangements = [];
  List<int> dates = [];
  int monthlength;
  bool loading = true;
  List<dynamic> doctorAppointments = [];
  String active = DateTime.now().day.toString();
  @override
  void initState() {
    super.initState();
    if (mounted) generateSequence();
    fetchAppointment(DateTime.now().day);
  }

  Future fetchAppointment(date) async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;
    
    setState(() => loading = true);
    var response = await http.post(url + 'upcoming-appointment/', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    }, body: {
      "doctor": id,
      "date": DateTime.now().year.toString() +
          '-' +
          DateTime.now().month.toString() +
          '-' +
          date.toString(),
    });
    setState(() => doctorAppointments = jsonDecode(response.body));
    setState(() => loading = false);
  }

  List<String> concatWeekdays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];
  List<String> weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  thisDay() {
    var date = DateTime.now();
    return DateFormat('EEE').format(date).toString();
  }

  void generateSequence() {
    arrangements = [];
    int i = concatWeekdays.indexOf(thisDay());

    while (arrangements.length < 7) {
      if (i == 7) {
        arrangements.add(0);
        i = 0;
      } else {
        arrangements.add(i);
      }
      i++;
    }

    this.arrangeDates();
  }

  void arrangeDates() {
    dates = [];
    if (DateTime.now().month == DateTime.january) {
      monthlength = 31;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    } else if (DateTime.now().month == DateTime.february) {
      monthlength = DateTime.now().year % 4 == 0 ? 29 : 28;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    } else if (DateTime.now().month == DateTime.march) {
      monthlength = 31;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    } else if (DateTime.now().month == DateTime.april) {
      monthlength = 30;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    } else if (DateTime.now().month == DateTime.may) {
      monthlength = 31;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    } else if (DateTime.now().month == DateTime.june) {
      monthlength = 30;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    } else if (DateTime.now().month == DateTime.july) {
      monthlength = 31;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    } else if (DateTime.now().month == DateTime.august) {
      monthlength = 31;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    } else if (DateTime.now().month == DateTime.september) {
      monthlength = 30;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    } else if (DateTime.now().month == DateTime.october) {
      monthlength = 31;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    } else if (DateTime.now().month == DateTime.november) {
      monthlength = 30;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    } else if (DateTime.now().month == DateTime.december) {
      monthlength = 31;
      int i = DateTime.now().day;
      while (dates.length < 7) {
        if (i == monthlength) {
          dates.add(1);
          i = 1;
        } else {
          dates.add(i);
        }
        i++;
      }
    }
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
                child: Padding(
                  padding: EdgeInsets.only(
                      top: sizer(false, 50, context), left: 20, right: 20),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        HeaderText(title: 'Schedule'),
                        SizedBox(height: 23),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                                today.day.toString() +
                                    ' ' +
                                    monthsLower[today.month - 1],
                                style: TextStyle(
                                    color: Color(0xff8E919C), fontSize: 16)),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xffF3F4F8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/appointmentBlue.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 14),
                        Container(
                            height: 1,
                            decoration:
                                BoxDecoration(color: Color(0xffF3F4F8))),
                        SizedBox(height: 14),
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                arrangements.length,
                                (index) => Text(weekdays[arrangements[index]],
                                    style: TextStyle(
                                        color: Color(0xff8E919C),
                                        fontSize: 16)))),
                        SizedBox(height: 14),
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                dates.length,
                                (index) => GestureDetector(
                                    onTap: () {
                                      setState(() =>
                                          active = dates[index].toString());
                                      fetchAppointment(dates[index]);
                                    },
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color:
                                              active == dates[index].toString()
                                                  ? Color(0xff2254D3)
                                                  : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Text(dates[index].toString(),
                                                style: TextStyle(
                                                    color: active ==
                                                            dates[index]
                                                                .toString()
                                                        ? Color(0xffffffff)
                                                        : Color(0xff8E919C),
                                                    fontSize: 16))))))),
                        SizedBox(height: 16),
                        Expanded(
                            child: loading
                                ? CenterLoader()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: doctorAppointments.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            appointmentBox(Appointment.fromJson(
                                                doctorAppointments[0])))),
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
}
