import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class ButtonBlack extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  final Color auxilliaryColor;
  ButtonBlack({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.auxilliaryColor,
  }) : super(key: key);
  @override
  _ButtonBlackState createState() => _ButtonBlackState();
}

class _ButtonBlackState extends State<ButtonBlack> {
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
    return GestureDetector(
        child: Container(
          height: 60,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.auxilliaryColor ?? Color(0xff1d2746),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
                color: Colors.white,
                fontSize: pixel14,
                fontWeight: FontWeight.w500),
          ),
        ),
        onTap: widget.onPressed);
  }
}
