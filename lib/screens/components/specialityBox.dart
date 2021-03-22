import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/models/doctor.dart';

class SpecialityBox extends StatefulWidget {
  final String title;
  final bool isOn;
  SpecialityBox({Key key, @required this.title, @required this.isOn})
      : super(key: key);
  @override
  _SpecialityBoxState createState() => _SpecialityBoxState();
}

class _SpecialityBoxState extends State<SpecialityBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.5, horizontal: 16.5),
        margin: EdgeInsets.only(right: 5.0),
        decoration: BoxDecoration(
          color: widget.isOn ? Color(0xff071232) : Color(0xff4b7aed),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: Color(0xffE7EEFF),
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ));
  }
}
