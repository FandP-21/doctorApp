import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import '../dashboard/index.dart';

class AppointmentSuccess extends StatefulWidget {
  AppointmentSuccess({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppointmentSuccessState createState() => _AppointmentSuccessState();
}

class _AppointmentSuccessState extends State<AppointmentSuccess> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(
                    top: 20,
                    bottom: sizer(false, 30, context),
                    left: 20,
                    right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Material(
                              color: Color(0xffF3F4F8),
                              borderRadius:
                                            BorderRadius.circular(10),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Dashboard(loading: false),
                                        ),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Icon(Icons.close,
                                            color: Color(0xff071232),
                                            size: 22)),
                                  )))
                        ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(27.5),
                              decoration: BoxDecoration(
                                  color: Color(0xfff4f4f8),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Image.asset(
                                'assets/images/appointmentGreenSmall.png',
                                height: 45,
                                width: 45,
                                fit: BoxFit.contain,
                              )))
                        ]),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "You've successfully booked a test, you will be charged once cedearcrest hospitals confirms your booking",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Color(0xff071232),
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                    ButtonBlue(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(loading: false),
                              ),
                              (Route<dynamic> route) => false);
                        },
                        title: 'DONE'),
                  ],
                ))));
  }
}
