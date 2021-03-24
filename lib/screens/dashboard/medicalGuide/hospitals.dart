import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/emptyData.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/searchTextInput.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/models/hospital.dart';
import 'package:thcDoctorMobile/provider/user.dart';

class SelectHospital extends StatefulWidget {
  SelectHospital({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SelectHospitalState createState() => _SelectHospitalState();
}

class _SelectHospitalState extends State<SelectHospital> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Hospital> hospitals = [];
  Future<List<Hospital>> allhosp;

  @override
  void initState() {
    super.initState();
    allhosp = getData();
  }

  Future<List<Hospital>> getData() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    var responseJson;
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("allHospitals")) {
      final String allHospitals = prefs.getString('allHospitals');
      responseJson = jsonDecode(allHospitals);
      print("cached");
      print(responseJson);
    } else {
      Dio dio = new Dio();
      response = await dio
          .get(
        url + "hospital/",
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
        var message = '';
        if (e.response.data['message'] != null) {
          message = e.response.data['message'];
        } else {
          message = e.response.data.toString();
        }
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              message,
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              ),
            ),
          ),
        );
      });
      responseJson = response.data;
      await prefs.setString('allHospitals', jsonEncode(responseJson));
      if (response.statusCode != 200) {
        var message = '';
        if (response.data['detail'] != null) {
          message = response.data['detail'];
        } else {
          message = response.data.toString();
        }
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              message,
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    }
    for (var i = 0; i < responseJson.length; i++) {
      hospitals.add(
        Hospital.fromJson(responseJson[i]),
      );
    }

    return hospitals;
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: new SingleChildScrollView(
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
                  HeaderText(title: 'Search for a Hospital'),
                  SizedBox(
                    height: 8,
                  ),
                  SubText(
                      isCenter: false, title: 'Choose your preferred hospital'),
                  SizedBox(height: sizer(false, 15, context)),
                  SearchTextInput(
                    hintText: "search",
                  ),
                  FutureBuilder<List<Hospital>>(
                    future: allhosp,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        List<Hospital> hosp = snapshot.data;
                        return hosp != null && hosp.length > 0
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: hosp.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Column(
                                    children: [
                                      Hmo(
                                          name: hosp[index].user.username,
                                          id: hosp[index].id),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                },
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 80),
                                child: EmptyData(
                                  title: 'No available hospitals',
                                  isButton: false,
                                ));
                      } else {
                        return CenterLoader();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Hmo extends StatelessWidget {
  final String name;
  final int id;

  Hmo({this.name, this.id});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) => ChooseHospital(id: id, title: name),
          //   ),
          // );
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xffF3F4F8), width: 1.0),
            ),
          ),
          child: Text(
            name,
            style: TextStyle(color: Color(0xff071232), fontSize: 16),
          ),
        ),
      ),
    );
  }
}
