import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'setupProfile.dart';

class RegisterHospitalSuccess extends StatefulWidget {
  RegisterHospitalSuccess(
      {Key key,
      this.title,
      @required this.passedPhoneNumber,
      @required this.independent,
      @required this.practice})
      : super(key: key);
  final String title;
  final bool independent;
  final bool practice;
  final String passedPhoneNumber;

  @override
  _RegisterHospitalSuccessState createState() =>
      _RegisterHospitalSuccessState();
}

class _RegisterHospitalSuccessState extends State<RegisterHospitalSuccess> {
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
                    top: sizer(false, 176, context),
                    bottom: sizer(false, 30, context),
                    left: 20,
                    right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/sendIcon.png',
                      width: 140,
                      height: 140,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 57, left: 50, right: 60),
                        child: Text(
                            'Your staff registration for ' +
                                widget.title +
                                ' Hospitals was successful',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff071232), fontSize: 16)),
                      ),
                    ),
                    ButtonBlue(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SetupProfile(
                                  passedPhoneNumber: widget.passedPhoneNumber,
                                  independent: widget.independent,
                                  practice: widget.practice,
                                  title: widget.title,
                                ),
                              ));
                        },
                        title: 'CREATE MEDICAL PROFILE'),
                  ],
                ))));
  }
}
