import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/models/medications.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/dashboard/addMedication.dart';
import 'package:thcDoctorMobile/screens/dashboard/patients/medicationDetails.dart';

class Treatment extends StatefulWidget {
  Treatment({this.key, this.title, @required this.patientInfo});
  final String title;
  final PatientInfo patientInfo;
  final GlobalKey<ScaffoldState> key;

  @override
  _TreatmentState createState() => _TreatmentState();
}

class _TreatmentState extends State<Treatment> {
  List<dynamic> _treatments = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    this._offlineData();
  }

  Future _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs
        .containsKey(widget.patientInfo.user.email + 'DoctorPrescription')) {
      setState(() {
        _treatments = jsonDecode(prefs
            .getString(widget.patientInfo.user.email + 'DoctorPrescription'));
        loading = false;
      });
    } else {
      setState(() => loading = false);
    }
    this.treatments();
  }

  Future<Null> treatments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    var response = await http
        .get(url + 'self-medication/${widget.patientInfo.id}', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });

    setState(() {
      _treatments = jsonDecode(response.body);
      loading = false;
    });
    prefs.setString(
        widget.patientInfo.user.email + 'DoctorPrescription', response.body);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: sizer(false, 28, context), left: 20, right: 20, bottom: 20),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _treatments.length > 0 && !loading
                ? SizedBox()
                : SizedBox(height: 50),
            loading ? CenterLoader() : SizedBox(),
            _treatments.length > 0 || loading
                ? SizedBox()
                : Image.asset(
                    'assets/images/treatmentIcon.png',
                    width: 140,
                    height: 140,
                  ),
            _treatments.length > 0
                ? ListView.builder(
                    itemCount: _treatments.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => drugBox(
                        Medications.fromJson(_treatments[index]),
                        _treatments[index]['drug_sets']))
                : Container(
                    padding: EdgeInsets.only(top: 57, bottom: 10),
                    child: Text(
                        "You've not prescribed any treatment yet for this patient",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff071232),
                          fontSize: sizer(true, 16, context),
                          fontWeight: FontWeight.w300,
                        )),
                  ),
            SizedBox(height: 15),
            ButtonBlue(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddMedication(
                              patientInfo: widget.patientInfo,
                              updateState: treatments,
                            ))),
                title: 'ADD TREATMENT'),
          ]),
    );
  }

  Widget drugBox(Medications drugs, List<dynamic> prescription) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Color(0xfff3f4f8), borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MedicationDetails(
                title: drugs.name,
                prescription: prescription,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                drugs.name,
                style: TextStyle(
                  color: Color(0xff071232),
                  fontSize: sizer(true, 20, context),
                ),
              ),
              Container(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 14.6),
                decoration: BoxDecoration(
                  color: Color(0xffDFE8FC),
                  borderRadius: BorderRadius.circular(14.6),
                ),
                child: Center(
                  child: Text(
                    '${drugs.drugSets.length} drugs',
                    style: TextStyle(
                      color: Color(0xff2254D3),
                      fontSize: sizer(true, 14, context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
