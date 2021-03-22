import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class BackButtonBlack extends StatefulWidget {
  final GestureTapCallback onPressed;
  BackButtonBlack({
    Key key,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _BackButtonBlackState createState() => _BackButtonBlackState();
}

class _BackButtonBlackState extends State<BackButtonBlack> {
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
        ),
        color: white.withOpacity(0.2),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                  child: Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.white,
              ))),
        ));
  }
}
