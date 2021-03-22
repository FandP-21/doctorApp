import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class AuthUploadInput extends StatelessWidget {
  final String hintText;
  final Function onPressed;
  const AuthUploadInput({
    Key key,
    this.hintText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xffF3F4F8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: sizer(false, 20, context),
                  horizontal: sizer(true, 20, context)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    hintText,
                    style: TextStyle(
                        color: Color(0xff828A95),
                        fontSize: sizer(true, 16.0, context)),
                  ),
                  Spacer(),
                  Icon(Icons.file_upload,
                      color: Color(0xff2254D3), size: sizer(true, 16, context)),
                ],
              ),
            )));
  }
}
