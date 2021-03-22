import 'package:flutter/material.dart';

class MoreButton extends StatelessWidget {
  final Function onPressed;
  const MoreButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffDFE8FC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 11),
            decoration: BoxDecoration(
              color: Color(0xffDFE8FC),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(Icons.more_horiz, size: 23, color: Color(0xff2254D3)),
          )),
    );
  }
}
