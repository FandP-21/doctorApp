import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class ButtonRed extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  ButtonRed({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _ButtonRedState createState() => _ButtonRedState();
}

class _ButtonRedState extends State<ButtonRed> {
  @override
  void initState() {
    super.initState();
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
            color: Color(0xffFF6F4F),
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
                          fontSize: sizer(true, 16, context),
                          fontWeight: FontWeight.w700),
                    ),
                  )),
            )));
  }
}
