import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class IconBox extends StatefulWidget {
  final String title;
  final String imageName;
  final GestureTapCallback onPressed;
  IconBox(
      {Key key,
      @required this.title,
      @required this.onPressed,
      @required this.imageName})
      : super(key: key);
  @override
  _IconBoxState createState() => _IconBoxState();
}

class _IconBoxState extends State<IconBox> {
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
        height: 130,
        width: 115,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xffF9FBFD),
          border: Border.all(color: Color(0xffDFE8FC), width: 0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              widget.imageName,
              fit: BoxFit.contain,
              width: 36,
              height: 36,
            ),
            Text(widget.title,
                style: TextStyle(
                  color: black,
                  fontSize: pixel12,
                  fontWeight: normal,
                )),
          ],
        ),
      ),
      onTap: widget.onPressed,
    );
  }
}
