import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/twentyText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/helpers/styles.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/models/prescription.dart';
import 'package:thcDoctorMobile/models/prescriptionRequest.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/dashboard/patients/patientBox.dart';
import 'package:thcDoctorMobile/screens/dashboard/patients/patientBoxTwo.dart';
import 'prescriptionRequestInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrescriptionRequests extends StatefulWidget {
  PrescriptionRequests({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PrescriptionRequestsState createState() => _PrescriptionRequestsState();
}

class _PrescriptionRequestsState extends State<PrescriptionRequests> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final textController = TextEditingController();
  List<dynamic> _prescriptionRequest = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _offlineData();
  }

  Future _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("prescriptionRequest")) {
      final String _cache1 = prefs.getString('prescriptionRequest');
      setState(() {
        _prescriptionRequest = jsonDecode(_cache1);
        loading = false;
      });
    } else {
      setState(() {
        loading = true;
      });
    }
    this.prescriptionRequests();
  }

  Future<Null> prescriptionRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;
    var response;

    try {
      response = await http.get(url + "doctor-prescription-request/?doctor=$id",
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          }
          );
      if (mounted)
        setState(() {
          _prescriptionRequest = jsonDecode(response.body);
        });
      await prefs.setString('prescriptionRequest', response.body);
      setState(() {
        _prescriptionRequest = jsonDecode(response.body);
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
    }
    print(response.body);
    setState(() {
      loading = false;
    });
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
                          ],
                        ),
                        SizedBox(height: 15),
                        HeaderText(title: 'New prescription requests'),
                        SizedBox(height: 10),
                        SubText(
                          isCenter: false,
                          title: 'Accept or reject new prescription requests.',
                        ),
                        SizedBox(height: 20),
                        loading ? SizedBox(height: 25) : SizedBox(),
                        loading ? CenterLoader() : SizedBox(),
                        _prescriptionRequest.length == 0 && !loading
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25)
                            : SizedBox(),
                        loading
                            ? SizedBox()
                            : _prescriptionRequest.length > 0
                                ? ListView.builder(
                                    itemCount: _prescriptionRequest.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            PatientBoxTwo(
                                      prescriptionRequest:
                                          PrescriptionRequest.fromJson(
                                              _prescriptionRequest[index]),
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: SubText(
                                      isCenter: true,
                                      title: 'You have no requests presently',
                                    ),
                                  )
                      ]),
                )))));
  }
}
