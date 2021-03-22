import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class SkillsBox extends StatefulWidget {
  final String title;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  SkillsBox({
    Key key,
    @required this.title,
    this.padding,
    this.borderRadius,
  }) : super(key: key);
  @override
  _SkillsBoxState createState() => _SkillsBoxState();
}

class _SkillsBoxState extends State<SkillsBox> {
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
    return Container(
        padding:
            widget.padding ?? EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 5.0),
        decoration: BoxDecoration(
          color: Color(0xffDFE8FC),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(6.0),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: Color(0xff2254D3),
              fontSize: sizer(true, 14, context),
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }
}
