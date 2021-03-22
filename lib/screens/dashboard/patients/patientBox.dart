import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/models/request.dart';
import 'package:thcDoctorMobile/screens/dashboard/patients/patientInfoBody.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';
import 'package:thcDoctorMobile/screens/dashboard/patients/patientRequestInfo.dart';

class PatientBox extends StatefulWidget {
  final PatientInfo patientInfo;
  final Request patientRequest;
  final String route;
  final bool hasOption;
  final bool isRequest;
  final VoidCallback onComplete;
  PatientBox(
      {Key key,
      this.patientInfo,
      this.patientRequest,
      this.onComplete,
      @required this.isRequest,
      @required this.route,
      @required this.hasOption})
      : super(key: key);
  @override
  _PatientBoxState createState() => _PatientBoxState();
}

class _PatientBoxState extends State<PatientBox> {
  @override
  Widget build(BuildContext context) {
    return widget.patientRequest != null
        ? widget.patientRequest.status == "Accepted" ||
                widget.patientRequest.status == "Declined"
            ? SizedBox()
            : Container(
                height: 80,
                margin: EdgeInsets.only(bottom: 10),
                child: Material(
                    color: Color(0xffF3F4F8),
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => widget.route == 'main'
                                    ? PatientRequestInfo(
                                        onComplete: widget.onComplete,
                                        title: widget
                                            .patientRequest.patient.user.name,
                                        patientRequest: widget.patientRequest,
                                      )
                                    : PatientInfoBody(
                                        title: widget.patientInfo.user.name,
                                        patientInfo: widget.patientInfo,
                                      )),
                          );
                        },
                        child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                        widget.isRequest
                                            ? widget
                                                .patientRequest.patient.photo
                                            : widget.patientInfo.photo,
                                        fit: BoxFit.cover,
                                        width: 45,
                                        height: 45)),
                                SizedBox(width: 15),
                                Container(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          widget.isRequest
                                              ? widget.patientRequest.patient
                                                  .user.name
                                              : widget.patientInfo.user.name,
                                          style: TextStyle(
                                              color: Color(0xff071232),
                                              fontSize:
                                                  sizer(true, 18, context)),
                                        ),
                                        Text(
                                          widget.isRequest
                                              ? widget.patientRequest.patient
                                                      .age
                                                      .toString() +
                                                  'years old'
                                              : widget.patientInfo.age
                                                      .toString() +
                                                  'years old',
                                          style: TextStyle(
                                              color: Color(0xff2254D3),
                                              fontSize: 16),
                                        )
                                      ],
                                    )),
                                Spacer(),
                                widget.hasOption
                                    ? Container(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Image.asset(
                                          'assets/images/requestRightIcon.png',
                                          width: 5,
                                          height: 13,
                                        ))
                                    : SizedBox(),
                              ],
                            )))))
        : Container(
            height: 80,
            margin: EdgeInsets.only(bottom: 10),
            child: Material(
                color: Color(0xffF3F4F8),
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => PatientInfoBody(
                                  title: widget.patientInfo.user.name,
                                  patientInfo: widget.patientInfo,
                                )),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                    widget.isRequest
                                        ? widget.patientRequest.patient.photo
                                        : widget.patientInfo.photo,
                                    fit: BoxFit.cover,
                                    width: 45,
                                    height: 45)),
                            SizedBox(width: 15),
                            Container(
                                padding: EdgeInsets.only(top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      widget.isRequest
                                          ? widget
                                              .patientRequest.patient.user.name
                                          : widget.patientInfo.user.name,
                                      style: TextStyle(
                                          color: Color(0xff071232),
                                          fontSize: sizer(true, 18, context)),
                                    ),
                                    Text(
                                      widget.isRequest
                                          ? widget.patientRequest.patient.age
                                                  .toString() +
                                              'years old'
                                          : widget.patientInfo.age.toString() +
                                              'years old',
                                      style: TextStyle(
                                          color: Color(0xff2254D3),
                                          fontSize: 16),
                                    )
                                  ],
                                )),
                            Spacer(),
                            widget.hasOption
                                ? Image.asset(
                                    'assets/images/requestRightIcon.png',
                                    width: 5,
                                    height: 13,
                                  )
                                : SizedBox(),
                          ],
                        )))));
  }
}
