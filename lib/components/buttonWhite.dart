import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class ButtonWhite extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  ButtonWhite({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _ButtonWhiteState createState() => _ButtonWhiteState();
}

class _ButtonWhiteState extends State<ButtonWhite> {
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
        height: 55,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: darkBlue,
            fontSize: pixel14,
            fontWeight: moderate,
          ),
        ),
      ),
      onTap: widget.onPressed,
    );
  }
}
