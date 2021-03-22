import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class DecorationBox extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  DecorationBox({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _DecorationBoxState createState() => _DecorationBoxState();
}

class _DecorationBoxState extends State<DecorationBox> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _title = widget.title;
    });
  }

  String _title = "";
  Color _decoration = Color(0xff245DE8);

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
        color: _decoration,
        child: GestureDetector(
          onTap: () {
            if (_title != "SELECTED") {
              setState(() {
                _title = "SELECTED";
                _decoration = Colors.greenAccent;
              });
              widget.onPressed();
            } else
              setState(() {
                _title = "SELECT DRUG";
                _decoration = Color(0xff245DE8);
              });
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                _title,
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
