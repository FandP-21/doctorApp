import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/authTextInput.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/screens/components/dropdownWidget.dart';
import 'package:thcDoctorMobile/screens/dashboard/index.dart';

class SetBookingLimit extends StatefulWidget {
  SetBookingLimit({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SetBookingLimitState createState() => _SetBookingLimitState();
}

class _SetBookingLimitState extends State<SetBookingLimit> {
  @override
  void initState() {
    super.initState();
  }

  String virtualBookings = 'Select number of virtual bookings';
  String inPersonBookings = 'Select number of in-person bookings';

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
                child: Stack(children: <Widget>[
                  new SingleChildScrollView(
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
                              SizedBox(),
                            ],
                          ),
                          SizedBox(height: 20),
                          HeaderText(title: 'Booking limits.'),
                          SizedBox(height: 12),
                          SubText(
                            title: 'Set your weekly booking limits',
                            isCenter: false,
                          ),
                          SizedBox(height: 26),
                          Form(
                              child: Column(children: [
                            AuthTextInput(
                              hintText: 'Enter your number of bookings',
                            ),
                            SizedBox(height: 15),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 16, context)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: blue),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 20, top: 7, right: 20),
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F4F8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButton<dynamic>(
                                  hint: Text(
                                    virtualBookings,
                                    style: TextStyle(
                                        color: Color(0xff2254D3),
                                        fontFamily: 'SofiaPro',
                                        fontSize: sizer(true, 16.0, context)),
                                  ),
                                  items: ["1", "2", "3", "4"].map((value) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value,
                                      child: Text(value),
                                      onTap: () {
                                        setState(() {
                                          virtualBookings = value;
                                        });
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) => {},
                                  isExpanded: true,
                                  style: TextStyle(
                                      color: Color(0xff828A95),
                                      fontFamily: 'SofiaPro',
                                      fontSize: 14),
                                  underline: SizedBox(),
                                  dropdownColor: Colors.white,
                                  iconDisabledColor: Color(0xff2254D3),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Color(0xff2254D3),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 16, context)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: blue),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 20, top: 7, right: 20),
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F4F8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButton<dynamic>(
                                  hint: Text(
                                    inPersonBookings,
                                    style: TextStyle(
                                        color: Color(0xff2254D3),
                                        fontFamily: 'SofiaPro',
                                        fontSize: sizer(true, 16.0, context)),
                                  ),
                                  items: ["1", "2", "3", "4", "5"].map((value) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value,
                                      child: Text(value),
                                      onTap: () {
                                        setState(() {
                                          inPersonBookings = value;
                                        });
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) => {},
                                  isExpanded: true,
                                  style: TextStyle(
                                      color: Color(0xff828A95),
                                      fontFamily: 'SofiaPro',
                                      fontSize: 14),
                                  underline: SizedBox(),
                                  dropdownColor: Colors.white,
                                  iconDisabledColor: Color(0xff2254D3),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Color(0xff2254D3),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10)
                          ])),
                        ]),
                  )),
                  Positioned(
                      bottom: 30,
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: ButtonBlue(
                                title: 'UPDATE',
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => Dashboard(
                                              loading: false,
                                            )),
                                  );
                                },
                              ))))
                ]))));
  }
}
