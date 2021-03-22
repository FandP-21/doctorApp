import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class ButtonGreen extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  ButtonGreen({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _ButtonGreenState createState() => _ButtonGreenState();
}

class _ButtonGreenState extends State<ButtonGreen> {
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
            //   elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: BorderSide(color: Colors.red)
            ),
            color: Color(0xff1bc47d),
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 22.0),
                  decoration: BoxDecoration(
                    //   color: Color(0xff245DE8),
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
                  )),
            )));
  }
}
