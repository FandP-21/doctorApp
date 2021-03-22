import 'package:flutter/material.dart';

class BackButtonBlue extends StatefulWidget {
  final GestureTapCallback onPressed;
  BackButtonBlue({
    Key key,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _BackButtonBlueState createState() => _BackButtonBlueState();
}

class _BackButtonBlueState extends State<BackButtonBlue> {
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
    return Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          // side: BorderSide(color: Colors.red)
        ),
        color: Color(0xff4b7aed),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 11),
              decoration: BoxDecoration(
                //  color: Color(0xff4b7aed),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                  child: Icon(
                Icons.arrow_back,
                size: 16.5,
                color: Colors.white,
              ))),
        ));
  }
}
