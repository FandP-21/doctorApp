import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';
import '../../../components/skillsBox.dart';
import 'overview.dart';
import 'alerts.dart';
import 'notes.dart';
import 'treatment.dart';

class PatientInfoBody extends StatefulWidget {
  final PatientInfo patientInfo;
  PatientInfoBody({Key key, this.title, this.patientInfo}) : super(key: key);
  final String title;

  @override
  _PatientInfoBodyState createState() => _PatientInfoBodyState();
}

class _PatientInfoBodyState extends State<PatientInfoBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  String currentTab = 'overview';

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
            top: sizer(false, 50, context),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        BackButtonWhite(
                          onPressed: () {},
                        ),
                      ],
                    )),
                SizedBox(height: 15),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(widget.patientInfo.photo,
                                fit: BoxFit.cover, width: 60, height: 60)),
                        SizedBox(width: 15),
                        Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  HeaderText(
                                      title: widget.patientInfo.user.name),
                                  SizedBox(height: 3),
                                  SkillsBox(
                                      title:
                                          '${widget.patientInfo.patientType} patient')
                                ])),
                        Spacer(),
                        Container(
                          width: 48,
                          height: 48,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Color(0xffDFE8FC),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Image.asset(
                              'assets/images/patientInfoIcon.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 41),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(223, 232, 252, 1),
                              width: 0.6))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      currentTab == 'overview'
                          ? activeTab('Overview', () {
                              setState(() {
                                currentTab = 'overview';
                              });
                            })
                          : inactiveTab('Overview', () {
                              setState(() {
                                currentTab = 'overview';
                              });
                            }),
                      currentTab == 'notes'
                          ? activeTab('Notes', () {
                              setState(() {
                                currentTab = 'notes';
                              });
                            })
                          : inactiveTab('Notes', () {
                              setState(() {
                                currentTab = 'notes';
                              });
                            }),
                      currentTab == 'treatment'
                          ? activeTab('Treatment', () {
                              setState(() {
                                currentTab = 'treatment';
                              });
                            })
                          : inactiveTab('Treatment', () {
                              setState(() {
                                currentTab = 'treatment';
                              });
                            }),
                      currentTab == 'alerts'
                          ? activeTab('Alerts', () {
                              setState(() {
                                currentTab = 'alerts';
                              });
                            })
                          : inactiveTab('Alerts', () {
                              setState(() {
                                currentTab = 'alerts';
                              });
                            })
                    ],
                  ),
                ),
                currentTab == 'overview'
                    ? Overview(
                        scaffoldKey: _scaffoldKey,
                        patientInfo: widget.patientInfo,
                      )
                    : Container(),
                currentTab == 'notes'
                    ? Notes(patientInfo: widget.patientInfo)
                    : Container(),
                currentTab == 'treatment'
                    ? Treatment(patientInfo: widget.patientInfo)
                    : Container(),
                currentTab == 'alerts' ? Alerts(patientInfo: widget.patientInfo) : Container(),
              ]),
        ))));
  }

  Widget activeTab(name, onPressed) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
          onTap: onPressed,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                SizedBox(height: 17),
                Container(
                  height: 2,
                  width: (name.length * 10).toDouble(),
                  color: Color(0xff245DE8),
                ),
              ])),
    );
  }

  Widget inactiveTab(name, onPressed) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
          onTap: onPressed,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      color: Color(0xff8E919C),
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(height: 17),
                Container(
                  height: 2,
                  color: Colors.transparent,
                )
              ])),
    );
  }
}
