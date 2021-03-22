import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class OtpTextInput extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final TextEditingController controller;
  const OtpTextInput({
    Key key,
    this.hintText,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onChanged,
      controller: controller,
      maxLength: 6,
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color(0xff071232),
          fontWeight: FontWeight.w500,
          fontSize: sizer(true, 24.0, context)),
      cursorColor: Color(0xff245DE8),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: sizer(false, 20, context),
            horizontal: sizer(true, 20, context)),
        fillColor: Color(0xffF3F4F8),
        hintText: hintText,
        errorMaxLines: 5,
        hintStyle: TextStyle(
            color: Color(0xff828A95), fontSize: sizer(true, 20.0, context)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1.5,
            color: Color(0xff245DE8),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
      ),
      validator: (val) {
        if (val.length == 0) {
          return hintText + " is required";
        } else {
          return null;
        }
      },
    );
  }
}
