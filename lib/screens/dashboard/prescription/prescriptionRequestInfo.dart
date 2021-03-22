import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/buttonRed.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:thcDoctorMobile/models/prescriptionRequest.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/models/patient.dart';

class PrescriptionRequestInfo extends StatefulWidget {
  PrescriptionRequestInfo({Key key, this.prescriptionRequest})
      : super(key: key);
  final PrescriptionRequest prescriptionRequest;

  @override
  _PrescriptionRequestInfoState createState() =>
      _PrescriptionRequestInfoState();
}

class _PrescriptionRequestInfoState extends State<PrescriptionRequestInfo> {
  bool loading = false;
  Patient patient = Patient();
  @override
  void initState() {
    super.initState();
  }

  Future<Null> acceptRequest() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    var response = await http.patch(
        url + "doctor-prescription-request/${widget.prescriptionRequest.id}/",
        body: {
          "request": "True"
        },
        headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        });
    print(response.body);
    Fluttertoast.showToast(msg: 'Successful');
    Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
  }

  Future<Null> rejectRequest() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    var response = await http.patch(
        url + "doctor-prescription-request/${widget.prescriptionRequest.id}/",
        body: {
          "request": "False"
        },
        headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        });
    print(response.body);
    Fluttertoast.showToast(msg: 'Successful');
    Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingOverlay(
            child: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
              padding: EdgeInsets.only(
                  top: sizer(false, 50, context),
                  left: 20,
                  right: 20,
                  bottom: 20),
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
                    HeaderText(title: 'Request Details'),
                    SizedBox(height: 50),
                    SubText(title: 'Prescription details', isCenter: false),
                    SizedBox(height: 30),
                    dataBox('Medication name',
                        '${widget.prescriptionRequest.medicationName}'),
                    dataBox(
                        'Strength', '${widget.prescriptionRequest.strength}'),
                    dataBox('Quantity',
                        '${widget.prescriptionRequest.quantity} tablets'),
                    dataBox('Patient',
                        '${widget.prescriptionRequest.patient.user.name}'),
                    SizedBox(height: 60),
                    ButtonBlue(
                      title: 'ACCEPT REQUEST',
                      onPressed: acceptRequest,
                    ),
                    SizedBox(height: 10),
                    ButtonRed(
                      title: 'DECLINE REQUEST',
                      onPressed: rejectRequest,
                    ),
                    SizedBox(height: 20),
                  ]),
            ))),
            isLoading: loading));
  }

  Widget dataBox(String title, String data) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: Color(0xff2254D3), fontSize: 14)),
          SizedBox(height: 10),
          Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: sizer(false, 10, context)),
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                  color: Color(0xffF3F4F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(data != '' ? data : 'N/A',
                    style: TextStyle(
                        color:
                            data != '' ? Color(0xff071232) : Color(0xff828282),
                        fontSize: 16)))
          ]),
          SizedBox(height: 5),
        ]);
  }
}
