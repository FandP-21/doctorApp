import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/screens/auth/signin.dart';
import 'package:thcDoctorMobile/screens/dashboard/index.dart';

class Loader extends StatefulWidget {
  Loader({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? '');
    if (token != '') {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => Dashboard(
                  title: 'THC',
                  loading: true,
                )),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SignIn(title: 'THC')),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Container()));
  }
}
