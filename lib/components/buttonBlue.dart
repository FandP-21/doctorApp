import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class ButtonBlue extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  ButtonBlue({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _ButtonBlueState createState() => _ButtonBlueState();
}

class _ButtonBlueState extends State<ButtonBlue> {
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
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: blue,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: sizer(true, 16.0, context),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
