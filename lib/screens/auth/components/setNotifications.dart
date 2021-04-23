import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import '../registrationType.dart';

class SetNotifications extends StatefulWidget {
  SetNotifications({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SetNotificationsState createState() => _SetNotificationsState();
}

class _SetNotificationsState extends State<SetNotifications> {
  String firstName;
  String lastName;
  String email;
  String phoneNo;
  String username;
  String password;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: sizer(false, 124, context),
                        bottom: sizer(false, 134, context),
                        left: 20,
                        right: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/phoneNotifications.png',
                          width: 319,
                          height: 263,
                        ),
                        SizedBox(height: sizer(false, 48, context)),
                        HeaderText(title: 'Receive Notifications'),
                        SizedBox(height: sizer(false, 21, context)),
                        SubText(
                            title:
                                'We’ll send you notifications and updates in real time. We promise not to spam you.',
                            isCenter: true),
                        SizedBox(height: sizer(false, 54, context)),
                        ButtonBlue(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistrationType(
                                          passedEmail: email,
                                          passedPassword: password,
                                          passedFirstName: firstName,
                                          passedLastName: lastName,
                                          passedUsername: firstName,
                                          passedPhoneNumber: phoneNo)));
                            },
                            title: 'NOTIFY ME'),
                        SizedBox(height: sizer(false, 24, context)),
                        Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegistrationType(
                                            passedEmail: email,
                                            passedPassword: password,
                                            passedFirstName: firstName,
                                            passedLastName: lastName,
                                            passedUsername: firstName,
                                            passedPhoneNumber: phoneNo)));
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //       builder: (_) =>
                                //           RegistrationType(title: '')),
                                // );
                              },
                              child: SubText(
                                  title: 'Don\'t send Notifications',
                                  isCenter: true),
                            ))
                      ],
                    )))));
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firstName = (prefs.getString('fnamee') ?? '');
    lastName = (prefs.getString('lnamee') ?? '');
    email = (prefs.getString('emaill') ?? '');
    username = (prefs.getString('unamee') ?? '');
    phoneNo = (prefs.getString('phonee') ?? '');
    password = (prefs.getString('password') ?? '');
  }
}
