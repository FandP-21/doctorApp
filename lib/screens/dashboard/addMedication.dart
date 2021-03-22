import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/moreButton.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:http/http.dart' as http;
import 'package:thcDoctorMobile/components/authTextInput.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';
import 'package:thcDoctorMobile/screens/components/dropdownWidget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:thcDoctorMobile/provider/user.dart';

class AddMedication extends StatefulWidget {
  AddMedication(
      {Key key, this.title, @required this.patientInfo, this.updateState})
      : super(key: key);
  final String title;
  final PatientInfo patientInfo;
  final GestureTapCallback updateState;

  @override
  _AddMedicationState createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController noOfTablets = new TextEditingController();
  TextEditingController dosage = new TextEditingController();
  String _treatmentCategory = 'Select treatment category';
  String _drugName = 'Select drug';
  int _drugId;
  String _frequency = 'per 8 hours';
  String _times = '2 times';
  String _unit = 'mg';
  bool _autoValidate = false;
  bool loading = false;
  List<dynamic> categories = [];
  List<dynamic> drugs = [];
  List<dynamic> drugIds = [];

  @override
  void initState() {
    super.initState();
    this.treatmentCategories();
  }

  Future<Null> treatmentCategories() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;

    var response = await http.get(url + 'pharmacy-drug-categories/', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    for (int i = 0; i < jsonDecode(response.body).length; i++) {
      setState(() => categories.add(jsonDecode(response.body)[i]['name']));
    }
    this.treatment();
  }

  Future<Null> treatment() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;

    var response = await http.get(url + 'pharmacy-drug/', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    for (int i = 0; i < jsonDecode(response.body).length; i++) {
      setState(() => drugs.add(jsonDecode(response.body)[i]['name']));
      setState(() => drugIds.add(jsonDecode(response.body)[i]['id']));
    }
  }

  Future<Null> addMedication() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    setState(() => loading = true);

    if (_treatmentCategory != 'Select treatment category' &&
        widget.patientInfo.id != null &&
        id != null &&
        dosage.text.isNotEmpty &&
        noOfTablets.text.isNotEmpty &&
        _drugId != null &&
        _drugName != 'Select drug') {
      var response = await http
          .post(url + 'self-medication/${widget.patientInfo.id}', headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      }, body: {
        "name": _treatmentCategory,
        "patient": widget.patientInfo.id.toString(),
        "doctor": id.toString(),
        "drug_sets[0]dosage": dosage.text,
        "drug_sets[0]patient": widget.patientInfo.id.toString(),
        "drug_sets[0]frequency": _frequency.toString(),
        "drug_sets[0]unit": _unit.toString(),
        "drug_sets[0]no_of_tablets": noOfTablets.text,
        "drug_sets[0]drug": _drugId.toString(),
        "drug_sets[0]name": _drugName,
      });

      print(jsonDecode(response.body));
      await widget.updateState();
      Fluttertoast.showToast(msg: 'Successful!');
      Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('All fields are required!',
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    }
    setState(() => loading = false);
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
            child: LoadingOverlay(
                isLoading: loading,
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
                            MoreButton(onPressed: () {})
                          ],
                        ),
                        SizedBox(height: 15),
                        HeaderText(title: 'Add medication'),
                        SizedBox(height: sizer(false, 7, context)),
                        RichText(
                          text: TextSpan(
                            text: 'Create a prescription for this patient',
                            style: TextStyle(
                                color: Color(0xff828A95), fontSize: 14),
                            children: <TextSpan>[],
                          ),
                        ),
                        SizedBox(height: 35),
                        new Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          child: customForm(),
                        ),
                      ]),
                )))));
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownWidget(
          store: categories,
          title: _treatmentCategory,
          onChanged: (value) => setState(() => _treatmentCategory = value),
        ),
        SizedBox(height: 3),
        DropdownWidget(
          store: drugs,
          title: _drugName,
          onChanged: (value) => setState(() {
            _drugName = value;
            _drugId = drugIds[drugs.indexOf(value)];
          }),
        ),
        Container(
            margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                    child: AuthTextInput(
                  hintText: 'Enter dosage',
                  onChanged: (text) {},
                  controller: dosage,
                )),
                SizedBox(width: 16.0),
                Container(
                  margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xffF3F4F8),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton<String>(
                      hint: Text(
                        _unit,
                        style: TextStyle(
                            color: Color(0xff2254D3),
                            fontFamily: 'SofiaPro',
                            fontSize: sizer(true, 16.0, context)),
                      ),
                      items: ['mg', 'g'].map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          onTap: () {
                            setState(() {
                              _unit = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {});
                      },
                      isExpanded: true,
                      style: TextStyle(
                          color: Color(0xff828A95),
                          fontFamily: 'SofiaPro',
                          fontSize: 14),
                      underline: SizedBox(),
                      dropdownColor: Colors.white,
                      iconDisabledColor: Color(0xff2254D3),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: Color(0xff2254D3),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: blue)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  padding: EdgeInsets.only(left: 20, top: 7, right: 20),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xffF3F4F8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    hint: Text(
                      _frequency,
                      style: TextStyle(
                          color: Color(0xff2254D3),
                          fontFamily: 'SofiaPro',
                          fontSize: sizer(true, 16.0, context)),
                    ),
                    items: [
                      'per 4 hours',
                      'per 8 hours',
                      'per 12 hours',
                      'Daily'
                    ].map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: () {
                          setState(() {});
                        },
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _frequency = value),
                    isExpanded: true,
                    style: TextStyle(
                        color: Color(0xff828A95),
                        fontFamily: 'SofiaPro',
                        fontSize: 14),
                    underline: SizedBox(),
                    dropdownColor: Colors.white,
                    iconDisabledColor: Color(0xff2254D3),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Color(0xff2254D3),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Container(
                margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  padding: EdgeInsets.only(left: 20, top: 7, right: 20),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xffF3F4F8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton<String>(
                    hint: Text(
                      _times,
                      style: TextStyle(
                          color: Color(0xff2254D3),
                          fontFamily: 'SofiaPro',
                          fontSize: sizer(true, 16.0, context)),
                    ),
                    items: ['2 times', '3 times', '4 times'].map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: () => {},
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _times = value),
                    isExpanded: true,
                    style: TextStyle(
                        color: Color(0xff828A95),
                        fontFamily: 'SofiaPro',
                        fontSize: 14),
                    underline: SizedBox(),
                    dropdownColor: Colors.white,
                    iconDisabledColor: Color(0xff2254D3),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Color(0xff2254D3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          decoration: BoxDecoration(
              border: Border.all(color: blue),
              borderRadius: BorderRadius.circular(10)),
          child: AuthTextInput(
            hintText: '25 tablets',
            onChanged: (text) {},
            controller: noOfTablets,
          ),
        ),
        SizedBox(height: 30),
        ButtonBlue(onPressed: addMedication, title: 'CREATE PRESCRIPTION'),
        SizedBox(height: sizer(false, 32, context)),
        SizedBox(height: 10)
      ],
    );
  }
}
