import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/auth/components/setupProfile.dart';
import 'selectHospital.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationType extends StatefulWidget {
  RegistrationType({
    Key key,
    this.title,
    @required this.passedPhoneNumber,
    @required this.passedEmail,
    @required this.passedPassword,
    @required this.passedFirstName,
    @required this.passedLastName,
    @required this.passedUsername,
  }) : super(key: key);
  final String title;
  final String passedPhoneNumber;
  final String passedEmail;
  final String passedPassword;
  final String passedFirstName;
  final String passedLastName;
  final String passedUsername;

  @override
  _RegistrationTypeState createState() => _RegistrationTypeState();
}

class _RegistrationTypeState extends State<RegistrationType> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool independent = false;
  bool loading = false;
  bool practice = false;
  String selectedHospital = '';

  void setIndependent(bool val) {
    setState(() => independent = val);
  }

  void setPractice(bool val) {
    setState(() => practice = val);
  }

  Future<dynamic> setRegistrationType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String id = Provider.of<UserModel>(context, listen: false).id;
    String token = Provider.of<UserModel>(context, listen: false).token;

    Map<String, dynamic> body = {
      'user': {
        "email": "independent-" + widget.passedEmail,
        'password': widget.passedPassword,
        'first_name': widget.passedFirstName,
        'last_name': widget.passedLastName,
        'username': widget.passedUsername,
      },
      "mdcn_license_number": 000000000000000000,
      "languages": null,
      "location": null,
      "bio_info_on_specialization": null,
      "area_of_specialization": [],
      "mdcn_license": null,
      "is_independent": true.toString(),
    };

    if (practice == true && independent == false) {
      setState(() => loading = true);
      var response = await http.patch(url + 'doctor/' + id, body: {
        "is_independent": false.toString(),
      }, headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      });
      print(jsonDecode(response.body));
      setState(() => loading = false);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => SelectHospital(
                passedEmail: widget.passedEmail,
                passedPhoneNumber: widget.passedPhoneNumber,
                independent: independent,
                practice: practice,
                title: '',
              )));
    } else if (independent == true && practice == false) {
      setState(() => loading = true);
      var response = await http.patch(url + 'doctor/' + id, body: {
        "is_independent": true.toString(),
      }, headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      });
      print(jsonDecode(response.body));
      setState(() => loading = false);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => SetupProfile(
                passedPhoneNumber: widget.passedPhoneNumber,
                independent: independent,
                practice: practice,
                title: '',
              )));
    } else if (practice == independent) {
      setState(() => loading = true);
      String _baseUrl = "https://thc2020.herokuapp.com/";
      var responseJson;
      Response response;
      Dio dio = new Dio();

      response = await dio.post(
        _baseUrl + "doctor/",
        data: body,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: {
              "Content-Type": "application/json",
              "Connection": 'keep-alive'
            }),
      );
      responseJson = response.data;
      if (response.statusCode != 201) {
        print(response.statusCode);
        print(response.data);
        var message = '';
        if (response.data['user']['email'] != null) {
          message = response.data['user']['email'][0];
        } else {
          message = response.data.toString();
        }
        setState(() => loading = false);
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message,
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              )),
        ));
      } else {
        Map<String, dynamic> body = {
          "email": "independent-" + widget.passedEmail,
          "password": widget.passedPassword,
        };

        loginFn(body);
      }
    }
  }

  Future<dynamic> loginFn(body) async {
    String _baseUrl = "https://thc2020.herokuapp.com/";
    var responseJson;
    Response response;
    Dio dio = new Dio();
    String token = Provider.of<UserModel>(context, listen: false).token;

    response = await dio
        .post(
      _baseUrl + "login/",
      data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "Content-Type": "application/json",
            "Connection": 'keep-alive'
          }),
    )
        .catchError((e) {
      setState(() => loading = false);
      var message = '';
      if (e.response.data['detail'] != null) {
        message = e.response.data['detail'];
      } else {
        message = e.response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    });
    responseJson = response.data;
    if (response.statusCode != 200) {
      var message = '';
      if (response.data['detail'] != null) {
        message = response.data['detail'];
      } else if (response.data['message'] == 'Email is not verified') {
        message = response.data['message'];
      } else {
        message = response.data.toString();
      }
      setState(() => loading = false);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    } else {
      await Provider.of<UserModel>(context, listen: false)
          .setIndependentId(responseJson['doctor_id'].toString());
      await Provider.of<UserModel>(context, listen: false)
          .setIndependentMainId(responseJson['id'].toString());
      await Provider.of<UserModel>(context, listen: false)
          .setHospitalId(responseJson['hospital_id'].toString());

      var responseX = await http
          .patch(_baseUrl + 'doctor/' + responseJson['doctor_id'] + '/', body: {
        "is_independent": true.toString(),
        "firebase_id": FirebaseAuth.instance.currentUser.uid.toString(),
      }, headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      }).catchError((e) => print(e));
      setState(() => loading = false);
      print(responseJson);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => SelectHospital(
                passedPhoneNumber: widget.passedPhoneNumber,
                independent: independent,
                passedEmail: widget.passedEmail,
                practice: practice,
                title: '',
              )));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
            child: LoadingOverlay(
                isLoading: loading,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: sizer(false, 50, context),
                          left: 20,
                          right: 20,
                          bottom: 30),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    BackButtonWhite(
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                HeaderText(title: 'Choose registration type'),
                                SizedBox(
                                  height: 5,
                                ),
                                SubText(
                                    isCenter: false,
                                    title:
                                        'You can choose to register as an independent consultant, a registered hospital’s staff or both.'),
                                SizedBox(height: 15),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CheckItem(
                                    title: 'I\'m an independent consultant',
                                    active: independent,
                                    callback: setIndependent),
                                CheckItem(
                                  title:
                                      'I work with a practice registered on THC',
                                  active: practice,
                                  callback: setPractice,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 10),
                            ButtonBlue(
                                title: 'NEXT',
                                onPressed: practice != false ||
                                        independent != false
                                    ? setRegistrationType
                                    : () => _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Please select an option',
                                              style: TextStyle(
                                                fontSize:
                                                    sizer(true, 15.0, context),
                                                color: Colors.white,
                                              )),
                                        )))
                          ]),
                    )))));
  }
}

class CheckItem extends StatefulWidget {
  CheckItem(
      {@required this.title, @required this.active, @required this.callback});
  final String title;
  final bool active;
  final ValueChanged<bool> callback;

  @override
  _CheckItemState createState() => _CheckItemState();
}

class _CheckItemState extends State<CheckItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: EdgeInsets.only(bottom: sizer(false, 10, context)),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.active
              ? Color.fromRGBO(223, 232, 252, 1)
              : Color.fromRGBO(243, 244, 248, 1),
        ),
        child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
                color: widget.active ? blue : Color.fromRGBO(223, 232, 252, 1),
                borderRadius: BorderRadius.circular(5)),
            child: Checkbox(
              onChanged: widget.callback,
              value: widget.active,
              activeColor: blue,
              checkColor: Colors.white,
            ),
          ),
          SizedBox(width: sizer(true, 15, context)),
          Text(widget.title,
              style: TextStyle(
                  color: widget.active ? blue : Color(0xff071232),
                  fontWeight: FontWeight.w400,
                  fontSize: sizer(true, 14.0, context)))
        ]));
  }
}
