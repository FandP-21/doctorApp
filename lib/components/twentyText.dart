import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class TwentyText extends StatefulWidget {
  final String title;
  TwentyText({Key key, @required this.title}) : super(key: key);

  @override
  _TwentyTextState createState() => _TwentyTextState();
}

class _TwentyTextState extends State<TwentyText> {
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
    return Text('${widget.title}',
        //     textAlign: widget.isCenter?TextAlign.center:TextAlign.left,
        style: TextStyle(
          fontSize: sizer(true, 20, context),
          color: Color(0xff071232),
        ));
  }
}
