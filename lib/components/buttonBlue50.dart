import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class ButtonBlue50 extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  ButtonBlue50({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _ButtonBlue50State createState() => _ButtonBlue50State();
}

class _ButtonBlue50State extends State<ButtonBlue50> {
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
            height: 50,
            width: 166,
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
