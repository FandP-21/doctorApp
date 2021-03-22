import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/screens/dashboard/index.dart';

class RegisterProfileSuccess extends StatefulWidget {
  RegisterProfileSuccess({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterProfileSuccessState createState() => _RegisterProfileSuccessState();
}

class _RegisterProfileSuccessState extends State<RegisterProfileSuccess> {
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
                    bottom: sizer(false, 134, context),
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
                        padding: EdgeInsets.only(top: 57),
                        child: Text('Your profile has been setup successfully',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff071232), fontSize: 16)),
                      ),
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
                        title: 'GO TO DASHBOARD'),
                  ],
                ))));
  }
}
