import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/twentyText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/buttonBlack.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/models/request.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'patientProfile.dart';

class PatientRequestInfo extends StatefulWidget {
  PatientRequestInfo(
      {Key key, this.title, this.patientRequest, this.onComplete})
      : super(key: key);
  final String title;
  final Request patientRequest;
  final VoidCallback onComplete;

  @override
  _PatientRequestInfoState createState() => _PatientRequestInfoState();
}

class _PatientRequestInfoState extends State<PatientRequestInfo> {
  @override
  void initState() {
    super.initState();
  }

  Future<Null> acceptRequest() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    var response = await http
        .patch(url + "book-doctor-request/${widget.patientRequest.id}/", body: {
      "status": "accepted"
    }, headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    print(response.body);
    Fluttertoast.showToast(msg: 'Successful');
    Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
  }

  Future<Null> declineRequest() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    var response = await http
        .patch(url + "book-doctor-request/${widget.patientRequest.id}/", body: {
      "status": "declined"
    }, headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    print(response.body);
    Fluttertoast.showToast(msg: 'Successful');
    Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding:
          EdgeInsets.only(top: sizer(false, 50, context), left: 20, right: 20),
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
            SizedBox(height: 30),
            Container(
              height: 260,
              decoration: BoxDecoration(
                  border: Border.all(color: backgroundGrey, width: 0.8),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                          '${widget.patientRequest.patient.photo}'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: 30),
            Text('${widget.patientRequest.patient.user.name}',
                style: TextStyle(
                  fontSize: pixel28,
                  fontWeight: FontWeight.w700,
                )),
            SizedBox(height: 10),
            SubText(
              title:
                  '${widget.patientRequest.patient.gender}, ${widget.patientRequest.patient.age} years old',
              isCenter: false,
            ),
            SizedBox(height: 35),
            SubText(
              title: 'Location',
              isCenter: false,
            ),
            SizedBox(height: 10),
            TwentyText(
                title: '${widget.patientRequest.patient.address}, Nigeria'),
            SizedBox(height: 35),
            SubText(
              title: 'Message to patient',
              isCenter: false,
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                 color: backgroundGrey,
                 borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "This message goes to patient notifications and not messages when accept or decline request is clicked",
                style: TextStyle(
                  fontSize: pixel14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),
            ButtonBlack(
              title: 'VIEW HEALTH PROFILE',
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => PatientProfile(
                          title: 'Admin',
                          patientRequest: widget.patientRequest,
                        )),
              ),
            ),
            SizedBox(height: 10),
            ButtonBlue(
              title: 'ACCEPT REQUEST',
              onPressed: acceptRequest,
            ),
            SizedBox(height: 10),
            ButtonBlack(
              title: 'DECLINE REQUEST',
              auxilliaryColor: Colors.red[400],
              onPressed: declineRequest,
            ),
            SizedBox(height: 20),
          ]),
    ))));
  }
}
