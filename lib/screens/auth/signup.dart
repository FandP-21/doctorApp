import 'package:flutter/material.dart';
import 'components/signup.dart';
import 'package:thcDoctorMobile/models/hospitalService.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<HospitalService> initialItems = [];
  @override
  void initState() {
    super.initState();
    //  getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SignUpBody(
          initialItems: initialItems,
        ));
  }
}
