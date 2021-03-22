import 'dart:io';
import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/emptyData.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/models/appointment.dart';
import 'package:thcDoctorMobile/models/patient.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';
import 'package:thcDoctorMobile/models/request.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/dashboard/patients/patientBox.dart';
import 'patientRequestInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientRequests extends StatefulWidget {
  PatientRequests({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PatientRequestsState createState() => _PatientRequestsState();
}

class _PatientRequestsState extends State<PatientRequests> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final textController = TextEditingController();
  List<dynamic> _patientRequests = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _offlineData();
  }

  Future _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("patientRequests")) {
      final String _cache = prefs.getString('patientRequests');
      setState(() {
        _patientRequests = jsonDecode(_cache);
        loading = false;
      });
    } else {
      setState(() {
        loading = true;
      });
    }
    fetchRequests();
  }

  Future<Null> fetchRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;
    List<dynamic> independent = [];

    try {
      try {
        String id =
            Provider.of<UserModel>(context, listen: false).independentId;
        var pending = await http.get(
            url + "book-doctor-request/?doctor=$id&status=pending",
            headers: {
              "Connection": 'keep-alive',
              "Authorization": "Bearer " + token
            });
        setState(() => independent = jsonDecode(pending.body));
      } catch (e) {}
      var pending = await http.get(
          url + "book-doctor-request/?doctor=$id&status=pending",
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          });

      setState(() {
        _patientRequests =
            [jsonDecode(pending.body), independent].expand((x) => x).toList();
        loading = false;
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

    prefs.setString("patientRequests", jsonEncode(_patientRequests));
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
            child: SingleChildScrollView(
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
                HeaderText(title: 'New patient requests'),
                SizedBox(height: 10),
                SubText(
                  isCenter: false,
                  title: 'Accept or reject new patient requests.',
                ),
                SizedBox(height: 20),
                loading ? SizedBox(height: 25) : SizedBox(),
                _patientRequests.length == 0 && !loading
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                      )
                    : SizedBox(),
                loading
                    ? CenterLoader()
                    : _patientRequests.length > 0
                        ? ListView.builder(
                            itemCount: _patientRequests.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) =>
                                PatientBox(
                                    onComplete: fetchRequests,
                                    hasOption: true,
                                    isRequest: true,
                                    patientRequest: Request.fromJson(
                                        _patientRequests[index]),
                                    patientInfo: null,
                                    route: 'main'))
                        : Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: SubText(
                              isCenter: true,
                              title: 'You have no requests presently',
                            ),
                          ),
              ]),
        ))));
  }
}
