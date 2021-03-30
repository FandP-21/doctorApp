import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/searchTextInput.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/dashboard/patients/patientBox.dart';

class PatientBody extends StatefulWidget {
  PatientBody({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PatientBodyState createState() => _PatientBodyState();
}

class _PatientBodyState extends State<PatientBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final textController = TextEditingController();
  Timer _refreshFactor;
  List<dynamic> _patientInfo = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _offlineData();
  }

  void _handleSearch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = (prefs.getString('id') ?? '');
    var response;

    try {
      response = await http.get(
          url + "patient-of-doctor/$id/?search=${textController.text}",
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          });
      if (mounted)
        setState(() {
          loading = false;
          print(response.body);
          _patientInfo = jsonDecode(response.body);

        });
    } on SocketException {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "No internet connection!",
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            ),
          ),
        ),
      );
      setState(() {
        loading = false;
      });
    }
  }

  void _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("patientInfo")) {
      final String _cache = prefs.getString('patientInfo');
      setState(() {
        _patientInfo = jsonDecode(_cache);
      });
      return this.patientInfo();
    } else {
      setState(() {
        loading = true;
      });
      return this.patientInfo();
    }
  }

  void patientInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = (prefs.getString('id') ?? '');
    var response;

    try {
      response = await http.get(url + "patient-of-doctor/$id/", headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      });
      if (mounted)
        setState(() {
          _patientInfo = jsonDecode(response.body);
        });
      await prefs.setString('patientInfo', response.body);
      // print(_patientInfo);
    } on SocketException {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "No internet connection!",
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    setState(() {
      loading = false;
    });
    return this._refreshState();
  }

  void _refreshState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const oneSecond = const Duration(seconds: 1);
    _refreshFactor = new Timer.periodic(
        oneSecond,
        (Timer t) => setState(() {
              if (textController.text.isEmpty || textController.text == '')
                _patientInfo = jsonDecode(prefs.getString("patientInfo"));
            }));
  }

  void dispose() {
    super.dispose();
    _refreshFactor.cancel();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: new SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.only(
                      top: sizer(false, 50, context), left: 20, right: 20),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        HeaderText(title: 'Patients'),
                        SizedBox(height: 22),
                        SearchTextInput(
                          hintText: 'Search for a patient',
                          action: _handleSearch,
                          textController: textController,
                        ),
                        SizedBox(height: 30),
                        Text(
                          '${_patientInfo.length} patients',
                          style: TextStyle(
                              color: Color(0xff071232),
                              fontSize: sizer(true, 18, context)),
                        ),
                        SizedBox(height: 15),
                        loading ? SizedBox(height: 25) : SizedBox(),
                        _patientInfo.length == 0 && !loading
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              )
                            : SizedBox(),
                        loading
                            ? CenterLoader()
                            : _patientInfo.length > 0
                                ? ListView.builder(
                                    itemCount: _patientInfo.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            PatientBox(
                                              hasOption: false,
                                              route: 'aux',
                                              patientRequest: null,
                                              isRequest: false,
                                              patientInfo: PatientInfo.fromJson(
                                                  _patientInfo[index]),
                                            ))
                                : Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: SubText(
                                      isCenter: true,
                                      title: 'You have no patients currently',
                                    ),
                                  )
                      ]),
                )))));
  }
}
