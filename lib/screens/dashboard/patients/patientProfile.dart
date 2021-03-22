import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:thcDoctorMobile/models/request.dart';
import 'package:thcDoctorMobile/models/patient.dart';

class PatientProfile extends StatefulWidget {
  PatientProfile({Key key, this.title, this.patientRequest}) : super(key: key);
  final String title;
  final Request patientRequest;

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  bool loading = false;
  Patient patient = Patient();
  @override
  void initState() {
    super.initState();
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
                    child: new SingleChildScrollView(
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
                            HeaderText(title: 'Patient Profile'),
                            SizedBox(height: 60),
                            SubText(
                                title: "Personal Information", isCenter: false),
                            SizedBox(height: 30),
                            dataBox('Name',
                                widget.patientRequest.patient.user.name),
                            dataBox('Phone number',
                                widget.patientRequest.patient.phoneNumber),
                            dataBox('Date of Birth',
                                widget.patientRequest.patient.dateOfBirth),
                            dataBox('Current Address',
                                widget.patientRequest.patient.address, true),
                            dataBox('Occupation',
                                widget.patientRequest.patient.occupation),
                            dataBox('Marital Status',
                                widget.patientRequest.patient.maritalStatus),
                            dataBox('Tribe',
                                patient.tribe != null ? patient.tribe : ''),
                            dataBox('NIN/Passport Number',
                                widget.patientRequest.patient.ninNumber),
                            dataBox('Email',
                                widget.patientRequest.patient.user.email),
                            dataBox(
                                'Existing Medical Condition',
                                widget
                                    .patientRequest.patient.existingConditions),
                            dataBox('Referred by', ''),
                            dataBox('Next of KIN',
                                widget.patientRequest.patient.nextOfKinName),
                            dataBox(
                                'Next of KIN Phone Number',
                                widget.patientRequest.patient
                                    .nextOfKinPhoneNumber),
                            dataBox(
                                'Address of Next of KIN',
                                widget.patientRequest.patient.nextOfKinAddress,
                                true),
                            SizedBox(height: 25),
                            Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Container(
                                    height: 0.5,
                                    color:
                                        Color.fromRGBO(142, 145, 156, 0.24))),
                            SizedBox(height: 45),
                            SubText(title: 'Biodata', isCenter: false),
                            SizedBox(height: 30),
                            dataBox(
                                'Gender', widget.patientRequest.patient.gender),
                            dataBox('Age',
                                widget.patientRequest.patient.age.toString()),
                            dataBox('Weight',
                                widget.patientRequest.patient.weight + 'kg'),
                            dataBox('Height',
                                widget.patientRequest.patient.height + 'cm'),
                            dataBox('Blood Group',
                                widget.patientRequest.patient.bloodGroup),
                            dataBox(
                                'GenoType',
                                widget
                                    .patientRequest.patient.haemoglobinGenotype),
                            dataBox('BMI', widget.patientRequest.patient.bmi),
                            dataBox('Blood Sugar',
                                widget.patientRequest.patient.bloodSugar),
                            dataBox('Allergies',
                                widget.patientRequest.patient.allergies, true),
                                SizedBox(height: 20),
                          ]),
                    )))),
            isLoading: loading));
  }

  Widget dataBox(String title, String data, [bool extended = false]) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: Color(0xff2254D3), fontSize: 14)),
          SizedBox(height: 10),
          Container(
              height: extended ? 100 : 60,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                color: Color(0xffF3F4F8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(data != '' && data != null ? data : 'N/A',
                  style: TextStyle(
                      color: data != '' ? Color(0xff071232) : Color(0xff828282),
                      fontSize: 16))),
          SizedBox(height: 5),
        ]);
  }
}
