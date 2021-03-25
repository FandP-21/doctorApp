import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:thcDoctorMobile/components/searchTextInput.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/screens/components/accountListItem.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/mediumText.dart';
import 'package:thcDoctorMobile/screens/dashboard/billingDetails.dart';
import 'package:thcDoctorMobile/screens/dashboard/changePassword.dart';
import 'package:thcDoctorMobile/screens/dashboard/facility/index.dart';
import 'package:thcDoctorMobile/screens/dashboard/linkedDevices.dart';
import 'package:thcDoctorMobile/screens/dashboard/manageHospitalSchedule.dart';
import 'package:thcDoctorMobile/screens/dashboard/manageIndependentSChedule.dart';
import 'package:thcDoctorMobile/screens/dashboard/setBookingLimit.dart';
import 'package:thcDoctorMobile/screens/loader.dart';

import 'manageProfile.dart';

class Account extends StatefulWidget {
  Account({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  Future<Null> _handleSignOut() async {
    Fluttertoast.showToast(msg: "Signing out");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.commit();

    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Loader()));
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
                child: new SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: sizer(false, 50, context),
                            left: 20,
                            right: 20),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Account',
                                  style: TextStyle(
                                    fontSize: pixel28,
                                    fontWeight: FontWeight.w700,
                                  )),
                              SizedBox(height: 20),
                              SearchTextInput(hintText: 'Search'),
                              SizedBox(height: 25),
                              Text('Work',
                                  style: TextStyle(
                                      color: Color(0xff2254D3),
                                      fontSize: sizer(true, 16, context),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              AccountListItem(
                                  last: false,
                                  title: 'Manage weekly schedule hospital',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ManageHospitalSchedule()),
                                    );
                                  }),
                              AccountListItem(
                                  last: false,
                                  title: 'Manage weekly schedule independent',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ManageIndependentSchedule()),
                                    );
                                  }),
                              AccountListItem(
                                  last: true,
                                  title: 'Set booking limits',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => SetBookingLimit()),
                                    );
                                  }),
                              SizedBox(height: 25),
                              Text('Payments',
                                  style: TextStyle(
                                      color: Color(0xff2254D3),
                                      fontSize: sizer(true, 16, context),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              AccountListItem(
                                  last: true,
                                  title: 'Billing & payments',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => BillingDetails()),
                                    );
                                  }),
                              SizedBox(height: 25),
                              Text('Account',
                                  style: TextStyle(
                                      color: Color(0xff2254D3),
                                      fontSize: sizer(true, 16, context),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              AccountListItem(
                                  last: false,
                                  title: 'Linked devices',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => LinkedDevices()),
                                    );
                                  }),
                              AccountListItem(
                                  last: false,
                                  title: 'Manage profile',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => ManageProfile()));
                                  }),
                              AccountListItem(
                                  last: true,
                                  title: 'Change password',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => ChangePassword()),
                                    );
                                  }),
                              SizedBox(height: 25),
                              Text('Extra',
                                  style: TextStyle(
                                      color: Color(0xff2254D3),
                                      fontSize: sizer(true, 16, context),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              AccountListItem(
                                  last: false,
                                  title: 'Share application',
                                  onPressed: () {
                                    if (Platform.isAndroid) {
                                      Share.share(
                                          'Share thcDoctorMobile App https://play.google.com/store/apps/details?'
                                              'id=com.example.thcDoctorMobile',
                                          subject: 'thcDoctorMobile App');
                                    } else if (Platform.isIOS) {
                                      Share.share(
                                          'Share thcDoctorMobile https://apps.apple.com/in/app/thcDoctorMobile/id28488222',
                                          subject: 'thcDoctorMobile App');
                                    }
                                  }),
                              AccountListItem(
                                  last: true,
                                  title: 'Rent a facility',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => FacilityIndex()),
                                    );
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0xff2254D3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "SIGN OUT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                onTap: () => _handleSignOut(),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ]))))));
  }
}
