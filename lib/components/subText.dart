import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class SubText extends StatefulWidget {
  final String title;
  final bool isCenter;
  SubText({Key key, @required this.title, @required this.isCenter})
      : super(key: key);

  @override
  _SubTextState createState() => _SubTextState();
}

class _SubTextState extends State<SubText> {
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
      textAlign: widget.isCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        color: Color(0xff8E919C),
        height: 1.1,
        fontSize: sizer(true, 16.0, context),
      ),
    );
  }
}
