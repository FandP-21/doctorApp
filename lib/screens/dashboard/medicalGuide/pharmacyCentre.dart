import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/emptyData.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/searchTextInput.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/provider/user.dart';

class pharmacyCentre extends StatefulWidget {
  pharmacyCentre({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _pharmacyCentreState createState() => _pharmacyCentreState();
}

class _pharmacyCentreState extends State<pharmacyCentre> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<dynamic> dignosis = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getData();
    }
  }

  Future getData() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("allDiagnosticCentres")) {
      setState(
          () => dignosis = jsonDecode(prefs.getString("allDiagnosticCentres")));
    } else {
      setState(() => loading = true);
    }

    var response = await http.get(url + "medical-laboratory", headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    }).catchError((e) {
      setState(() => loading = false);
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

    setState(() => dignosis = jsonDecode(response.body));
    prefs.setString("allDiagnosticCentres", response.body);
    setState(() => loading = false);
    return true;
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
                  SizedBox(height: sizer(false, 20, context)),
                  HeaderText(title: 'Search for a Diagnostic centre'),
                  SizedBox(
                    height: 8,
                  ),
                  SubText(
                      isCenter: false,
                      title: 'Choose your preferred diagnostic centre'),
                  SizedBox(height: sizer(false, 15, context)),
                  SearchTextInput(
                    hintText: "Search",
                  ),
                  loading
                      ? CenterLoader()
                      : dignosis != null && dignosis.length > 0
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: dignosis.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Column(
                                  children: [
                                    hmo(dignosis[index]),
                                    SizedBox(height: 10),
                                  ],
                                );
                              },
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 80),
                              child: EmptyData(
                                title: 'No available pharmacy',
                                isButton: false,
                              )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget hmo(Map diagnosis) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) => ChooseLab(
          //       title: diagnosis['user']['username'],
          //       id: diagnosis['id'],
          //     ),
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
            diagnosis['user']['username'],
            style: TextStyle(color: Color(0xff071232), fontSize: 16),
          ),
        ),
      ),
    );
  }
}
