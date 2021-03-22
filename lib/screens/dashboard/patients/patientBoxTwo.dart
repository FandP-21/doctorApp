import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/models/prescriptionRequest.dart';
import 'package:thcDoctorMobile/screens/dashboard/prescription/prescriptionRequestInfo.dart';

class PatientBoxTwo extends StatefulWidget {
  final PrescriptionRequest prescriptionRequest;

  PatientBoxTwo({this.prescriptionRequest});
  @override
  _PatientBoxTwoState createState() => _PatientBoxTwoState();
}

class _PatientBoxTwoState extends State<PatientBoxTwo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        margin: EdgeInsets.only(bottom: 10),
        child: Material(
            color: Color(0xffF3F4F8),
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => PrescriptionRequestInfo(
                              prescriptionRequest: widget.prescriptionRequest,
                            )),
                  );
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                                '${widget.prescriptionRequest.patient.photo}',
                                fit: BoxFit.cover,
                                width: 45,
                                height: 45)),
                        SizedBox(width: 15),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              "${widget.prescriptionRequest.patient.user.name}",
                              style: TextStyle(
                                  color: Color(0xff071232),
                                  fontSize: sizer(true, 18, context)),
                            ),
                            Text(
                              '${widget.prescriptionRequest.description}',
                              style: TextStyle(
                                  color: Color(0xff2254D3), fontSize: 16),
                            )
                          ],
                        )),
                        Spacer(),
                      ],
                    )))));
  }
}
