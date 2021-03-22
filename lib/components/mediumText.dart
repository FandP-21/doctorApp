import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class MediumText extends StatefulWidget {
  final String title;
  MediumText({Key key, @required this.title}) : super(key: key);

  @override
  _MediumTextState createState() => _MediumTextState();
}

class _MediumTextState extends State<MediumText> {
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
    return Text(
      '${widget.title}',
      //     textAlign: widget.isCenter?TextAlign.center:TextAlign.left,
      style: TextStyle(
          fontSize: sizer(true, 16.0, context),
          color: Color(0xff8E919C),
          fontWeight: FontWeight.w500),
    );
  }
}
