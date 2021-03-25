import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/authTextInput.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/models/patient.dart';

class ManageProfile extends StatefulWidget {
  ManageProfile({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  bool loading = false;
  Patient patient = Patient();
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;
    if (mounted)
      setState(() {
        loading = true;
      });
    var responseJson;
    Response response;
    Dio dio = new Dio();

    response = await dio
        .get(
      url + "patient-list/" + id + '/',
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          }),
    )
        .catchError((e) {
      if (mounted)
        setState(() {
          loading = false;
        });
      print(e.response.data);
      var message = '';
      if (e.response.data['message'] != null) {
        message = e.response.data['message'];
      } else {
        message = e.response.data.toString();
      }
    });
    if (mounted)
      setState(() {
        loading = false;
      });
    responseJson = response.data;
    if (response.statusCode != 200) {
      var message = '';
      if (response.data['details'] != null) {
        message = response.data['details'];
      } else {
        message = response.data.toString();
      }
    }
    print(responseJson);
    if (mounted)
      setState(() {
        patient = Patient.fromJson(responseJson);
      });
    return true;
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
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: EdgeInsets.only(
                          top: sizer(false, 50, context),
                          left: sizer(true, 20, context),
                          right: sizer(true, 20, context)),
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
                            SizedBox(height: sizer(false, 15, context)),
                            HeaderText(title: 'Patient Profile'),
                            SizedBox(height: 19),
                            loading
                                ? SizedBox()
                                : Column(
                                    children: [
                                      dataBox('Name', patient.user.name, false),
                                      dataBox(
                                          'Date of birth',
                                          patient.dateOfBirth != null
                                              ? patient.dateOfBirth
                                              : '',
                                          true),
                                      dataBox('Phone number',
                                          patient.phoneNumber ?? "N/A", true),
                                      dataBox(
                                          'Current Address',
                                          patient.address != null
                                              ? patient.address
                                              : '',
                                          true),
                                      dataBox(
                                          'Occupation',
                                          patient.occupation != null
                                              ? patient.occupation
                                              : '',
                                          true),
                                      dataBox(
                                          'Marital Status',
                                          patient.maritalStatus != null
                                              ? patient.maritalStatus
                                              : '',
                                          true),
                                      dataBox(
                                          'Tribe',
                                          patient.tribe != null
                                              ? patient.tribe
                                              : '',
                                          true),
                                      dataBox(
                                          'NIN/Passport Number',
                                          patient.ninNumber != null
                                              ? patient.ninNumber
                                              : '',
                                          true),
                                      dataBox(
                                          'Email',
                                          patient.user != null &&
                                                  patient.user.email != null
                                              ? patient.user.email
                                              : '',
                                          false),
                                      dataBox(
                                          'Existing Medical Condition',
                                          patient.existingConditions != null
                                              ? patient.existingConditions
                                              : '',
                                          true),
                                      dataBox(
                                          'Next of Kin',
                                          patient.nextOfKinName != null
                                              ? patient.nextOfKinName
                                              : '',
                                          true),
                                      dataBox(
                                          'Next of Kin Phone Number',
                                          patient.nextOfKinPhoneNumber != null
                                              ? patient.nextOfKinPhoneNumber
                                              : '',
                                          true),
                                      dataBox(
                                          'Address of Next of Kin',
                                          patient.nextOfKinAddress != null
                                              ? patient.nextOfKinAddress
                                              : '',
                                          true),
                                      SizedBox(height: 29),
                                      Container(
                                          height: 1.0,
                                          color: Color.fromRGBO(
                                              142, 145, 156, 0.24)),
                                      SizedBox(height: 39),
                                      SubText(title: 'Biodata', isCenter: true),
                                      SizedBox(height: 24),
                                      dataBox(
                                          'Gender',
                                          patient.gender != null
                                              ? patient.gender
                                              : '',
                                          true),
                                      dataBox(
                                          'Age',
                                          patient.age != null
                                              ? patient.age.toString()
                                              : '',
                                          true),
                                      dataBox(
                                          'Height',
                                          patient.height != null
                                              ? patient.height + 'cm'
                                              : '',
                                          true),
                                      dataBox(
                                          'Weight',
                                          patient.weight != null
                                              ? patient.weight + 'kg'
                                              : '',
                                          true),
                                      dataBox(
                                          'Blood Group',
                                          patient.bloodGroup != null
                                              ? patient.bloodGroup
                                              : '',
                                          true),
                                      dataBox(
                                          'GenoType',
                                          patient.haemoglobinGenotype != null
                                              ? patient.haemoglobinGenotype
                                              : '',
                                          true),
                                      dataBox(
                                          'Blood Sugar',
                                          patient.bloodSugar != null
                                              ? patient.bloodSugar
                                              : '',
                                          true),
                                      dataBox(
                                          'Allergies',
                                          patient.allergies != null
                                              ? patient.allergies
                                              : '',
                                          true),
                                      SizedBox(height: 20),
                                      ButtonBlue(
                                          title: "UPDATE",
                                          onPressed: () {
                                            setState(() => loading = true);
                                            Future.delayed(Duration(seconds: 2),
                                                () {
                                              setState(() => loading = false);
                                              Fluttertoast.showToast(
                                                  msg: "Successful!");
                                                  Navigator.pop(context);
                                            });
                                          }),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                          ]),
                    )))),
            isLoading: loading));
  }

  Widget dataBox(String title, String data, bool enabled) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Text(title,
              style: TextStyle(
                  color: Color(0xff2254D3),
                  fontSize: sizer(true, 14, context))),
          SizedBox(height: 15),
          Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Container(
              height: 55,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: sizer(false, 10, context)),
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: AuthTextInput(
                enabled: enabled,
                controller: TextEditingController(text: data),
              ),
            )
          ])
        ]);
  }
}
