import 'package:flutter/material.dart';

class WhiteHeaderText extends StatefulWidget {
  final String title;
  WhiteHeaderText({Key key, @required this.title}) : super(key: key);

  @override
  _WhiteHeaderTextState createState() => _WhiteHeaderTextState();
}

class _WhiteHeaderTextState extends State<WhiteHeaderText> {
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
    return Text(
      '${widget.title}',
      style: TextStyle(
          color: Color(0xffE7EEFF),
          fontSize: 28.0,
          fontWeight: FontWeight.w700),
    );
  }
}
