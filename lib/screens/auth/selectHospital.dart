import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/emptyData.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/searchTextInput.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/models/hospital.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/auth/registerAsEmployee.dart';

class SelectHospital extends StatefulWidget {
  SelectHospital(
      {Key key,
      this.title,
      @required this.passedPhoneNumber,
      @required this.independent,
      @required this.passedEmail,
      @required this.practice})
      : super(key: key);
  final String title;
  final bool independent;
  final bool practice;
  final String passedPhoneNumber;
  final String passedEmail;

  @override
  _SelectHospitalState createState() => _SelectHospitalState();
}

class _SelectHospitalState extends State<SelectHospital> {
  bool hospitalsLoading = false;
  bool appointmentsLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final textController = TextEditingController();

  List<Hospital> hospitals = [];

  List<dynamic> newHospitals = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchHospitals();
    }
  }

  Future<dynamic> setHospital(Hospital hospital) async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String id = Provider.of<UserModel>(context, listen: false).id;
    String token = Provider.of<UserModel>(context, listen: false).token;

    setState(() {
      hospitalsLoading = true;
    });
    var responseJson;
    Response response;
    Dio dio = new Dio();
    Map<dynamic, dynamic> body = {"hospital": hospital.id};
    response = await dio
        .patch(
      url + "doctor/" + id.toString() + '/',
      data: body,
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
      setState(() {
        hospitalsLoading = false;
      });
      print(e.response.data);
      var message = '';
      if (e.response.data['message'] != null) {
        message = e.response.data['message'];
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
    setState(() {
      hospitalsLoading = false;
    });
    responseJson = response.data;
    if (response.statusCode != 200) {
      var message = '';
      if (response.data['details'] != null) {
        message = response.data['details'];
      } else {
        message = response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
              //   fontWeight: FontWeight.w300,
            )),
        // duration: Duration(seconds: 3),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => RegisterAsEmployee(
                hospitalName: hospital.user.username,
                hospitalId: hospital.id,
                passedPhoneNumber: widget.passedPhoneNumber,
                independent: widget.independent,
                practice: widget.practice,
              )));
    }
  }

  Future fetchHospitals() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    setState(() => hospitalsLoading = true);

    var response = await http.get(url + 'hospital/', headers: {
      "Content-Type": "application/json",
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    setState(() => hospitalsLoading = false);
    print(response.body);
    setState(() => newHospitals = jsonDecode(response.body));
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: LoadingOverlay(
            child: SafeArea(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
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
                            SizedBox(height: 20),
                            HeaderText(title: 'Select your practice'),
                            SizedBox(
                              height: 5,
                            ),
                            SubText(
                                isCenter: false,
                                title:
                                    'Choose from the list of practices below'),
                            SizedBox(height: 25),
                            SearchTextInput(
                              hintText: "Search",
                              textController: textController,
                            ),
                            newHospitals.length > 0
                                ? ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: newHospitals.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return hospital(Hospital.fromJson(
                                          newHospitals[index]));
                                    })
                                : hospitalsLoading
                                    ? SizedBox()
                                    : Padding(
                                        padding: EdgeInsets.only(top: 80),
                                        child: EmptyData(
                                            title: 'No hospitals available',
                                            isButton: false)),
                          ]),
                    ))),
            isLoading: hospitalsLoading));
  }

  Widget hospital(Hospital hospital) {
    return Material(
        color: Colors.transparent,
        child: GestureDetector(
            onTap: () => setHospital(hospital),
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xffF3F4F8), width: 0.8))),
              child: Text(hospital.user.username,
                  style: TextStyle(color: Color(0xff071232), fontSize: 16)),
            )));
  }
}
